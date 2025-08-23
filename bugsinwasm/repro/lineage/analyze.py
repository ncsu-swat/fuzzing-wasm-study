#!/usr/bin/env python3
"""
Usage:
  python compare_tc_vs_seeds_strict.py \
    --output-json output.json \
    --deduped-dir deduped1 \
    --seeds-output-dir seeds-output \
    --report compare_report.csv \
    --strip --ignore-empty --emit-diff \
    --verbose --debug-missing \
    --deduped-recursive --seeds-recursive
"""

import argparse
import csv
import difflib
import json
import re
import sys
from pathlib import Path
from typing import Dict, List, Optional, Tuple

# Extract ("seed_<family>_<num>", family, num) from any string containing that pattern
TAG_FAM_NUM_RE = re.compile(r"(seed_([a-zA-Z]+)_(\d+))", re.IGNORECASE)

def read_json(path: Path):
    try:
        with path.open("r", encoding="utf-8") as f:
            return json.load(f)
    except Exception as e:
        print(f"[FATAL] Cannot read JSON {path}: {e}", file=sys.stderr)
        sys.exit(2)

def extract_tag_family_num(text: str) -> Tuple[Optional[str], Optional[str], Optional[str]]:
    m = TAG_FAM_NUM_RE.search(text)
    if not m:
        return None, None, None
    tag = m.group(1)               # e.g., seed_wamr_2577
    fam = m.group(2).lower()       # e.g., wamr
    num = m.group(3)               # e.g., 2577
    return tag, fam, num

def list_files(directory: Path, recursive: bool) -> List[Path]:
    if recursive:
        return [p for p in directory.rglob("*") if p.is_file()]
    else:
        return [p for p in directory.iterdir() if p.is_file()]

def build_mapping(entries, verbose=False):
    tc_tag_to_origins: Dict[str, List[Tuple[str, str]]] = {}
    skipped = 0

    for idx, item in enumerate(entries, 1):
        tc = item.get("testcase")
        if not tc:
            skipped += 1
            continue
        tc_tag, _, _ = extract_tag_family_num(tc)
        if not tc_tag:
            skipped += 1
            continue

        origins: List[Tuple[str, str]] = []

        def add_origin(val: Optional[str]):
            if not val:
                return
            _, fam, num = extract_tag_family_num(val)
            if fam and num:
                origins.append((fam, num))

        add_origin(item.get("seed"))
        for obj in (item.get("ingredients") or []):
            if isinstance(obj, dict):
                for _, v in obj.items():
                    add_origin(v)

        # dedupe, preserve order
        seen = set()
        deduped = []
        for pair in origins:
            if pair not in seen:
                deduped.append(pair)
                seen.add(pair)

        tc_tag_to_origins[tc_tag.lower()] = deduped

    if verbose:
        print(f"[INFO] Mapping built: {len(tc_tag_to_origins)} testcases, skipped={skipped}")
        for i, (k, v) in enumerate(tc_tag_to_origins.items()):
            print(f"[INFO]  testcase_tag={k} -> origins={v}")
            if i >= 4: break

    return tc_tag_to_origins

def index_seed_outputs_by_tag(seeds_dir: Path, recursive: bool, verbose=False):
    by_tag: Dict[str, List[Path]] = {}
    files = list_files(seeds_dir, recursive)
    for p in files:
        tag, _, _ = extract_tag_family_num(p.name)
        if tag:
            by_tag.setdefault(tag.lower(), []).append(p)

    if verbose:
        print(f"[INFO] Indexed seed outputs: files={len(files)}, unique_tags={len(by_tag)}")
        shown = 0
        for t, paths in by_tag.items():
            print(f"[INFO]  {t} -> {len(paths)} files (e.g., {paths[0].name})")
            shown += 1
            if shown >= 5: break
    return by_tag

def load_text(p: Path, strip=False, ignore_empty=False) -> str:
    data = p.read_bytes()
    try:
        txt = data.decode("utf-8", errors="replace")
    except Exception:
        txt = data.decode("latin-1", errors="replace")
    if strip:
        lines = [ln.strip() for ln in txt.replace("\r\n", "\n").replace("\r", "\n").split("\n")]
        if ignore_empty:
            lines = [ln for ln in lines if ln]
        return "\n".join(lines).strip()
    return txt

def main(argv=None):
    ap = argparse.ArgumentParser(description="Compare testcase outputs vs origin seeds using runtime_number only, with base-seed fallback.")
    ap.add_argument("--output-json", required=True, type=Path, help="Path to output.json")
    ap.add_argument("--deduped-dir", required=True, type=Path, help="Directory with testcase outputs (e.g., deduped1)")
    ap.add_argument("--seeds-output-dir", required=True, type=Path, help="Directory with seed outputs (e.g., seeds-output)")
    ap.add_argument("--report", type=Path, default=Path("compare_report.csv"), help="CSV report path")
    ap.add_argument("--strip", action="store_true", help="Normalize whitespace & newlines before comparing")
    ap.add_argument("--ignore-empty", action="store_true", help="Drop empty lines when --strip is used")
    ap.add_argument("--emit-diff", action="store_true", help="Print unified diffs to stdout when files differ")
    ap.add_argument("--verbose", action="store_true", help="Print summaries")
    ap.add_argument("--debug-missing", action="store_true", help="Extra info when mapping/seed outputs are missing")
    ap.add_argument("--deduped-recursive", action="store_true", help="Recurse into subfolders of --deduped-dir")
    ap.add_argument("--seeds-recursive", action="store_true", help="Recurse into subfolders of --seeds-output-dir")
    args = ap.parse_args(argv)

    if not args.output_json.exists():
        print(f"[FATAL] --output-json not found: {args.output_json}", file=sys.stderr); sys.exit(2)
    if not args.deduped_dir.is_dir():
        print(f"[FATAL] --deduped-dir not a directory: {args.deduped_dir}", file=sys.stderr); sys.exit(2)
    if not args.seeds_output_dir.is_dir():
        print(f"[FATAL] --seeds-output-dir not a directory: {args.seeds_output_dir}", file=sys.stderr); sys.exit(2)

    # 1) JSON -> mapping
    entries = read_json(args.output_json)
    tc_tag_to_origins = build_mapping(entries, verbose=args.verbose)

    # 2) Seed index by tag
    seed_by_tag = index_seed_outputs_by_tag(args.seeds_output_dir, args.seeds_recursive, verbose=args.verbose)

    # 3) Iterate testcases in deduped
    tc_files = list_files(args.deduped_dir, args.deduped_recursive)
    if args.verbose:
        print(f"[INFO] Found {len(tc_files)} testcase output files in {args.deduped_dir} (recursive={args.deduped_recursive})")

    rows = []
    pairs = matches = diffs = 0
    no_map = 0
    missing_seed = 0
    read_errs = 0
    miss_tc_tag = 0
    fallback_pairs = fallback_matches = fallback_diffs = fallback_missing = 0

    for tc_path in sorted(tc_files, key=lambda p: p.name):
        tc_tag, _, _ = extract_tag_family_num(tc_path.name)
        if not tc_tag:
            # cannot determine runtime_number from filename
            rows.append([str(tc_path), "", "", "", "no_tc_tag"])
            miss_tc_tag += 1
            if args.debug_missing:
                print(f"[MISS][TC-TAG] {tc_path.name}: cannot extract seed_<family>_<num> from filename")
            continue

        map_key = tc_tag.lower()
        origins = tc_tag_to_origins.get(map_key)

        # Load testcase text once (only if we will try comparisons)
        tc_text = None
        try:
            tc_text = load_text(tc_path, strip=args.strip, ignore_empty=args.ignore_empty)
        except Exception as e:
            rows.append([str(tc_path), map_key, "", "", f"error_read_testcase:{e}"])
            read_errs += 1
            continue

        if not origins:
            # ---- FALLBACK: compare testcase with its own base seed tag ----
            no_map += 1
            seed_tag = map_key  # same tag as testcase
            candidates = sorted(seed_by_tag.get(seed_tag, []))
            if not candidates:
                rows.append([str(tc_path), map_key, seed_tag, "", "no_seed_found"])
                fallback_missing += 1
                if args.debug_missing:
                    print(f"[MISS][FALLBACK] {tc_path.name}: no seed outputs for base tag={seed_tag}")
                continue

            for sd_out in candidates:
                fallback_pairs += 1
                try:
                    sd_text = load_text(sd_out, strip=args.strip, ignore_empty=args.ignore_empty)
                except Exception as e:
                    rows.append([str(tc_path), map_key, seed_tag, str(sd_out), f"error_read_seed:{e}"])
                    read_errs += 1
                    continue

                equal = (tc_text == sd_text)
                status = "fallback_match" if equal else "differ"
                if equal:
                    fallback_matches += 1
                else:
                    fallback_diffs += 1
                    if args.emit_diff:
                        print(f"\n=== DIFF[FALLBACK]: testcase {tc_path.name} (tag={map_key}) "
                              f"vs seed {sd_out.name} (tag={seed_tag}) ===")
                        a_lines = tc_text.splitlines()
                        b_lines = sd_text.splitlines()
                        for line in difflib.unified_diff(a_lines, b_lines, fromfile=tc_path.name, tofile=sd_out.name, n=3):
                            print(line)

                rows.append([str(tc_path), map_key, seed_tag, str(sd_out), status])
            continue  # done with fallback comparisons

        # ---- Normal path: compare with origin seeds from mapping ----
        for (seed_fam, seed_num) in origins:
            seed_tag = f"seed_{seed_fam}_{seed_num}".lower()
            candidates = sorted(seed_by_tag.get(seed_tag, []))
            if not candidates:
                rows.append([str(tc_path), map_key, seed_tag, "", "missing_seed_out"])
                missing_seed += 1
                if args.debug_missing:
                    print(f"[MISS][SEED] {tc_path.name}: no seed outputs for tag={seed_tag}")
                continue

            for sd_out in candidates:
                pairs += 1
                try:
                    sd_text = load_text(sd_out, strip=args.strip, ignore_empty=args.ignore_empty)
                except Exception as e:
                    rows.append([str(tc_path), map_key, seed_tag, str(sd_out), f"error_read_seed:{e}"])
                    read_errs += 1
                    continue

                equal = (tc_text == sd_text)
                status = "match" if equal else "differ"
                if equal:
                    matches += 1
                else:
                    diffs += 1
                    if args.emit_diff:
                        print(f"\n=== DIFF: testcase {tc_path.name} (tag={map_key}) "
                              f"vs seed {sd_out.name} (tag={seed_tag}) ===")
                        a_lines = tc_text.splitlines()
                        b_lines = sd_text.splitlines()
                        for line in difflib.unified_diff(a_lines, b_lines, fromfile=tc_path.name, tofile=sd_out.name, n=3):
                            print(line)

                rows.append([str(tc_path), map_key, seed_tag, str(sd_out), status])

    # 4) Write CSV
    try:
        args.report.parent.mkdir(parents=True, exist_ok=True)
        with args.report.open("w", newline="", encoding="utf-8") as f:
            w = csv.writer(f)
            w.writerow(["testcase_file", "testcase_tag", "origin_seed_tag", "seed_file", "status"])
            w.writerows(rows)
        print(f"[OK] Wrote report: {args.report}")
        print(f"[STATS] normal_pairs={pairs}, matches={matches}, diffs={diffs}, "
              f"fallback_pairs={fallback_pairs}, fallback_matches={fallback_matches}, fallback_diffs={fallback_diffs}, "
              f"no_tc_tag={miss_tc_tag}, no_mapping_for_testcase={no_map}, "
              f"missing_seed_out={missing_seed}, fallback_missing_seed_out={fallback_missing}, "
              f"read_errors={read_errs}")
    except Exception as e:
        print(f"[ERROR] Failed to write report {args.report}: {e}", file=sys.stderr)
        sys.exit(2)

if __name__ == "__main__":
    main()

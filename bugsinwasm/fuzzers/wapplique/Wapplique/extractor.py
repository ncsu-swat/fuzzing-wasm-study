#!/usr/bin/env python3
import re
import json
import argparse
from pathlib import Path
from collections import defaultdict

LINE_RE = re.compile(
    r"\*{3}TestCase:(?P<testcase>.+?)"
    r",SplitFragment:(?P<fragment>.+?)"
    r",SplitOrigin:(?P<origin>.+?)"
    r"\*{3}"
)

def parse_log(log_path):
    groups = defaultdict(lambda: {"ingredients": []})
    total = matches = 0

    with open(log_path) as f:
        for line in f:
            total += 1
            line = line.strip()
            m = LINE_RE.search(line)
            if not m:
                continue
            matches += 1

            tc   = m.group("testcase")
            frag = m.group("fragment")
            orig = m.group("origin")

            stem = Path(tc).stem
            parts = stem.split("_", 2)
            if len(parts) < 2:
                print(f"line {total}: bad stem '{stem}'")
                continue
            seed_id = parts[1]

            info = groups[tc]
            info["seed_id"] = seed_id
            info["ingredients"].append({frag: Path(orig).name})

    print(f"Read {total} lines, found {matches} matches.")
    return groups

def build_output(groups):
    out = []
    for tc, info in groups.items():
        p = Path(tc)
        parts = p.parts
        if "case" in parts:
            idx = parts.index("case")
            root = Path(*parts[:idx])
        else:
            root = p.parent.parent

        seed_path = root / "llvm-testsuite" / f"seed-{info['seed_id']}.wasm"

        out.append({
            "testcase":   tc,
            "seed":       tc.split("-")[-1],
            "ingredients": info["ingredients"]
        })
    return out

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("logfile")
    parser.add_argument("-o","--output", default="output.json")
    args = parser.parse_args()

    groups = parse_log(args.logfile)
    data   = build_output(groups)

    with open(args.output, "w") as fo:
        json.dump(data, fo, indent=2)

    print(f"Wrote {len(data)} records to {args.output}")

if __name__ == "__main__":
    main()

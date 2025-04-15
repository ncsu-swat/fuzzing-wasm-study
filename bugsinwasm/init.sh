SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" &> /dev/null && pwd)"
export BUGSINWASM_HOME="$SCRIPT_DIR"
echo "ENV_VAR BUGSINWASM_HOME is set to \"$SCRIPT_DIR\""

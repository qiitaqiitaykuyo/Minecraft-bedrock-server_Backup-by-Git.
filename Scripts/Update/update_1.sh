#!/bin/bash
baseDIR="$(dirname -- $(realpath -- "${BASH_SOURCE[0]:-$0}"))"
find "$baseDIR" -type f -name "update_2.sh" -exec bash -- {} +


#!/bin/bash
updateDIR="$(dirname -- $(realpath -- "${BASH_SOURCE[0]:-$0}"))"
echo "$updateDIR"
echo "${updateDIR%/Scripts/Update}"


echo Updated.

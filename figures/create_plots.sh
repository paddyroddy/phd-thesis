#!/usr/bin/env bash

ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")"

for i in {2..5}; do
    echo chapter: ${i}
    ${ROOT_DIR}/chapter${i}/chapter${i}.sh
done

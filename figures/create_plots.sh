#!/bin/bash
for i in {2..4}; do
    echo chapter: $i
    ./chapter$i/chapter$i.sh
done

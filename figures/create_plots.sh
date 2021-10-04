#!/bin/bash
for i in {3..5}; do
    echo chapter: $i
    ./chapter$i/chapter$i.sh
done

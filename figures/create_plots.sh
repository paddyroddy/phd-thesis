#!/bin/bash
for i in {2..5}; do
    echo chapter: $i
    ./figures/chapter$i/chapter$i.sh
done

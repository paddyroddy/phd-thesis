#!/bin/bash
L=128
l_max=4

for l in $(seq 0 $l_max); do
    for m in $(seq 0 $l); do
        echo l: $l, m: $m
        sphere spherical_harmonic \
            -e $l $m \
            -L $L \
            -z
    done
done

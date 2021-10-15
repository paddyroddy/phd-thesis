#!/bin/bash
L=128
l_max=4
PLOTS=$HOME/project/src/s2sleplet/pys2sleplet/plotting/polar_cap

for l in $(seq 0 $l_max); do
    for m in $(seq 0 $l); do
        echo l: $l, m: $m
        sphere spherical_harmonic \
            -e $l $m \
            -L $L \
            -z
    done
done

echo fried egg
python $PLOTS/fried_egg.py

echo colatidue
python $PLOTS/eigenfunctions.py

echo eigenvalues
python $PLOTS/eigenvalues.py

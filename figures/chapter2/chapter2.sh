#!/bin/bash
B=3
ELL_RANGE=$(seq 0 4)
J_MIN=2
J_RANGE=$(seq 0 3)
L=128
PLOTS=$HOME/project/src/s2sleplet/pys2sleplet/plotting/polar_cap

echo scaling function
sphere axisymmetric_wavelets \
    -L 128 \
    -u

for j in $J_RANGE; do
    echo wavelet j: $j
    sphere axisymmetric_wavelets \
        -e $B $J_MIN $j \
        -L $L \
        -u
done

for l in $ELL_RANGE; do
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

#!/bin/bash
ALPHA=0.75
BETA=0.125
L=128
L_SIGMA=$(seq 1 2)

echo figure: 2
sphere earth \
    -L $L \
    -t $TYPE

for ell in $L_SIGMA; do
    echo figure: 1, l_sigma: $ell
    sphere harmonic_gaussian \
        -a $ALPHA \
        -b $BETA \
        -e $ell 1 \
        -L $L \
        -m translate \
        -o \
        -t $TYPE

    echo figure: 3, l_sigma: $ell
    sphere harmonic_gaussian \
        -c earth \
        -e $ell 1 -L $L \
        -t $TYPE
done

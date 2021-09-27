#!/bin/bash
ALPHA=0.75
BETA=0.125
FUNCTIONS=(gaussian elongated_gaussian squashed_gaussian)
L=128
L_SIGMA=$(seq 1 2)

for f in $FUNCTIONS; do
    echo figure: $f north
    sphere $f \
        -L $L

    echo figure: $f translated
    sphere $f \
    -a $ALPHA \
    -b $BETA \
    -m translate \
    -o
done

for ell in $L_SIGMA; do
    echo figure: harmonic Gaussian north, l_sigma: $ell
    sphere harmonic_gaussian \
        -e $ell 1 \
        -L $L

    echo figure: harmonic Gaussian translated, l_sigma: $ell
    sphere harmonic_gaussian \
        -a $ALPHA \
        -b $BETA \
        -e $ell 1 \
        -L $L \
        -m translate \
        -o

    echo figure: harmonic Gaussian convolved, l_sigma: $ell
    sphere harmonic_gaussian \
        -c earth \
        -e $ell 1 \
        -L $L
done

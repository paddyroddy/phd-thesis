#!/bin/bash
B=3
J_MIN=2
J_RANGE=$(seq 0 4)
L_ARBITRARY=128
MATPLOTLIB_PLOTS=$HOME/project/src/s2sleplet/pys2sleplet/plotting/arbitrary
P_RANGE=(
    0
    9
    24
    49
    99
    199
)
SIGMA=(
    2
    3
    5
)
SMOOTHING=2
SNR=-10

echo figure: 2
python $MATPLOTLIB_PLOTS/tiling.py

echo figure: 3, Earth
sphere earth \
    -L $L_ARBITRARY \
    -s $SMOOTHING \
    -t $TYPE \
    -u
echo figure: 3, Slepian South America
sphere slepian_south_america \
    -L $L_ARBITRARY \
    -s $SMOOTHING \
    -t $TYPE \
    -u

for p in ${P_RANGE[@]}; do
    echo figure: 4, p: $p
    sphere slepian \
        -e $p \
        -L $L_ARBITRARY \
        -t $TYPE \
        -u
done

echo figure: 6, scaling
sphere slepian_wavelets \
    -L $L_ARBITRARY \
    -t $TYPE \
    -u
echo figure: 7, scaling
sphere slepian_wavelet_coefficients \
    -L $L_ARBITRARY \
    -s $SMOOTHING \
    -t $TYPE \
    -u

for j in $J_RANGE; do
    echo figure: 6, j: $j
    sphere slepian_wavelets \
        -e $B $J_MIN $j \
        -L $L_ARBITRARY \
        -t $TYPE \
        -u

    echo figure: 7, j: $j
    sphere slepian_wavelet_coefficients \
        -e $B $J_MIN $j \
        -L $L_ARBITRARY \
        -s $SMOOTHING \
        -t $TYPE \
        -u
done

echo figure: 8, noised
sphere slepian_south_america \
    -L $L_ARBITRARY \
    -n $SNR \
    -s $SMOOTHING \
    -t $TYPE \
    -u

for s in ${SIGMA[@]}; do
    echo figure: 8, sigma: $s
    python \
        $MATPLOTLIB_PLOTS/denoising_slepian_south_america.py \
        -n $SNR \
        -s $s
done

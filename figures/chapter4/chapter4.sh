#!/usr/bin/env bash
B=3
J_MIN=2
J_RANGE=$(seq 0 4)
L=128
P_RANGE=(
    0
    9
    24
    49
    99
    199
)
PLOTS=${HOME}/project/src/s2sleplet/pys2sleplet/plotting/arbitrary/south_america
SIGMA=(
    2
    3
    5
)
SMOOTHING=2
SNR=-10

echo figure: 2, tiling
python ${PLOTS}/tiling_south_america.py

echo figure: 3, Earth
sphere earth \
    -L ${L} \
    -s ${SMOOTHING} \
    -u
echo figure 3: Slepian South America
sphere slepian_south_america \
    -L ${L} \
    -s ${SMOOTHING} \
    -u

for p in ${P_RANGE[@]}; do
    echo figure: 4, Slepian p: ${p}
    sphere slepian \
        -e ${p} \
        -L ${L} \
        -u
done

echo figure: 5, eigenvalues
python ${PLOTS}/eigenvalues_south_america.py

echo figure: 6, scaling wavelet
sphere slepian_wavelets \
    -L ${L} \
    -u
echo figure: 7, scaling wavelet coefficient
sphere slepian_wavelet_coefficients_south_america \
    -L ${L} \
    -s ${SMOOTHING} \
    -u

for j in ${J_RANGE}; do
    echo figure: 6, wavelet j: ${j}
    sphere slepian_wavelets \
        -e ${B} ${J_MIN} ${j} \
        -L ${L} \
        -u

    echo figure: 7, wavelet coefficient j: ${j}
    sphere slepian_wavelet_coefficients_south_america \
        -e ${B} ${J_MIN} ${j} \
        -L ${L} \
        -s ${SMOOTHING} \
        -u
done

echo figure: 8, noised
sphere slepian_south_america \
    -L ${L} \
    -n ${SNR} \
    -s ${SMOOTHING} \
    -u

for s in ${SIGMA[@]}; do
    echo figure: 8, denoised sigma: ${s}
    python \
        ${PLOTS}/denoising_slepian_south_america.py \
        -n ${SNR} \
        -s ${s}
done

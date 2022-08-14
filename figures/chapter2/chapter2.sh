#!/usr/bin/env bash
B=3
ELL_RANGE=$(seq 0 4)
J_MIN=2
J_RANGE=$(seq 0 3)
L=128
PLOTS=${HOME}/project/src/s2sleplet/pys2sleplet/plotting

for ell in ${ELL_RANGE}; do
    for m in $(seq 0 ${ell}); do
        echo figure: 1, ell: ${ell}, m: ${m}
        sphere spherical_harmonic \
            -e ${ell} ${m} \
            -L ${L} \
            -u \
            -z
    done
done

echo figure: 2, ricker wavelets
python ${PLOTS}/misc/wavelet_transform.py

echo figure: 3, wavelet tiling
python ${PLOTS}/wavelets/axisymmetric_tiling.py

echo figure: 4, scaling function
sphere axisymmetric_wavelets \
    -L ${L} \
    -u

for j in ${J_RANGE}; do
    echo figure: 4, wavelet j: ${j}
    sphere axisymmetric_wavelets \
        -e ${B} ${J_MIN} ${j} \
        -L ${L} \
        -u
done

echo figure: 5, eigenvalues
python ${PLOTS}/polar_cap/eigenvalues.py

echo figure: 6, fried egg
python ${PLOTS}/polar_cap/fried_egg.py

echo figure: 7, colatidue
python ${PLOTS}/polar_cap/eigenfunctions.py

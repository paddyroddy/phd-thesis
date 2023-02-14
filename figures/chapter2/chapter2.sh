#!/usr/bin/env bash
ANGLES="0,0,0.25 0,0.25,0.25 0.25,0.25,0.25"
B=3
ELL_RANGE=$(seq 0 4)
J_MIN=2
J_RANGE=$(seq 0 3)
L=128
P_SIGMA=-1
PLOTS=${HOME}/project/src/sleplet/sleplet/plotting
ROTATION=elongated_gaussian
T_SIGMA=-1

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

echo figure: 2, rotations
sphere ${ROTATION} \
    -e ${T_SIGMA} ${P_SIGMA} \
    -L ${L}
for angle in ${ANGLES}; do
    read -r a b g <<< $(echo ${angle} | tr ',' ' ')
    echo figure: 2, angle ${angle}
    sphere ${ROTATION} \
        -e ${T_SIGMA} ${P_SIGMA} \
        -L ${L} \
        -m rotate \
        -a ${a} \
        -b ${b} \
        -g ${g}
done

echo figure: 3, ricker wavelets
python ${PLOTS}/misc/wavelet_transform.py

echo figure: 4, wavelet tiling
python ${PLOTS}/wavelets/axisymmetric_tiling.py

echo figure: 5, scaling function
sphere axisymmetric_wavelets \
    -L ${L} \
    -u

for j in ${J_RANGE}; do
    echo figure: 5, wavelet j: ${j}
    sphere axisymmetric_wavelets \
        -e ${B} ${J_MIN} ${j} \
        -L ${L} \
        -u
done

echo figure: 6, eigenvalues
python ${PLOTS}/polar_cap/eigenvalues.py

echo figure: 7, fried egg
python ${PLOTS}/polar_cap/fried_egg.py

echo figure: 8, colatidue
python ${PLOTS}/polar_cap/eigenfunctions.py

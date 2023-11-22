#!/usr/bin/env bash
ALPHA=0.75
BETA=0.125
FUNCTIONS=(gaussian elongated_gaussian squashed_gaussian)
L=128
L_SIGMA=$(seq 1 2)

echo figure: 5, earth
sphere earth \
    -L "${L}"

for f in "${FUNCTIONS[@]}"; do
    echo "${f}" north
    sphere "${f}" \
        -L "${L}"

    echo "${f}" translated
    sphere "${f}" \
    -a "${ALPHA}" \
    -b "${BETA}" \
    -L "${L}" \
    -m translate \
    -o
done

for ell in ${L_SIGMA}; do
    echo harmonic Gaussian north, l_sigma: "${ell}"
    sphere harmonic_gaussian \
        -e "${ell}" 1 \
        -L "${L}"

    echo harmonic Gaussian translated, l_sigma: "${ell}"
    sphere harmonic_gaussian \
        -a "${ALPHA}" \
        -b "${BETA}" \
        -e "${ell}" 1 \
        -L "${L}" \
        -m translate \
        -o

    echo harmonic Gaussian convolved, l_sigma: "${ell}"
    sphere harmonic_gaussian \
        -c earth \
        -e "${ell}" 1 \
        -L "${L}"
done

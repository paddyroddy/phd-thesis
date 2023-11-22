#!/usr/bin/env bash
B=3
J_MIN=2
J_RANGE=$(seq 0 4)
MESH=homer
OTHER_MESHES=(
    bird
    cheetah
    cube
    dragon
    teapot
)
P_RANGE=(
    0
    9
    24
    49
    99
    199
)
RANK_RANGE=$(seq 2 9)
SIGMA=2
SNR=-5

for r in ${RANK_RANGE}; do
    echo figure: 2, r: "${r}"
    mesh "${MESH}" \
        -e "${r}" \
        -u
done

echo figure: 4
python -m \
    sleplet.plotting.mesh.mesh_tiling \
    "${MESH}"

echo figure: 5
python -m \
    sleplet.plotting.mesh.mesh_region \
    "${MESH}"

for p in "${P_RANGE[@]}"; do
    echo figure: 6, p: "${p}"
    mesh "${MESH}" \
        -m slepian_functions \
        -e "${p}" \
        -u \
        -z
done

echo figure: 7
python -m \
    sleplet.plotting.mesh.mesh_slepian_eigenvalues \
    "${MESH}"

echo figure: 8, scaling
mesh "${MESH}" \
    -m slepian_wavelets \
    -u \
    -z

echo figure: 9, field
mesh "${MESH}" \
    -m field \
    -u

for j in ${J_RANGE}; do
    echo figure: 8, j: "${j}"
    mesh "${MESH}" \
        -e "${B}" "${J_MIN}" "${j}" \
        -m slepian_wavelets \
        -u \
        -z

    echo figure: 10, j: "${j}"
    mesh "${MESH}" \
        -e "${B}" "${J_MIN}" "${j}" \
        -m slepian_wavelet_coefficients \
        -u \
        -z
done

echo figure: 10, scaling
mesh "${MESH}" \
    -m slepian_wavelet_coefficients \
    -u \
    -z

echo figure: 11, original
mesh "${MESH}" \
    -m slepian_field \
    -u \
    -z

echo figure: 11, noised
mesh "${MESH}" \
    -m slepian_field \
    -n "${SNR}" \
    -u \
    -z

echo figure: 11, denoised
python -m \
    sleplet.plotting.mesh.denoising_slepian_mesh \
    "${MESH}" \
    -n "${SNR}" \
    -s "${SIGMA}"

for f in "${OTHER_MESHES[@]}"; do
    echo figure: 12, mesh: "${f}"
    python -m \
        sleplet.plotting.mesh.mesh_region \
        "${f}"
done

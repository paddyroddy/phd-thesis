#!/bin/bash
B=3
J_MIN=2
J_RANGE=$(seq 0 4)
MATPLOTLIB_PLOTS=$HOME/project/src/s2sleplet/pys2sleplet/plotting/mesh
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
SIGMA=$(seq 1 2)
SNR=-10

for r in ${RANK_RANGE[@]}; do
    echo figure: 2, r: $r
    mesh $MESH \
        -e $r
done

echo figure: 3
python \
    $MATPLOTLIB_PLOTS/mesh_tiling.py \
    $MESH

echo figure: 4
python \
    $MATPLOTLIB_PLOTS/mesh_region.py \
    $MESH

for p in ${P_RANGE[@]}; do
    echo figure: 5, p: $p
    mesh $MESH \
        -m slepian \
        -e $p \
        -u \
        -z
done

echo figure: 6
python \
    $MATPLOTLIB_PLOTS/mesh_slepian_eigenvalues.py \
    $MESH

echo figure: 7, field
mesh $MESH \
    -m field \
    -u
echo figure: 7, Slepian field
mesh $MESH \
    -m slepian_field \
    -u \
    -z

echo figure: 8, scaling
mesh $MESH \
    -m wavelets \
    -u \
    -z
echo figure: 9, scaling
mesh $MESH \
    -m coefficients \
    -u \
    -z

for j in $J_RANGE; do
    echo figure: 8, j: $j
    mesh $MESH \
        -e $B $J_MIN $j \
        -m wavelets \
        -u \
        -z

    echo figure: 9, j: $j
    mesh $MESH \
        -e $B $J_MIN $j \
        -m coefficients \
        -u \
        -z
done

echo figure: 10, noised
mesh $MESH \
    -m slepian_field \
    -n $SNR \
    -u \
    -z

for s in ${SIGMA[@]}; do
    echo figure: 10, sigma: $s
    python \
        $MATPLOTLIB_PLOTS/denoising_slepian_mesh.py \
        $MESH \
        -n $SNR \
        -s $s
done

for f in ${OTHER_MESHES[@]}; do
    echo figure: 11, mesh: $f
    python \
        $MATPLOTLIB_PLOTS/mesh_region.py \
        $f
done

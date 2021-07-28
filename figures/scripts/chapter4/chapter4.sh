#!/bin/bash
MESH=homer
P_RANGE=(
    0
    9
    24
    49
    99
    199
)
RANK_RANGE=$(seq 2 9)

for r in ${RANK_RANGE[@]}; do
    echo figure: , r: $r
    mesh $MESH \
        -e $r
done

echo figure:
mesh $MESH \
    -m field
echo figure:
mesh $MESH \
    -m slepian_field

for p in ${P_RANGE[@]}; do
    echo figure: , p: $p
    mesh $MESH \
        -m slepian \
        -e $p
done

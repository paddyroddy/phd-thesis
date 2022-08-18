# clean all files -c
$clean_ext = "\
    %R-blx.bib \
    auxlock
    bbl \
    bcf \
    fdb_latexmk \
    run \
    run.xml \
    synctex.gz \
    synctex.gz(busy)\
    tdo \
    tex.bak \
    ";

# file to build
@default_files = ('thesis.tex');

# lualatex options
$lualatex = "lualatex --shell-escape %O %S";

# use lualatex
$pdf_mode = 4;

# make bbl files regeneratable
$bibtex_use = 2;

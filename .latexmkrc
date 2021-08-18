# clean all files -c
$clean_ext = "auxlock bbl";

# file to build
@default_files = ('thesis.tex');

# lualatex options
$lualatex = "lualatex --shell-escape %O %S";

# use lualatex
$pdf_mode = 4;

# build silently
$silent = 1;

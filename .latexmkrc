# clean all files -c
$clean_ext = "auxlock bak* bbl run.xml";

# file to build
@default_files = ('thesis.tex');

# lualatex options
$lualatex = "lualatex --shell-escape %O %S";

# use lualatex
$pdf_mode = 4;

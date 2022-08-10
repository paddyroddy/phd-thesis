# clean all files -c
$clean_ext = "synctex.gz synctex.gz(busy) run.xml tex.bak bbl bcf fdb_latexmk run tdo %R-blx.bib";

# file to build
@default_files = ('thesis.tex');

# lualatex options
$lualatex = "lualatex --shell-escape %O %S";

# use lualatex
$pdf_mode = 4;

# make bbl files regeneratable
$bibtex_use = 2;

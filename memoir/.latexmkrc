$always_view_file_via_temporary=1;
$aux_dir=".build";
@default_files=("main.tex");
$dvips="dvips %O -R0 -t a4 -o %D %S";
$pdf_mode=2;
$latex="latex -shell-escape -file-line-error %O %S";
$out_dir=".build";
$recorder=1;

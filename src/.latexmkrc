# minted / graphviz が shell-escape を必要とするため付与する。
$pdf_mode = 4;    # LuaLaTeX で PDF を生成
$lualatex = 'lualatex --shell-escape %O %S';

# 参考文献は junsrt + pBibTeX 構成。biber ではなく pbibtex を明示する。
$bibtex = 'pbibtex %O %S';
$bibtex_use = 2;  # \bibliography があれば bbl の有無に関わらず実行する

$out_dir = '.';

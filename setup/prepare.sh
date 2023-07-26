#!/bin/ash
set -e
set -x
cd ${HOME}
mkdir -p texmf/tex/latex/local
mkdir setuplatex
cd setuplatex

# install gensymb
if [ ! -f "${HOME}/texmf/tex/latex/local/gensymb.sty" ]; then
wget https://mirrors.ctan.org/macros/latex/contrib/gensymb.zip
unzip gensymb.zip
cd gensymb
latex -interaction=nonstopmode -halt-on-error gensymb.ins
echo "Directory after latex execution"
ls -lah
cp gensymb.sty ${HOME}/texmf/tex/latex/local/
cd ../
fi
# install lastpage
if [ ! -f "${HOME}/texmf/tex/latex/lastpage/lastpage.sty" ]; then
wget http://mirrors.ctan.org/macros/latex/contrib/lastpage.zip
unzip lastpage.zip
DSTLOC="${HOME}/texmf/tex/latex/lastpage"
mkdir -p "${DSTLOC}"
cd lastpage
tex -interaction=nonstopmode -halt-on-error lastpage.dtx
echo "Directory after tex execution"
ls -lah
cp lastpage.sty "${DSTLOC}"
cp lastpage209.sty "${DSTLOC}"
cp lastpage2e.sty "${DSTLOC}"
cp lastpageclassic.sty "${DSTLOC}"
cp lastpagemodern.sty "${DSTLOC}"
cd ../
fi

# cleanup once we are finished
# not required for ephemeral containers
cd ../
rm -r setuplatex


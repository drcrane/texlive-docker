#!/bin/sh
# this script requires that texlive:1 image is available
[ ! -d mytexmf ] && mkdir mytexmf
docker run --rm -it \
	-v ${PWD}/setup:/home/user/setup \
	-v ${PWD}/mytexmf:/home/user/texmf \
	texlive:1 setup/prepare.sh
docker run --rm -it \
	-v ${PWD}/example:/home/user/example \
	-v ${PWD}/mytexmf:/home/user/texmf:ro \
	texlive:1 \
	sh -c 'cd example ; compileall.sh'

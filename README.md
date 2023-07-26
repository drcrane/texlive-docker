# Alpine Linux TeXLive Container

## Purpose

Build PDF documents from a machine with Docker available (maybe also
Podman or something in the future).

## Theory of Operation

1. Install Alpine Linux
2. Install `texlive-xelatex`
3. Setup latex home environment

## Usage

Build the container:

    docker build --tag texlive:1 .

Run the container (interactively):

    docker run --rm -it texlive:1

Notice that the `--rm` switch is used here, this means that once the
container exits any files within will be deleted. To avoid these files
being deleted volumes are exported.

It is recommended that besides the documents directory that the
`texmf` directory is also exported to the host, to allow for
installation of custom packages etc.

Install packages using a local `texmf` directory:

    mkdir mytexmf
    docker run --rm -it \
        -v ${PWD}/setup:/home/user/setup \
        -v ${PWD}/mytexmf:/home/user/texmf \
        texlive:1 setup/prepare.sh

Compile a tex file:

     docker run --rm -it \
        -v ${PWD}/example:/home/user/example \
        -v ${PWD}/mytexmf:/home/user/texmf:ro \
        texlive:1 \
        sh -c 'cd example ; xelatex -interaction=nonstopmode -halt-on-error example.tex'

### Example

To compile the example document the container must be built and tagged,
as the first step above, then `./makeexample.sh` may be executed which
should make `example.pdf` in `example/`.

### Better Usage

A helpful `compileall.sh` script is provided to help with the boring
task of compiling `.tex` files:

Compile all `.tex` files in the current directory that do not have a
`.pdf` file or are newer than the `.pdf` file.

     docker run --rm -it -v ${PWD}:/home/user/documents texlive:1 sh -c \
        'cd documents && compileall.sh'


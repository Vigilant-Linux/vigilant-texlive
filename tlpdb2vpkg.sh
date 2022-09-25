#!/bin/bash

TEXMF=usr/share/texmf-dist
YEAR=$(./tlyear.sh)
pkgver=$YEAR.$(awk -F/ '$1 == "depend revision" {print $2; exit}' texlive.tlpdb)

set -e

tmpdir=$(mktemp -d textmp.XXXXXXXX)
tmpdir=$(realpath "$tmpdir")
db=$(realpath texlive.tlpdb)

pushd $tmpdir
mkdir -p usr/share/tlpkg
cp $db usr/share/tlpkg

dependencies+=" texlive>=${YEAR}"

popd

mkdir -p binpkgs
cd binpkgs

vpkg-create \
        -A "noarch" \
        -B texlive2vpkg \
        -D "$dependencies" \
        -H "https://www.tug.org/texlive/" \
        -l "Public Domain" \
        -m "texlive2vpkg <texlive2vpkg@vigilantlinux.glitch.me>" \
        -n "texlive-tlpdb-${pkgver}_1" \
        -s "TeX Live package database" \
        "$tmpdir"
        
rm -rf "$tmpdir"

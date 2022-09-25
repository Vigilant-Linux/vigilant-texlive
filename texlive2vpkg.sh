#!/bin/bash

TEXMF=usr/share/texmf-dist
YEAR=$(./tlyear.sh)

set -e

archive=$(realpath "$1")

tmpdir=$(mktemp -d textmp.XXXXXXXX)
tmpdir=$(realpath "$tmpdir")

pushd $tmpdir
mkdir -p $TEXMF
cd $TEXMF
tar xvf "$archive"

#!/bin/sh

mkdir -p binpkgs
./findmissing.sh | xargs -d'\n' -l -n1 -P $(nproc) ${DRYRUN:+echo} ./texlive2vpkg.sh
./tlpdb2vpkg.sh
VPKG_ARCH=i686 vpkg-rindex -f -a binpkgs/*.vpkg
VPKG_ARCH=x86_64 vpkg-rindex -f -a binpkgs/*.vpkg

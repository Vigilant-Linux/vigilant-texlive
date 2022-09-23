#!/bin/sh

<texlive.tlpdb awk -v year=$(.tlyear.sh) '
  $1 == "name" && $2 ~ /^00/ { pkgname = 0; next }
  $1 == "name" && $2 == "texlive.infra" { $2 = "texlive-infra" }
  $1 == "name" && $2 ~ /\./ && $2 !~ /(i386|x86_64)-linux$/ { pkgname = 0; next }
  $1 == "name" {
        sub("\\.infra", "-infra", $2)
        split

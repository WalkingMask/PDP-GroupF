#!/bin/sh
set -e

# build.sh
# 2016/07/27(Wed)
# Kazuki Nagamine

if [ "$1" = "-r" ]; then
  rm kaprekar_s kaprekar_p
  exit 0
fi

go build kaprekar_s.go
go build kaprekar_p.go

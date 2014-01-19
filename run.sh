#!/bin/bash
set -e
ghc --make -O2 Main -o dilweb
find . -name "*.hi" | xargs -I file rm -f file
./dilweb -i ./Example/main.nw

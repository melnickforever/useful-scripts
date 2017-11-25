#!/usr/bin/env bash
find ./ -name '*.png' -print0 -print0|xargs -n2 -P4 -0 convert -strip
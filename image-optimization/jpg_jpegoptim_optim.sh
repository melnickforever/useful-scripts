#!/usr/bin/env bash
find ./ -name '*.jpg' -print0|xargs -n1 -P4 -0 jpegoptim --strip-all
find ./ -name '*.jpg' -print0 | xargs -n1 -P4 -0 mogrify -verbose -strip -type optimize -format jpg -flatten -interlace Plane


#!/usr/bin/env bash
find ./ -name '*.jpg' -print0 -print0|xargs -n2 -P4 -0 convert -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace RGB

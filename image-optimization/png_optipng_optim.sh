#!/usr/bin/env bash
find ./  -regex '.*\.\(png\|jpg\)' -print0 | xargs -n1 -P4 -0 optipng -strip all -o5
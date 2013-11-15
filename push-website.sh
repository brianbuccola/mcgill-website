#!/bin/bash
#
# vim:              set ft=sh tw=79 sw=4:
# file:             push-website.sh
# author:           Brian Buccola
#
# description:      Push website changes onto McGill server.

src="${HOME}/website"
dest="mcgill:/home/bbucco/public_html"
excl="${src}/.push-website/exclude-list"
log="${src}/.push-website/log"

rsync \
    -avhhh \
    --copy-unsafe-links \
    --exclude-from=${excl} \
    --log-file=${log} \
    ${src}/ ${dest}/

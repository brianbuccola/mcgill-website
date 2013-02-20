#!/bin/bash
#
# vim:              set ft=sh tw=79 sw=4:
# file:             push-website.sh
# author:           Brian Buccola
#
# description:      Push website changes onto McGill server.

SRC="$HOME/website"
DEST="mcgill:/home/bbucco/public_html"
EXCL="$SRC/.push-website/exclude-list"
LOG="$SRC/.push-website/log"

rsync \
    -avhhh -e "ssh -i $HOME/.ssh/id_rsa.mcgill" \
    --exclude-from=$EXCL \
    --log-file=$LOG \
    $SRC/ $DEST/

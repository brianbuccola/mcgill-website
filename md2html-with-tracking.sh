#!/bin/bash
#
# vim:              set ft=sh tw=79 sw=4:
# file:             md2html_with_tracking.sh
# author:           Brian Buccola
#
# description:      Coverts index.markdown into index.html using pandoc, while
#                   also adding Google Analytics tracking to <a href...>
#                   elements.

IN_FILE="./index.markdown"
OUT_FILE="./index.html"
HEADER="./header.html"

ONCLICK_PDF="_gaq.push(['_trackEvent','Download','PDF',this.href]);"
ONCLICK_TEX="_gaq.push(['_trackEvent','Download','TEX',this.href]);"

if [[ ! -f "$IN_FILE" ]]; then
    echo "Error: cannot find input markdown file."
    echo "Check that $IN_FILE exists."
    exit 1
fi

if [[ ! -f "$HEADER" ]]; then
    echo "Error: cannot find header file."
    echo "Check that $HEADER exists."
    exit 1
fi

pandoc -S -s -H "$HEADER" -f markdown -t html5 "$IN_FILE"     |\
    sed "s|<a[^>]*\.pdf[^>]*|& onclick=\"$ONCLICK_PDF\"|g"    |\
    sed "s|<a[^>]*\.tex[^>]*|& onclick=\"$ONCLICK_TEX\"|g"     \
    > $OUT_FILE

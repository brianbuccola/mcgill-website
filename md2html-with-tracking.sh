#!/bin/bash
#
# vim:              set ft=sh tw=79 sw=4:
# file:             md2html_with_tracking.sh
# author:           Brian Buccola
#
# description:      Coverts index.markdown into index.html using pandoc, while
#                   also adding Google Analytics tracking to <a href...>
#                   elements.

PG_TITLE="Brian Buccola"
AUTHOR="Brian Buccola"

IN_FILE="./index.markdown"
OUT_FILE="./index.html"

HEADER="./header.html"
BODY="./body.html"
FOOTER="./footer.html"

ONCLICK_PDF="_gaq.push(['_trackEvent','Download','PDF',this.href]);"
ONCLICK_TEX="_gaq.push(['_trackEvent','Download','TEX',this.href]);"

file_check() {
    if [[ ! -f "$1" ]]; then
        echo "Error: cannot find file ${1}."
        exit 1
    fi
}

file_check "$IN_FILE"
file_check "$HEADER"
file_check "$BODY"
file_check "$FOOTER"

pandoc -S -H "$HEADER" -B "$BODY" -A "$FOOTER"                  \
    -V pagetitle="$PG_TITLE" -V author-meta="$AUTHOR"           \
    --mathjax -f markdown -t html5 "$IN_FILE"               |   \
    sed "s|<a[^>]*\.pdf[^>]*|& onclick=\"$ONCLICK_PDF\"|g"  |   \
    sed "s|<a[^>]*\.tex[^>]*|& onclick=\"$ONCLICK_TEX\"|g"      \
    > $OUT_FILE

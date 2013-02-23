#!/bin/bash
#
# vim:              set ft=sh tw=79 sw=4:
# file:             md2html_with_tracking.sh
# author:           Brian Buccola
#
# description:      Coverts index.markdown into index.html using pandoc, while
#                   also adding Google Analytics tracking to <a href...> tags.

PG_TITLE="Brian Buccola"
AUTHOR="Brian Buccola"

IN_FILE="./index.markdown"
OUT_FILE="./index.html"

CSS="./mystyle.css"
HEADER="./header.html"
BEFORE="./before-body.html"
AFTER="./after-body.html"

ONCLICK_PDF="_gaq.push(['_trackEvent','Download','PDF',this.href]);"
ONCLICK_TEX="_gaq.push(['_trackEvent','Download','TEX',this.href]);"

# Check if given file exists.
file_check() {
    if [[ ! -f "$1" ]]; then
        echo "Error: cannot find file ${1}."
        exit 1
    fi
}

# Files to check.
FILES=("$IN_FILE" "$CSS" "$HEADER" "$BEFORE" "$AFTER")

for f in "${FILES[@]}"; do
    file_check "$f"
done

# Convert markdown to html5, and add onclick text to link tags.
pandoc -S -c "$CSS" -H "$HEADER" -B "$BEFORE" -A "$AFTER"       \
    -V pagetitle="$PG_TITLE" -V author-meta="$AUTHOR"           \
    --mathjax -f markdown -t html5 "$IN_FILE"               |   \
    sed "s|<a[^>]*\.pdf[^>]*|& onclick=\"$ONCLICK_PDF\"|g"  |   \
    sed "s|<a[^>]*\.tex[^>]*|& onclick=\"$ONCLICK_TEX\"|g"      \
    > $OUT_FILE

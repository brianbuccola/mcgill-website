#!/bin/bash
#
# vim:              set ft=sh tw=79 sw=4:
# file:             md2html_with_tracking.sh
# author:           Brian Buccola
#
# description:      Coverts index.markdown into index.html using pandoc, while
#                   also adding Google Analytics tracking to <a href...> tags.

pg_title="Brian Buccola"
author="Brian Buccola"

in_file="index.markdown"
out_file="index.html"

css="style.css"
head="head.html"
before="before-body.html"
after="after-body.html"

onclick_pdf="_gaq.push(['_trackEvent','Download','PDF',this.href]);"
onclick_tex="_gaq.push(['_trackEvent','Download','TEX',this.href]);"

# Check if given file exists.
file_check() {
    if [[ ! -f "$1" ]]; then
        echo "Error: cannot find file ${1}."
        exit 1
    fi
}

# Files to check.
files=("$in_file" "$css" "$head" "$before" "$after")

for f in "${files[@]}"; do
    file_check "$f"
done

# Convert markdown to html5, and add onclick text to link tags.
pandoc -S -c "$css" -H "$head" -B "$before" -A "$after"         \
    -V pagetitle="$pg_title" -V author-meta="$author"           \
    --mathjax -f markdown -t html5 "$in_file"               |   \
    sed "s|<a[^>]*\.pdf[^>]*|& onclick=\"$onclick_pdf\"|g"  |   \
    sed "s|<a[^>]*\.tex[^>]*|& onclick=\"$onclick_tex\"|g"      \
    > $out_file

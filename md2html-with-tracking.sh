#!/bin/bash
#
# vim:              set ft=sh tw=79 sw=4:
# file:             md2html_with_tracking.sh
# author:           Brian Buccola
#
# description:      Coverts index.markdown into index.html using pandoc, while
#                   also adding Google Analytics tracking to <a href...> tags.

# Global variables.
pg_title="Brian Buccola"
author="Brian Buccola"
css="style.css"
head="head.html"
before="before-body.html"
after="after-body.html"
onclick_pdf="_gaq.push(['_trackEvent','Download','PDF',this.href]);"
onclick_tex="_gaq.push(['_trackEvent','Download','TEX',this.href]);"

# in_file=$1
# out_file="$(basename "$1" ".markdown").html"

# Check if given file exists.
file_check() {
    if [[ ! -f "$1" ]]; then
        echo "Error: cannot find file $1."
        exit 1
    fi
}

# Convert markdown to html5, and add onclick text to link tags.
md2html_with_tracking() {
    local in_file=$1
    local out_file="$(basename "$1" ".markdown").html"

    # Files to check.
    local files=("$in_file" "$css" "$head" "$before" "$after")

    for f in "${files[@]}"; do
        file_check "$f"
    done

    pandoc -S -c "$css" -H "$head" -B "$before" -A "$after"         \
        -V pagetitle="$pg_title" -V author-meta="$author"           \
        --mathjax -f markdown -t html5 "$in_file"               |   \
        sed "s|<a[^>]*\.pdf[^>]*|& onclick=\"$onclick_pdf\"|g"  |   \
        sed "s|<a[^>]*\.tex[^>]*|& onclick=\"$onclick_tex\"|g"      \
        > $out_file
}

# Convert all markdown files in current directory to html5.
for f in *.markdown; do
    md2html_with_tracking "$f"
done

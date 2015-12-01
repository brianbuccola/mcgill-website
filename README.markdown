# About

This is the old source code to my old academic website when I was a PhD student
at McGill, which I wrote, used, and maintained for more than two years. I
blogged about it [here][pt1], [here][pt2], and [here][pt3]. The idea was
simple:

- write webpages in [markdown][md] and convert them to html with [pandoc][pd],
  via the wrapper script `md2html-with-tracking.sh`
- push all files to the McGill server with [rsync][rs], via the wrapper script
  `push-website.sh`
- and, of course, version control everything with [git][]

[pt1]: http://brianbuccola.com/maintaining-an-academic-website-part-1-editing-the-site/
[pt2]: http://brianbuccola.com/maintaining-an-academic-website-part-2-pushing-to-server/
[pt3]: http://brianbuccola.com/maintaining-an-academic-website-part-3-version-control/
[md]:  https://daringfireball.net/projects/markdown/
[pd]:  http://pandoc.org/
[rs]:  https://rsync.samba.org/
[git]: https://git-scm.com/

I've since migrated to [Jekyll][jk] and [GitHub Pages][gh], which renders most
of this code obsolete. But I'm keeping this repository up because I still think
it's a simple and easy method, which others might find useful. And who knows,
maybe I'll return to this method one day (for example, if Jekyll gets abandoned
or GitHub Pages shuts down).

[jk]: http://jekyllrb.com/
[gh]: https://pages.github.com/

# License

This code (e.g. css, html, Bash scripts) is licensed under a [Creative Commons
Attribution 4.0 International License][cc]. That means you're free to use
(copy, adapt, etc.) any part of the code that you like; just make sure to [link
back here][here] and to [link to the license][cc].

[cc]:   http://creativecommons.org/licenses/by/4.0/
[here]: https://github.com/brianbuccola/mcgill-website

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a>

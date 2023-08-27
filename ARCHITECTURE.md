# git-scm.com architecture

This document describes the general setup and architecture that runs the
git-scm.com site.

## Content

This site is served via GitHub Pages and is a [Jekyll](https://jekyllrb.com/)
site.

The content is a mix of:

  - original content from this repository

  - community book content brought in from https://github.com/progit;
    see the `lib/tasks/book2.rake` file.

  - manpages from releases of the git project, imported and formatted
    via asciidoctor; see the `lib/tasks/index.rake` task.


## Non-static parts

While the site consists mostly of static content, there are a couple of
parts that are sort of dynamic.

The search is implemented client-side, via [`lunr.js`](http://lunrjs.com/).

A few scheduled GitHub workflows keep the content up to date:

  - `rake downloads` (pick up newly released git versions)

  - `rake preindex` (pull in and format manpages for released git
    versions)

  - `rake remote_genbook2` (pull in and format progit2 book content,
    including translations)

These workflows are also marked as `workflow_dispatch`, i.e. they can be run
manually (e.g. to update the download links just after Git for Windows
published a new release).

Merges to the `gh-pages` branch on GitHub auto-deploy to GitHub Pages.

Note that some of the formatting of manpages and book content happens
when they are imported by the rake tasks. So after fixing some
formatting and deploying, the rake jobs may need to be re-run with a
special flag to re-import (see the individual tasks for details).


## DNS

The actual DNS service is provided by Cloudflare. The domain itself is
registered with Gandi, and is owned by the project via Software Freedom
Conservancy. Funds for the registration are provided from the Git project's
Conservancy funds, and both the Git PLC and Conservancy have credentials to
modify the setup.

Note that we own both git-scm.com and git-scm.org; the latter redirects
to the former.


## Manual Intervention

The site mostly just runs without intervention:

  - code merged to `main` is auto-deployed

  - new git versions are detected daily and manpages and download links
    updated

  - book updates (including translations) are picked up daily

There are a few tasks that still need to be handled by a human:

  - new images added to the book have to be copied manually from
    progit/progit2

  - new languages for book translations need to be added to
    `lib/tasks/book2.rake`

  - forced re-imports of content (e.g., a formatting fix to imported
    manpages) must be triggered manually

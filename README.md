# Git Homepage [![CI](https://github.com/git/git-scm.com/actions/workflows/ci.yml/badge.svg)](https://github.com/git/git-scm.com/actions/workflows/ci.yml) [![Help Contribute to Open Source](https://www.codetriage.com/git/git-scm.com/badges/users.svg)](https://www.codetriage.com/git/git-scm.com)

This is the web application for the [git-scm.com](https://git-scm.com) site.  It is meant to be the
first place a person new to Git will land and download or learn about the
Git SCM system.

This site is built with [Jekyll](https://jekyllrb.com/) and served via GitHub Pages.

## Setup

You'll need [Jekyll](https://jekyllrb.com/) and [the `jekyll-redirect-from` plugin](https://github.com/jekyll/jekyll-redirect-from). On Windows, we recommend using the Windows Subsystem for Linux (WSL).

You can install the `jekyll-redirect-from` plugin via

    $ gem install --user-install jekyll-redirect-from

or by running

    $ bundler install

Note: The `bundler install` command will install other Ruby gems, too, that are only required e.g. to update the Git version.

You can serve the site locally via

    $ jekyll serve -w --incremental

The site should be running on http://127.0.0.1:4000

## Update manual pages

First, install the prerequisites:

	$ bundler install --with=scripts

Then, you can build the manual pages using a local Git source clone like this:

    $ GIT_REPO=../git/.git ./scripts/update-docs.rb

This will populate the man pages for all Git versions. You can also populate them only for a specific Git version (faster):

    $ version=v2.23.0
    $ GIT_REPO=../git/.git REBUILD_DOC=$version rake local_index

Or you can populate the man pages from GitHub (much slower) like this:

    $ export GITHUB_API_TOKEN=github_personal_auth_token
    $ rake preindex  # all versions
    $ REBUILD_DOC=$version rake preindex  # specific version

Similarly, you can also populate the localized man pages. From a local clone of https://github.com/jnavila/git-html-l10n :

    $ GIT_REPO=../git-html-l10n/.git rake local_index_l10n  # all versions
    $ GIT_REPO=../git-html-l10n/.git REBUILD_DOC=$version rake local_index_l10n  # specific version

Or you can do it from GitHub (much slower) like this:

    $ export GITHUB_API_TOKEN=github_personal_auth_token
    $ rake preindex_l10n  # all versions
    $ REBUILD_DOC=$version rake preindex_l10n  # specific version

## Update the `Downloads` pages

Now you need to get the latest downloads for the downloads pages:

    $ script/update-download-data.rb

## Update the ProGit book

First, you will have to get the necessary prerequisites:

    $ bundler install --with=scripts

Now you'll probably want some book data. You'll have
to have access to the [Pro Git project on GitHub](https://github.com/progit/progit2) through the API.

    $ export GITHUB_API_TOKEN=github_personal_auth_token
    $ script/update-book2.rb en

If you have 2FA enabled, you'll need to create a [Personal Access Token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/).    

That will generate the book content from the Asciidoc files fetched from the online repository and write the files to the local tree, ready to be committed and served via Jekyll. If you want to build the book for all available languages, just skip the language code:

    $ script/update-book2.rb

Alternatively, you can get the book content from a repository on your computer by specifying the path:

    $ script/update-book2.rb fr ../progit2-fr

## Contributing

If you wish to contribute to this website, please [fork it on GitHub](https://github.com/git/git-scm.com), push your
change to a named branch, then send a pull request. If it is a big feature,
you might want to [start an issue](https://github.com/git/git-scm.com/issues/new) first to make sure it's something that will
be accepted. If it involves code, please also write tests for it.

## Adding new GUI

The [list of GUI clients](https://git-scm.com/downloads/guis) has been constructed by the community for a long time. If you want to add another tool you'll need to follow a few steps:

1. Add a new `.md` file with the GUI client details: https://github.com/git/git-scm.com/tree/main/\_guis
    1. The fields need to be enclosed within `---` lines
    2. The fields `name`, `project_url`, `price`, `license` should be very straightforward to fill.
    3. The field `image_tag` corresponds to the path of the image of the tool (should start with `images/guis/`).
    4. `platforms` is a list of at least 1 platform in which the tool is supported. The possibilities are: `Windows`, `Mac`, `Linux`, `Android`, and `iOS`
    5. `order` can be filled with the biggest number already existing, plus 1 (Adding to the bottom - this will be covered in the following steps). This is the only field whose value should _not_ be enclosed in double-quote characters.
    6. `trend_name` is an optional field that can be used for helping sorting the clients (also covered in the next steps)

2. Add the image to `images/guis/<GUI_CLIENT_NAME>@2x.png` and `public/images/guis/<GUI_CLIENT_NAME>.png` making sure the aspect ratio matches a 588:332 image.

## Useful links regarding working with Jekyll

* https://jekyllrb.com/docs/
* https://shopify.github.io/liquid/
* https://github.com/jekyll/jekyll-redirect-from
* https://github.com/jekyll/github-metadata/blob/main/docs/site.github.md
* https://lunrjs.com/guides/index_prebuilding.html

## License

The source code for the site is licensed under the MIT license, which you can find in
the MIT-LICENSE.txt file.

All graphical assets are licensed under the
[Creative Commons Attribution 3.0 Unported License](https://creativecommons.org/licenses/by/3.0/).

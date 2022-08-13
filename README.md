eriner
======

A fork of the Powerline-inspired [agnoster] theme.

The aim of this theme is to only show you *relevant* information. Like most
prompts, it will only show git information when in a git working directory.
However, it goes a step further: everything from the current user and hostname
to whether the last call exited with an error to whether background jobs are
running in this shell will all be displayed automatically when appropriate.

<img width="706" src="https://zimfw.github.io/images/prompts/eriner@2.png">

What does it show?
------------------

  * Status segment:
    * `✘` when there was an error.
    * `⚡` when you're root.
    * `⚙` when there are background jobs.
    * `r` when you're in a [ranger] spawned shell.
    * Python [venv] indicator.
    * `username@hostname` when in a ssh session.
  * Short working directory segment.
  * Git segment (background color varies if working tree is clean or dirty):
    * Current branch name, or commit short hash when in ['detached HEAD' state].
    * `±` when in a dirty working tree.

Settings
--------

The background color for each segment can be customized with an environment
variable. If the variable is not defined, the respective default value is used.

| Variable     | Description                          | Default value |
| ------------ | ------------------------------------ | ------------- |
| STATUS_COLOR | Status segment color                 | black         |
| PWD_COLOR    | Working directory segment color      | cyan          |
| CLEAN_COLOR  | Clean git working tree segment color | green         |
| DIRTY_COLOR  | Dirty git working tree segment color | yellow        |

Requirements
------------

In order for this theme to render correctly, a font with Powerline symbols is
required. A simple way to install a font with Powerline symbols is to follow the
[instructions here].

Requires Zim's [git-info] module to show git information.

[agnoster]: https://github.com/agnoster/agnoster-zsh-theme
[ranger]: https://github.com/ranger/ranger
[venv]: https://docs.python.org/3/library/venv.html
['detached HEAD' state]: https://git-scm.com/docs/git-checkout#_detached_head
[instructions here]: https://github.com/powerline/fonts/blob/master/README.rst#installation
[git-info]: https://github.com/zimfw/git-info

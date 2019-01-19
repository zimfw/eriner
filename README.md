eriner
======

A fork of the Powerline-inspired
[agnoster](https://github.com/agnoster/agnoster-zsh-theme) theme.

The aim of this theme is to only show you *relevant* information. Like most
prompts, it will only show git information when in a git working directory.
However, it goes a step further: everything from the current user and hostname
to whether the last call exited with an error to whether background jobs are
running in this shell will all be displayed automatically when appropriate.

![eriner theme](https://i.eriner.me/zim_prompt_eriner.png)

What does it show?
------------------

  * Status segment:
    * `✘` when there was an error.
    * `⚡` when you're root.
    * `⚙` when there are background jobs.
    * `r` when you're in a [`ranger`](https://github.com/ranger/ranger) spawned shell.
    * Python [`venv`](https://docs.python.org/3/library/venv.html) indicator.
    * `user@hostname` when user is not `DEFAULT_USER` (which can then be set in your zprofile).
  * Short working directory segment.
  * Git segment (background color varies if working tree is clean or dirty):
    * Current branch name, or commit short hash when in
      ['detached HEAD' state](http://gitfaq.org/articles/what-is-a-detached-head.html).
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
instructions [here](https://github.com/powerline/fonts/blob/master/README.rst#installation).

Requires Zim's [`git-info`](https://github.com/zimfw/git-info) module to show git information.

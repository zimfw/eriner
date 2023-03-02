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
  * Working directory segment.
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

Advanced settings
-----------------

You can customize how the current working directory is shown with the
[prompt-pwd module settings].

The git indicators can be customized by changing the following git-info module
context formats:

| Context name | Description         | Default format |
| ------------ | ------------------- | -------------- |
| branch       | Branch name         | ` %b`         |
| commit       | Commit short hash   | `➦ %c`         |
| action       | Special action name | ` (%s)`        |
| dirty        | Dirty state         | ` ±`           |

Use the following command to override a git-info context format:

    zstyle ':zim:git-info:<context_name>' format '<new_format>'

For detailed information about these and other git-info settings, check the
[git-info documentation].

These advanced settings must be overridden after the theme is initialized.

Requirements
------------

In order for this theme to render correctly, a font with Powerline symbols is
required. A simple way to install a font with Powerline symbols is to follow the
[instructions here].

Requires Zim's [prompt-pwd] module to show the current working directory, and
[git-info] to show git information.

[agnoster]: https://github.com/agnoster/agnoster-zsh-theme
[ranger]: https://github.com/ranger/ranger
[venv]: https://docs.python.org/3/library/venv.html
['detached HEAD' state]: https://git-scm.com/docs/git-checkout#_detached_head
[prompt-pwd module settings]: https://github.com/zimfw/prompt-pwd/blob/master/README.md#settings
[git-info documentation]: https://github.com/zimfw/git-info/blob/master/README.md#settings
[instructions here]: https://github.com/powerline/fonts/blob/master/README.rst#installation
[prompt-pwd]: https://github.com/zimfw/prompt-pwd
[git-info]: https://github.com/zimfw/git-info

# vim:et sts=2 sw=2 ft=zsh

prompt_eriner_help () {
  cat <<EOH
This theme is color-scheme-able. You can customize it using:

    prompt eriner [status_color] [pwd_color] [git_clean_color] [git_dirty_color]

where the parameters are the background colors for each segment. The default
values are black, cyan, green, and yellow.

In order for this theme to render correctly, a font with Powerline symbols is
required. A simple way to install a font with Powerline symbols is to follow the
instructions here: https://github.com/powerline/fonts#installation
EOH
}

prompt_eriner_main() {
  # This runs in a subshell
  RETVAL=${?}
  COLOR1=${1:-black}
  COLOR2=${2:-cyan}
  COLOR_CLEAN=${3:-green}
  COLOR_DIRTY=${4:-yellow}

  ### Segment drawing
  # Utility functions to make it easy and re-usable to draw segmented prompts.

  COLOR_BG=''

  # Begin a segment. Takes two arguments, background color and contents of the
  # new segment.
  prompt_eriner_segment() {
    print -n "%K{${1}}"
    [[ -n ${COLOR_BG} ]] && print -n "%F{${COLOR_BG}}"
    print -n "${2}"
    COLOR_BG=${1}
  }

  prompt_eriner_standout_segment() {
    print -n "%S%F{${1}}"
    [[ -n ${COLOR_BG} ]] && print -n "%K{${COLOR_BG}}%k"
    print -n "${2}%s"
    COLOR_BG=${1}
  }

  # End the prompt, closing last segment.
  prompt_eriner_end() {
    print -n "%k%F{${COLOR_BG}}%f "
  }

  ### Prompt components
  # Each component will draw itself, or hide itself if no information needs to
  # be shown.

  # Status: Was there an error? Am I root? Are there background jobs? Ranger
  # spawned shell? Who and where am I (user@hostname)?
  prompt_eriner_status() {
    local segment=''
    (( RETVAL )) && segment+=' %F{red}✘'
    (( EUID == 0 )) && segment+=' %F{yellow}⚡'
    (( $(jobs -l | wc -l) )) && segment+=' %F{cyan}⚙'
    (( RANGER_LEVEL )) && segment+=' %F{cyan}r'
    [[ -n ${VIRTUAL_ENV} ]] && segment+=" %F{cyan}${VIRTUAL_ENV:t}"
    if [[ ${USER} != ${DEFAULT_USER} || -n ${SSH_CLIENT} ]]; then
      segment+=" %F{%(!.yellow.default)}${USER}@%m"
    fi
    if [[ -n ${segment} ]]; then
      prompt_eriner_segment ${COLOR1} "${segment} "
    fi
  }

  # Pwd: current working directory.
  prompt_eriner_pwd() {
    local current_dir="${PWD/#${HOME}/~}"
    if [[ ${current_dir} != '~' ]]; then
      current_dir="${${(@j:/:M)${(@s:/:)current_dir:h}#?}%/}/${current_dir:t}"
    fi
    prompt_eriner_standout_segment ${COLOR2} " ${current_dir} "
  }

  # Git: branch/detached head, dirty status.
  prompt_eriner_git() {
    if [[ -n ${git_info} ]]; then
      local git_color
      local git_dirty=${(e)git_info[dirty]}
      if [[ -n ${git_dirty} ]]; then
        git_color=${COLOR_DIRTY}
      else
        git_color=${COLOR_CLEAN}
      fi
      prompt_eriner_standout_segment ${git_color} " ${(e)git_info[prompt]}${git_dirty} "
    fi
  }

  prompt_eriner_status
  prompt_eriner_pwd
  prompt_eriner_git
  prompt_eriner_end
}

prompt_eriner_precmd() {
  (( ${+functions[git-info]} )) && git-info
}

prompt_eriner_setup() {
  VIRTUAL_ENV_DISABLE_PROMPT=1
  autoload -Uz add-zsh-hook && add-zsh-hook precmd prompt_eriner_precmd

  prompt_opts=(cr percent sp subst)

  zstyle ':zim:git-info:branch' format ' %b'
  zstyle ':zim:git-info:commit' format '➦ %c'
  zstyle ':zim:git-info:action' format ' (%s)'
  zstyle ':zim:git-info:dirty' format ' ±'
  zstyle ':zim:git-info:keys' format \
    'prompt' '%b%c%s' \
    'dirty' '%D'

  PS1="\$(prompt_eriner_main ${@})"
  RPS1=''
}

prompt_eriner_preview () {
  if (( # )); then
    prompt_preview_theme eriner "${@}"
  else
    prompt_preview_theme eriner
    print
    prompt_preview_theme eriner black blue
  fi
}

prompt_eriner_setup "${@}"

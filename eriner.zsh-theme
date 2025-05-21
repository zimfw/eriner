# vim:et sts=2 sw=2 ft=zsh

_prompt_eriner_main() {
  # This runs in a subshell
  RETVAL=${?}
  BG_COLOR=

  _prompt_eriner_status
  _prompt_eriner_pwd
  _prompt_eriner_git
  _prompt_eriner_end
}

### Segment drawing
# Utility functions to make it easy and re-usable to draw segmented prompts.

# Begin a segment. Takes two arguments, background color and contents of the
# new segment.
_prompt_eriner_segment() {
  print -n "%K{${1}}"
  if [[ -n ${BG_COLOR} ]] print -n "%F{${BG_COLOR}}"
  print -n ${2}
  BG_COLOR=${1}
}

_prompt_eriner_standout_segment() {
  print -n "%S%F{${1}}"
  if [[ -n ${BG_COLOR} ]] print -n "%K{${BG_COLOR}}%k"
  print -n "${2}%s"
  BG_COLOR=${1}
}

# End the prompt, closing last segment.
_prompt_eriner_end() {
  print -n "%k%F{${BG_COLOR}}%f "
}

### Prompt components
# Each component will draw itself, or hide itself if no information needs to
# be shown.

# Status: Was there an error? Am I root? Are there background jobs? Ranger
# spawned shell? Python venv activated? Who and where am I (user@hostname)?
_prompt_eriner_status() {
  local segment=
  if (( RETVAL )) segment+=' %F{red}✘'
  if (( EUID == 0 )) segment+=' %F{yellow}⚡'
  if (( ${#jobstates} )) segment+=' %F{cyan}⚙'
  if (( RANGER_LEVEL )) segment+=' %F{cyan}r'
  if [[ -n ${VIRTUAL_ENV_PROMPT} ]]; then
    segment+=' %F{cyan}'${VIRTUAL_ENV_PROMPT}
  elif [[ -n ${VIRTUAL_ENV} ]]; then
    segment+=' %F{cyan}'${VIRTUAL_ENV:t}
  fi
  if [[ -n ${SSH_TTY} ]] segment+=' %F{%(!.yellow.default)}%n@%m'
  if [[ -n ${segment} ]]; then
    _prompt_eriner_segment ${STATUS_COLOR} ${segment}' '
  fi
}

# Pwd: current working directory.
_prompt_eriner_pwd() {
  local current_dir
  prompt-pwd current_dir
  _prompt_eriner_standout_segment ${PWD_COLOR} ' '${current_dir}' '
}

# Git: branch/detached head, dirty status.
_prompt_eriner_git() {
  if [[ -n ${git_info} ]]; then
    local git_color
    if [[ -n ${(e)git_info[dirty]} ]]; then
      git_color=${DIRTY_COLOR}
    else
      git_color=${CLEAN_COLOR}
    fi
    _prompt_eriner_standout_segment ${git_color} ' '${(e)git_info[prompt]}' '
  fi
}

if (( ! ${+STATUS_COLOR} )) typeset -g STATUS_COLOR=black
if (( ! ${+PWD_COLOR} )) typeset -g PWD_COLOR=cyan
if (( ! ${+CLEAN_COLOR} )) typeset -g CLEAN_COLOR=green
if (( ! ${+DIRTY_COLOR} )) typeset -g DIRTY_COLOR=yellow
typeset -g VIRTUAL_ENV_DISABLE_PROMPT=1

setopt nopromptbang prompt{cr,percent,sp,subst}

zstyle ':zim:prompt-pwd:fish-style' dir-length 1

typeset -gA git_info
if (( ${+functions[git-info]} )); then
  zstyle ':zim:git-info:branch' format ' %b'
  zstyle ':zim:git-info:commit' format '➦ %c'
  zstyle ':zim:git-info:action' format ' (%s)'
  zstyle ':zim:git-info:dirty' format ' ±'
  zstyle ':zim:git-info:keys' format \
      'prompt' '%b%c%s%D' \
      'dirty' '%D'

  autoload -Uz add-zsh-hook && add-zsh-hook precmd git-info
fi

PS1='$(_prompt_eriner_main)'
unset RPS1

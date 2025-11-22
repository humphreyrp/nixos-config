# Based on bira theme

setopt prompt_subst

() {

local PR_USER PR_USER_OP PR_PROMPT

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER='%F{green}%n%f'
  PR_USER_OP='%F{green}%#%f'
  PR_PROMPT='%f➤ %f'
else # root
  PR_USER='%F{red}%n%f'
  PR_USER_OP='%F{red}%#%f'
  PR_PROMPT='%F{red}➤ %f'
fi

# Check if we are in a nix shell
if [[ -n "$IN_NIX_SHELL" ]]; then
  NIX_PROMPT='[nix-shell]'
else
  NIX_PROMPT=''
fi

local return_code="%(?..%F{red}%? ↵%f)"

local user_host="${PR_USER}%F{cyan}@%m"
local current_dir="%B%F{blue}%~%f%b"
local git_branch='$(git_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

PROMPT="╭─$NIX_PROMPT ${venv_prompt}${user_host}:${current_dir} ${git_branch}
╰─$PR_PROMPT "
RPROMPT="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %f"
ZSH_THEME_RUBY_PROMPT_PREFIX="%F{red}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%f"
ZSH_THEME_VIRTUALENV_PREFIX="%F{red}("
ZSH_THEME_VIRTUALENV_SUFFIX=")%f "

}


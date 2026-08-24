# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# History
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# Plugins
plugins=(
  git
  fzf
  sudo
  extract
  history
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User Aliases
alias core='python3 ~/cptools/cfparse.py'
alias meow='bash ~/cptools/nodemon.sh'

# Load P10k config if it exists
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/d0lph1n/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/d0lph1n/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/d0lph1n/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/d0lph1n/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
# export TERM=xterm-kitty
alias scnt="git -C ~/WorkSpace/DigiNotes add . && git -C ~/WorkSpace/DigiNotes commit -m "regular_update" && git -C ~/WorkSpace/DigiNotes/ push"

#!/bin/bash

# --- 1. Install System Dependencies ---
echo "📦 Updating system and installing Zsh & Git..."
sudo apt update && sudo apt install -y zsh git curl

# --- 2. Install Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🚀 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh My Zsh is already installed."
fi

# --- 3. Install Plugins & Theme ---
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

echo "🛠️  Downloading plugins and Powerlevel10k..."

# Powerlevel10k
[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ] && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

# Autosuggestions
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

# Syntax Highlighting
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# FZF (Command line fuzzy finder)
if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --all
fi

# --- 4. Overwrite .zshrc with your clean config ---
echo "📝 Configuring .zshrc..."

cat <<EOT > ~/.zshrc
# Enable Powerlevel10k instant prompt
if [[ -r "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh" ]]; then
  source "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh"
fi

export ZSH="\$HOME/.oh-my-zsh"

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

source \$ZSH/oh-my-zsh.sh

# User Aliases
alias core='python ~/cptools/cfparse.py'
alias meow='bash ~/cptools/nodemon.sh'

# Conda Initialization (if it exists)
if [ -f "/home/\$USER/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/home/\$USER/miniconda3/etc/profile.d/conda.sh"
    CONDA_CHANGEPS1=false conda activate base
fi

# Load P10k config if it exists
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOT

# --- 5. Set Zsh as default shell ---
echo "🐚 Changing default shell to Zsh..."
sudo chsh -s $(which zsh) $USER

echo "🎉 Setup complete! Restart your terminal."

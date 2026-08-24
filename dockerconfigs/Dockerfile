# FROM --platform=linux/amd64 ubuntu:24.04
FROM ubuntu

# FROM --platform=linux/amd64 ubuntu:24.04
# FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

# ---------------------------------------------------------
# Basic packages
# ---------------------------------------------------------
RUN apt-get update && apt-get install -y \
    zsh \
    git \
    curl \
    wget \
    unzip \
    ca-certificates \
    build-essential \
    gcc \
    g++ \
    make \
    ripgrep \
    fd-find \
    tree-sitter-cli \
    xz-utils \
    file \
    locales \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# ---------------------------------------------------------
# Locale
# ---------------------------------------------------------
RUN locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# ---------------------------------------------------------
# Install latest stable Neovim
# Official prebuilt x86_64 archive
# ---------------------------------------------------------
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
    && rm -rf /opt/nvim-linux-x86_64 \
    && tar -C /opt -xzf nvim-linux-x86_64.tar.gz \
    && rm nvim-linux-x86_64.tar.gz

ENV PATH="/opt/nvim-linux-x86_64/bin:${PATH}"

# ---------------------------------------------------------
# Oh My Zsh
# Unattended installation
# ---------------------------------------------------------
RUN RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Make zsh the default shell
RUN chsh -s /usr/bin/zsh root

# ---------------------------------------------------------
# Powerlevel10k Theme
# ---------------------------------------------------------
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.oh-my-zsh/custom/themes/powerlevel10k \
    && sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' /root/.zshrc

# ---------------------------------------------------------
# NvChad
# ---------------------------------------------------------
RUN rm -rf /root/.config/nvim \
           /root/.local/share/nvim \
           /root/.local/state/nvim \
           /root/.cache/nvim

RUN git clone https://github.com/NvChad/starter /root/.config/nvim

# Remove the starter repository's git metadata.
# This makes ~/.config/nvim a normal user config.
RUN rm -rf /root/.config/nvim/.git

# ---------------------------------------------------------
# Add custom Neovim configuration
# ---------------------------------------------------------
COPY init.lua.append /tmp/init.lua.append

RUN printf '\n\n-- ==========================================================\n' \
    >> /root/.config/nvim/init.lua \
    && printf '%s\n' \
    '-- Custom user configuration' \
    '-- ==========================================================' \
    >> /root/.config/nvim/init.lua \
    && cat /tmp/init.lua.append >> /root/.config/nvim/init.lua \
    && rm /tmp/init.lua.append

# ---------------------------------------------------------
# Zsh configuration
# ---------------------------------------------------------
RUN cat >> /root/.zshrc <<'EOF'

# ---------------------------------------------------------
# Custom environment
# ---------------------------------------------------------

export EDITOR=nvim
export VISUAL=nvim

alias vi='nvim'
alias vim='nvim'

# fd is installed as fdfind on Ubuntu
alias fd='fdfind'

# Useful aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

EOF

# ---------------------------------------------------------
# Working directory
# ---------------------------------------------------------
WORKDIR /root/host_home

# Start in zsh when attached interactively.
CMD ["sleep", "infinity"]

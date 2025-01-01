# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set ZSH installation path
export ZSH="$HOME/.oh-my-zsh"

# Set theme for Oh-My-Zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins to load
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

# Load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# ----------- User Configuration -----------

# Set preferred editor
export EDITOR="code"

# Alias examples
alias ls='colorls'

# Export paths for Apache Spark and dbt
export SPARK_HOME="/opt/homebrew/Cellar/apache-spark/3.5.1"
export PATH=$PATH:"/opt/homebrew/Cellar/apache-spark/3.5.1/bin"
export PATH="/opt/homebrew/lib/python3.11/site-packages/dbt/bin:$PATH"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

# Enable GitHub Copilot CLI
eval "$(github-copilot-cli alias -- "$0")"

# ----------- Tools Configuration -----------

# Setup Zoxide (faster directory navigation)
if command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Setup NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Lazyman for Neovim aliases
[ -f ~/.config/nvim-Lazyman/.lazymanrc ] && source ~/.config/nvim-Lazyman/.lazymanrc
[ -f ~/.config/nvim-Lazyman/.nvimsbind ] && source ~/.config/nvim-Lazyman/.nvimsbind

# ----------- FZF Configuration -----------

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# FZF theme colors
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# FZF default command using fd
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# FZF preview command
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# FZF path completion with fd
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of fzf
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----------- Aliases and Custom Functions -----------

# EZA alias for enhanced ls
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# TRE (tree) alias
tre() { command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; }
alias tree="tre"

# Zoxide (fast directory navigation) alias
alias cd="z"

# TheFuck alias for correcting commands
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# Yazi alias
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# ----------- End of Configuration -----------

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

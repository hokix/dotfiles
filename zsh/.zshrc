# zmodload zsh/zprof

# === Environment ===
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/go/bin:$HOME/go/bin:$PATH"
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"

# === Colors for ls ===
if [[ "$(uname)" == "Darwin" ]]; then
  export CLICOLOR=1
  export LSCOLORS=ExFxBxDxCxegedabagacad
else
  command -v dircolors &>/dev/null && eval "$(dircolors -b)"
  alias ls='ls --color=auto'
fi

# NVM (must be set before zsh-nvm loads)
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim' 'nvim')

# Tmux auto-start (replaces OMZP::tmux)
if command -v tmux &>/dev/null && [[ -z "$TMUX" && -z "$VSCODE_PID" && -z "$INTELLIJ_ENVIRONMENT_READER" ]]; then
  tmux -2 attach -t default 2>/dev/null || tmux -2 new-session -s default
fi

# Local overrides
[ -f ~/.zshrc_local ] && source ~/.zshrc_local

# === Zinit ===
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    print -P "%F{33}▓▒░ Installing zinit…%f"
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# === Theme: Pure ===
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# === Colored man pages (replaces OMZP::colored-man-pages) ===
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# === Load: Third-party Plugins ===
zinit light zsh-users/zsh-autosuggestions

# === Deferred: Third-party Plugins ===
zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions
zinit ice wait lucid
zinit light Aloxaf/fzf-tab
zinit ice wait lucid
zinit light changyuheng/zsh-interactive-cd
zinit ice wait lucid
zinit light lukechilds/zsh-nvm
zinit ice wait lucid
zinit light MichaelAquilina/zsh-you-should-use
zinit ice wait lucid
zinit light wfxr/forgit
# syntax-highlighting last; atinit triggers deferred compinit
zinit ice wait lucid atinit"zicompinit; zicdreplay"
zinit light zsh-users/zsh-syntax-highlighting

# === Completions ===
fpath=("$HOME/.zsh/completions" $fpath)

# === History ===
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=200000
SAVEHIST=200000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# === Options ===
unsetopt BG_NICE
setopt no_nomatch

# === fzf ===
source <(fzf --zsh)

# === Aliases ===
alias ll="ls -l"
alias tmux="tmux -2"
alias ctags="noglob ctags"

# === Key Bindings ===
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey '^e' autosuggest-accept
bindkey '^i' expand-or-complete

# === Tmux Window Name ===
autoload -Uz add-zsh-hook
tmux-window-name() {
	($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
}
add-zsh-hook chpwd tmux-window-name

# zprof

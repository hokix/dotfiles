# zmodload zsh/zprof

# === Environment ===
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/go/bin:$HOME/go/bin:$PATH"
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"

# NVM (must be set before zsh-nvm loads)
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim' 'nvim')

# Tmux (must be set before tmux plugin loads)
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=false

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

# === Synchronous (must load before prompt) ===
zinit snippet OMZP::tmux

# === Deferred: OMZ Plugins (load right after prompt) ===
zinit ice wait lucid
zinit snippet OMZL::git.zsh
zinit ice wait lucid
zinit snippet OMZP::git
zinit ice wait lucid
zinit snippet OMZP::colored-man-pages

# === Deferred: Third-party Plugins ===
zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions
zinit ice wait lucid
zinit light Aloxaf/fzf-tab
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid
zinit light changyuheng/zsh-interactive-cd
zinit ice wait lucid
zinit light lukechilds/zsh-nvm
zinit ice wait lucid
zinit light MichaelAquilina/zsh-you-should-use
# syntax-highlighting last; atinit triggers deferred compinit
zinit ice wait lucid atinit"zicompinit; zicdreplay"
zinit light zsh-users/zsh-syntax-highlighting

# === Completions ===
# OpenSpec completions (fpath set before deferred zicompinit runs)
fpath=("/Users/ted/.oh-my-zsh/custom/completions" $fpath)

# === History ===
HISTSIZE=200000
SAVEHIST=200000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# === Options ===
unsetopt BG_NICE
setopt no_nomatch

# === fzf ===
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
bindkey '^i' expand-or-complete-prefix

# === Tmux Window Name ===
autoload -Uz add-zsh-hook
tmux-window-name() {
	($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
}
add-zsh-hook chpwd tmux-window-name

# zprof

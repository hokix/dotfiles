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

# --- 行首 / 行尾（emacs 风格，vi 模式下不自带需显式绑定）---
bindkey '^a' beginning-of-line                 # Ctrl+A  → 跳到行首
bindkey '^e' end-of-line                       # Ctrl+E  → 跳到行尾
bindkey '\eb' backward-word                    # Alt+B   → 向左跳一个单词
bindkey '\ef' forward-word                     # Alt+F   → 向右跳一个单词

# --- 行首 / 行尾（终端 Home/End 键）---
bindkey "\eOH" beginning-of-line          # Home（应用模式）→ 跳到行首
bindkey "\eOF" end-of-line                # End （应用模式）→ 跳到行尾
bindkey "\e[H" beginning-of-line          # Home（普通模式）→ 跳到行首
bindkey "\e[F" end-of-line                # End （普通模式）→ 跳到行尾

# --- 历史记录前缀搜索（↑/↓ 及 PageUp/PageDown）---
# 输入前缀后按方向键，只在匹配该前缀的历史中翻页
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "\e[A"  up-line-or-beginning-search    # ↑       → 向上匹配前缀历史
bindkey "\e[B"  down-line-or-beginning-search  # ↓       → 向下匹配前缀历史
bindkey "\e[5~" up-line-or-beginning-search    # PageUp  → 向上匹配前缀历史
bindkey "\e[6~" down-line-or-beginning-search  # PageDown→ 向下匹配前缀历史

# --- 单词跳转（Ctrl + 方向键）---
bindkey "\e[1;5C" forward-word                 # Ctrl+→  → 向右跳一个单词
bindkey "\e[1;5D" backward-word                # Ctrl+←  → 向左跳一个单词

# --- 单词 / 行删除 ---
bindkey '^w' backward-kill-word                # Ctrl+W  → 向左删除一个单词（readline 标准）
bindkey '^k' kill-line                         # Ctrl+K  → 删除光标到行尾

# --- zsh-autosuggestions：接受建议 ---
bindkey '^f' autosuggest-accept                # Ctrl+F  → 接受整条建议（右箭头也可）
# Alt+F 保留默认 forward-word，用 Ctrl+→ 替代单词跳转

# --- 历史参数复用 ---
bindkey '\e.' insert-last-word                 # Alt+.   → 插入上条命令的最后一个参数

# === Tmux Window Name ===
autoload -Uz add-zsh-hook
tmux-window-name() {
	($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
}
add-zsh-hook chpwd tmux-window-name

eval "$(zoxide init zsh --cmd cd)"
# zprof

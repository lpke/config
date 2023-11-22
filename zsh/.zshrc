# ==========================================================================
# Command History
# ==========================================================================

HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
HISTSIZE=10000 # number of history entries to keep in memory during a session
SAVEHIST=10000 # number of history entries to save after a session is closed

# ==========================================================================
# Completion System (in-built tab completions for commands, files, etc.)
# ==========================================================================

# Initialisation
zstyle :compinstall filename "${ZDOTDIR:-$HOME}/.zshrc" # providing location of zshrc
autoload -Uz compinit                                   # mark compinit for autoload (speeds up shell loading)
compinit                                                # initialise completion system

# Customisation
zmodload -i zsh/complist           # load additional completion listing features
zstyle ':completion:*' menu select # enable menu selection for completions
zstyle ':completion:*:*:cd:*' menu select
setopt menu_complete # this and the next line allow instant completion selection?
setopt no_list_ambiguous

# ==========================================================================
# Zsh Options
# ==========================================================================

unsetopt beep
setopt autocd # allow cd without cd

# ==========================================================================
# Vi Mode
# ==========================================================================

# Enable Vi mode
bindkey -v '^?' backward-delete-char # enable + backspace not limited
export KEYTIMEOUT=1                  # instant mode switching (no delay)

# change cursor for different vi modes
# 1 => blinking block
# 2 => steady block
# 3 => blinking underline
# 4 => steady underline
# 5 => blinking bar
# 6 => steady bar
NORMAL=2
INSERT=6
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
    echo -ne "\e[$NORMAL q"
  elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
    echo -ne "\e[$INSERT q"
  fi
}
zle -N zle-keymap-select
zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
  echo -ne "\e[$INSERT q"
}
zle -N zle-line-init
echo -ne "\e[$INSERT q"                # Use bar shape cursor on startup.
preexec() { echo -ne "\e[$INSERT q"; } # Use bar shape cursor for each new prompt.

# ==========================================================================
# Environment Variables
# ==========================================================================

export VISUAL=nvim
export EDITOR="$VISUAL"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ==========================================================================
# Misc Customisation
# ==========================================================================

# Starting directory
cd ~

# Aliases
alias cls="clear"
alias r='ranger --choosedir=$HOME/.config/ranger/lastdir; LASTDIR=`cat $HOME/.config/ranger/lastdir`; cd "$LASTDIR"'
alias nn='pnpm'
alias vi='VIMINIT="source ~/.config/vim/vimrc" vi'
alias vim='nvim'
alias v='nvim'
alias ta='tmux attach'
alias gs='git status'

# vim plugins
alias g='nvim . -c "call timer_start(50, { tid -> execute( '\''if exists(\":Git\") | exec \"silent! Git | silent! only | silent! nnoremap <buffer><nowait> Q :q<CR> | silent! autocmd VimEnter,BufEnter,BufWinEnter * silent! nnoremap <buffer><nowait> Q :q<CR>\" | call timer_stop(tid) | endif'\'' ) }, { '\''repeat'\'': -1 })"'
alias o='nvim . -c "silent! nnoremap <buffer><nowait> Q :q<CR> | silent! autocmd VimEnter,BufEnter,BufWinEnter * silent! nnoremap <buffer><nowait> Q :q<CR>"'

# ==========================================================================
# Load Plugins/Extras
# ==========================================================================

# Zsh syntax highlighting
source ~/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# editing highlighter colors
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#2F998A,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#2F998A,bold'

# Zsh Autosuggestions
source ~/.config/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#464a5b"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)" # do not suggest history items longer than 50 characters

# Pyenv
eval "$(pyenv init -)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Homebrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

# pnpm
export PNPM_HOME="/home/luke/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# pipx?
export PATH="$PATH:/home/luke/.local/bin"

# bashcompinit (used by pipx)
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"


# ==========================================================================
# Keybindings
# ==========================================================================

# Completion system
bindkey '^ ' list-choices                          # ctrl+space to open menu select for tab choices
bindkey -M menuselect '\e' send-break              # esc to cancel tab menu select
bindkey -M menuselect '^[[Z' reverse-menu-complete # shift+tab to go backwards in tab selections

# Zsh autosuggestions
bindkey '^[[1;2C' forward-word # rebinding `forward-word` to Shift+Right
# Shift+Right - accept next part of the suggestion (uses `forward-word`)
# Right - accept suggestion (default keybind)
bindkey '^p' autosuggest-toggle # toggle autosuggest

# ==========================================================================
# oh-my-posh
# ==========================================================================

# initialisation
eval "$(oh-my-posh --init --shell zsh --config ~/.config/oh-my-posh/lpke-min.omp.json)"


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval $(thefuck --alias)
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ry/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ry/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ry/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ry/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH=/Users/ry/.local/bin:$PATH

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/ry/.lmstudio/bin"
# End of LM Studio CLI section


source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# History configuration
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
# History configuration end


# Eza configuration
alias ls="eza --icons=auto" 
# Eza configuration end


# Zoxide configuration
eval "$(zoxide init zsh)"

alias cd="z"
# Zoxide configuration end
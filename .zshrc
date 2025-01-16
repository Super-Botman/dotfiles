# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:$HOME/.local/bin"
export EDITOR=$(which nvim)

ZSH_THEME="xiong-chiamiov-plus"

plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

qemu() {
  if [[ -f "$1" ]]; then
    # Detect the architecture of the binary
    arch=$(file "$1" | grep -oP '(?<=executable, ).*?(?=,)')
    
    case "$arch" in
      *ARM*) # Check if it's an ARM binary
        qemu-arm -L /usr/arm-linux-gnueabihf "$@"
        ;;
      *AArch64*) # For 64-bit ARM binaries
        qemu-aarch64 -L /usr/aarch64-linux-gnu "$@"
        ;;
      *MIPS*)
        qemu-mips "$@"
        ;;
      *) # Default to running normally
        "$@"
        ;;
    esac
  else
    echo "Error: File '$1' not found or not executable."
  fi
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias rm="rm -rI"
alias vps='ssh -o "SetEnv SECRET=WiAfzoMTPoAvHrVZHSsJTWQn" root@adm.segfault.net'

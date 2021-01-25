prepend_path() {
    case ":${PATH:=$1}:" in   # adds the new directory if PATH is empty, returns PATH otherwise
        *:"$1":*)          ;; # already included, don't add to PATH
        *) PATH="$1:$PATH" ;; # prepend the new directory
    esac
}

export GOPATH="$HOME/code/go"

prepend_path "$HOME/.cargo/bin"
prepend_path "$GOPATH/bin"
prepend_path "$HOME/.local/bin"

PS_RESET='\[\e[0m\]'
PS_BOLD='\[\e[1m\]'
PS_GREEN='\[\e[32m\]'
PS_BLUE='\[\e[34m\]'
export PS1="${PS_BOLD}${PS_GREEN}\u@\h ${PS_BLUE}\w \\$ ${PS_RESET}"

# use rg to list files for fzf, with the effect that .gigignored files don't
# show up
export FZF_DEFAULT_COMMAND="rg --glob !.pijul --files --hidden"

export GOPATH="${HOME}/code/go"

PS_RESET='\[\e[0m\]'
PS_BOLD='\[\e[1m\]'
PS_GREEN='\[\e[32m\]'
PS_BLUE='\[\e[34m\]'
export PS1="${PS_BOLD}${PS_GREEN}\u@\h ${PS_BLUE}\w \\$ ${PS_RESET}"

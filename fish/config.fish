starship init fish | source
alias ls="eza --icons"
alias ll="eza -lah --icons"
alias la="eza -a --icons"
alias cat="bat"
alias ".."="cd .."
alias "..."="cd ../.."
if status is-interactive
    fastfetch
end
set fish_greeting   

starship init fish | source
alias ls="eza --icons"
alias ll="eza -lah --icons"
alias la="eza -a --icons"
alias cat="bat"
alias ".."="cd .."
alias "..."="cd ../.."
alias rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#hntr"
if status is-interactive
    fastfetch
end
set fish_greeting

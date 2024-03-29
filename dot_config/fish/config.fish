﻿# Fish shell basic 
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
export BAT_THEME="Catppuccin-mocha"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x TERM "wezterm"
# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

# Variables export 
# export QT_QPA_PLATFORM="wayland"
#export ORG_OVERRIDE="catppuccin-rfc"
# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add go path to PATH
if test -d ~/go/bin/ 
  if not contains -- ~/go/bin $PATH
    set -p PATH ~/go/bin 
    end 
end

if test -d ~/.npm-global/bin/
  if not contains -- ~/.npm-global/bin $PATH
    set -p PATH ~/.npm-global/bin
  end
end

# Enable touchpad gestures on firefox
if [ $XDG_SESSION_TYPE = "wayland" ]
  export MOZ_ENABLE_WAYLAND=1
else
  export MOZ_USE_XINPUT2=1
end

# Set editors 
set -Ux DIFFPROG (which lvim)
export EDITOR=(which lvim)
abbr -a nv "lvim"

# Set GPG stuff
export GPG_TTY=$(tty)
 
# Starship prompt
if status --is-interactive
  # b asename  "$PWD"
 starship init fish | source
end

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

# File backup
function backup --argument filename
    cp $filename $filename.bak
end

# Replace ls with exa
abbr -a ls 'exa  -l --color=always --group-directories-first --icons' # preferred listing
abbr -a la 'exa -a --color=always --group-directories-first --icons'  # all files and dirs
abbr -a ll 'exa -l --color=always --group-directories-first --icons'  # long format
abbr -a lt 'exa -aT --color=always --group-directories-first --icons' # tree listing
abbr -a l. "exa -a | grep -E '^\.'"                                     # show only dotfiles

# Git abbr 
abbr -a gc 'git commit -m'
abbr -a gco 'git checkout'

# Replace some more things with better alternatives
abbr -a cat 'bat --style header --style snip --style changes --style header'

# Common use
abbr -a .. 'cd ..'
abbr -a grep 'grep --color=auto'
abbr -a fgrep 'fgrep --color=auto'
abbr -a egrep 'egrep --color=auto'
abbr -a cz 'chezmoi'
alias clear='clear && ghosts'

# Pacman and reflector stuff
abbr -a listpkg "pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
abbr -a mirrorx 'sudo reflector --age 6 --latest 200 --fastest 20 --threads 20 --sort rate --protocol https --verbose --save /etc/pacman.d/mirrorlist'
abbr cleanup 'sudo pacman -Rns (pacman -Qtdq)'
abbr -a rip "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Journalctl stuff
# Get the error messages from journalctl
abbr jctl "journalctl -p 3 -xb"

# Print cute little ghosts on the top of the terminal
function ghosts 
    set -l bred (set_color -o brred)
    set -l bgreen (set_color -o brgreen)
    set -l byellow (set_color -o bryellow)
    set -l bblue (set_color -o brblue)
    set -l bmagenta (set_color -o brmagenta)
    set -l bcyan (set_color -o brcyan)
    echo $bred" "$byellow" "$bgreen" "$bmagenta" "$bblue" "$bcyan" " 
end

function fish_title 
  echo -ne "$(basename $PWD)"
end

if status --is-interactive
  ghosts
end

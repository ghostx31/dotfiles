# Fish shell basic 
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
export BAT_THEME="Catppuccin-mocha"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

# Variables export 
export QT_QPA_PLATFORM="wayland"
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

# Enable touchpad gestures on firefox
if [ $XDG_SESSION_TYPE = "wayland" ]
  export MOZ_ENABLE_WAYLAND=1
else
  export MOZ_USE_XINPUT2=1
end

# Set editors 
set -Ux DIFFPROG (which lvim)
export EDITOR=(which lvim)
alias nv="lvim"

# Set GPG stuff
export GPG_TTY=$(tty)
 
# Starship prompt
if status --is-interactive
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
alias ls='exa  -l --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles


# Replace some more things with better alternatives
alias cat='bat --style header --style snip --style changes --style header'

# Common use
alias ..='cd ..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias clear='clear && circles'

# Pacman and reflector stuff
alias listpkg="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias mirrorx='sudo reflector --age 6 --latest 200 --fastest 20 --threads 20 --sort rate --protocol https --verbose --save /etc/pacman.d/mirrorlist'
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Journalctl stuff
# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Print cute little ghosts on the top of the terminal
function circles 
    set -l bred (set_color -o brred)
    set -l bgreen (set_color -o brgreen)
    set -l byellow (set_color -o bryellow)
    set -l bblue (set_color -o brblue)
    set -l bmagenta (set_color -o brmagenta)
    set -l bcyan (set_color -o brcyan)
    echo $bred" "$byellow" "$bgreen" "$bmagenta" "$bblue" "$bcyan" " 
end

if status --is-interactive
  circles
end


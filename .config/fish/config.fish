﻿## Set values
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

export EDITOR=(which nvim)

## Environment setup
# Apply .profile
#source ~/.profile

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end
function fish_prompt
    # Setup colors
    #Bold Colors
    set -l bnormal (set_color -o normal)
    set -l bblack (set_color -o brblack)
    set -l bred (set_color -o brred)
    set -l bgreen (set_color -o brgreen)
    set -l byellow (set_color -o bryellow)
    set -l bblue (set_color -o brblue)
    set -l bmagenta (set_color -o brmagenta)
    set -l bcyan (set_color -o brcyan)
    set -l bwhite (set_color -o brwhite)

    #Normal Colors
    set -l normal (set_color normal)
    set -l black (set_color black)
    set -l red (set_color red)
    set -l green (set_color green)
    set -l yellow (set_color yellow)
    set -l blue (set_color blue)
    set -l magenta (set_color magenta)
    set -l cyan (set_color cyan)
    set -l white (set_color white)

    #set -g fish_prompt_pwd_dir_length 3
    # Cache exit status
    set -l last_status $status

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostnamectl --static)
    end
    if not set -q __fish_prompt_char
        switch (id -u)
            case 0
                set -g __fish_prompt_char \u276f\u276f
            case '*'
                set -g __fish_prompt_char $bgreen''$bmagenta''$bred''$byellow''$bblue''$bcyan''
        end
    end

    # Configure __fish_git_prompt
    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_showcolorhints true
    set -g fish_prompt_pwd_dir_length 0
    set -g __fish_git_prompt_showupstream auto
    # Color prompt char red for non-zero exit status
    set -l pcolor $bpurple
    if [ $last_status -ne 0 ]
    set pcolor $bred
    end

    # Top
    echo -n $bred"["$byellow"$USER"$bgreen"@"$bblue"$__fish_prompt_hostname"$bred"]"$bnormal $bred(prompt_pwd)$normal(fish_vcs_prompt)

    # Bottom
    echo -e "\n$__fish_prompt_char $normal"
end
## Starship prompt
##if status --is-interactive
##   source ("/usr/bin/starship" init fish --print-full-init | psub)
##end


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

function backup --argument filename
    cp $filename $filename.bak
end

if test -n "$DESKTOP_SESSION"
  set -x (gnome-keyring-daemon --start | string split "=")
end


# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles

# Replace some more things with better alternatives
alias cat='bat --style header --style rules --style snip --style changes --style header'
alias vim='nvim'
# Common use
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias ..='cd ..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                                   # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB (expac must be installed)
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias listpkg="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
# Get fastest mirrors 
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist" 
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist" 
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist" 
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist" 
alias mirrorf="sudo reflector --verbose --latest 200 --country India --country 'South Korea' --country Australia --country Germany --country Sweden --threads 20 --sort rate --save /etc/pacman.d/mirrorlist"
alias mirrorx='sudo reflector --age 6 --latest 200 --fastest 20 --threads 20 --sort rate --protocol https --verbose --save /etc/pacman.d/mirrorlist'
# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"
# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias listupdates="sudo pacman -Sy; clear; pacman -Qu"
alias install="sudo pacman -S"
alias remove="sudo pacman -Rs"
## Run colorscript if session is interactive
function circles 
     # Setup colors
    #Bold Colors
    set -l bnormal (set_color -o normal)
    set -l bblack (set_color -o brblack)
    set -l bred (set_color -o brred)
    set -l bgreen (set_color -o brgreen)
    set -l byellow (set_color -o bryellow)
    set -l bblue (set_color -o brblue)
    set -l bmagenta (set_color -o brmagenta)
    set -l bcyan (set_color -o brcyan)
    set -l bwhite (set_color -o brwhite)

    #Normal Colors
    set -l normal (set_color normal)
    set -l black (set_color black)
    set -l red (set_color red)
    set -l green (set_color green)
    set -l yellow (set_color yellow)
    set -l blue (set_color blue)
    set -l magenta (set_color magenta)
    set -l cyan (set_color cyan)
    set -l white (set_color white)
    echo $bred" "$byellow" "$bgreen" "$bmagenta" "$bblue" "$bcyan" " 
end
if status --is-interactive
  #colorscript random | tail -n +2
  circles
  # echo \n
end

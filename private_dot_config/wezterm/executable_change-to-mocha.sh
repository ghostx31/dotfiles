#!/bin/fish

# copy over theme to gtk-4.0 amd gtk-3.0 

cp -r ~/.themes/Catppuccin-Mocha-Lavender/gtk-4.0/* ~/.config/gtk-4.0/ 
cp -r ~/.themes/Catppuccin-Mocha-Lavender/gtk-3.0/* ~/.config/gtk-3.0/

# set fish config to Catppuccin mocha

yes | fish_config theme save 'Catppuccin Mocha'

# set firefox usercss to mocha 

cp scripts/userChrome.css ~/.mozilla/firefox/*/default-release/chrome/

# Send a notification that theme is changed to latte. 

notify-send "Changed the theme to Catppuccin Mocha"


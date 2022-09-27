#!/bin/fish

# copy over theme to gtk-4.0 amd gtk-3.0 

cp -r ~/.themes/Catppuccin-Latte-Lavender/gtk-4.0/* ~/.config/gtk-4.0/ 
cp -r ~/.themes/Catppuccin-Latte-Lavender/gtk-3.0/* ~/.config/gtk-3.0/

# set fish config to Catppuccin Latte

yes | fish_config theme save 'Catppuccin Latte'

# Set firefox usercss to latte 

cp scripts/userChrome_latte.css ~/.mozilla/firefox/*.default-release/chrome/userChrome.css

# Send a notification that theme is changed to latte. 

notify-send "Changed the theme to Catppuccin Latte"


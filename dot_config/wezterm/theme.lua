local wezterm = require("wezterm")

local F = {}

F.scheme_for_appearance = function(appearance, theme)
  if appearance:find("Dark") then
    return theme.dark
  else
    return theme.light
  end
end

F.custom_colorscheme = function()
  local americano = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
  americano.background = "#000000"
  americano.tab_bar.background = "#040404"
  americano.tab_bar.inactive_tab.bg_color = "#0f0f0f"
  americano.tab_bar.new_tab.bg_color = "#080808"

  return {
    ["Catppuccin Americano"] = americano
  }
end

return F

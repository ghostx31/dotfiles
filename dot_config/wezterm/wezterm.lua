local wezterm = require("wezterm")
local theme = require("theme")
-- Thanks to winston for a lot of this config :)
-- Look for more of his setup at https://github.com/nekowinston/dotfiles
require("bar").setup({
  dividers = "slant_right", -- or "slant_left", "arrows", "rounded", false
  indicator = {
    leader = {
      enabled = true,
      off = " ",
      on = " ",
    },
    mode = {
      enabled = true,
      names = {
        resize_mode = "RESIZE",
        copy_mode = "VISUAL",
        search_mode = "SEARCH",
      },
    },
  },
  tabs = {
    numerals = "arabic", -- or "roman"
    pane_count = "superscript", -- or "subscript", false
    brackets = {
      active = { "", ":" },
      inactive = { "", ":" },
    },
  },
  clock = { -- note that this overrides the whole set_right_status
    enabled = false,
    format = "%H:%M", -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
  },
})


wezterm.GLOBAL = {
  font = "cartograph",
  enable_tar_bar = true,
}
local font = require("fonts").get_font(wezterm.GLOBAL.font)

local opts = {
  font = font.font,
  font_size = font.size,
  window_decorations = "RESIZE",
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },
  inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 0.6,
  },
  color_schemes = theme.custom_colorscheme(),
  color_scheme = theme.scheme_for_appearance(wezterm.gui.get_appearance(), {
    dark = "Catppuccin Americano",
    light = "Catppuccin Latte",
  }),
  tab_bar_at_bottom = true,
  tab_max_width = 22,
  use_fancy_tab_bar = false,
  window_background_opacity = 1.00,
  hide_tab_bar_if_only_one_tab = false,
  enable_tar_bar = wezterm.GLOBAL.tab_bar_hidden,
  adjust_window_size_when_changing_font_size = false,
  use_resize_increments = false,
  audible_bell = "Disabled",
  clean_exit_codes = { 130 },
  default_cursor_style = "BlinkingBar",
  enable_scroll_bar = false,
  check_for_updates = false,
}
for k, v in pairs(require("keybindings")) do
  opts[k] = v
end

return opts

local wezterm = require("wezterm")

local F = {}
local fonts = {
  cartograph = {
    font = {
      family = "CartographCF Nerd Font",
      harfbuzz_features = {
        "cv06=1",
        "cv14=1",
        "cv32=1",
        "ss04=1",
        "ss07=1",
        "ss09=1",
      },
    },
    size = 14,
    font_rules = {
      italics = false,
    },
  },
}
F.get_font = function(name)
  return {
    font = wezterm.font_with_fallback({
      fonts[name].font,
      "Noto Sans Emoji",
    }),
    size = fonts[name].size,
  }
end

return F

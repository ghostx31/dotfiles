local wezterm = require("wezterm")

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

local function get_font(name)
  return {
    font = wezterm.font_with_fallback({
      fonts[name].font,
      "Noto Color Emoji",
    }),
    size = fonts[name].size,
  }
end

local function numberStyle(number, script)
  local scripts = {
    superscript = {
      "\\u2070",
      "\\u00b9",
      "\\u00b2",
      "\\u00b3",
      "\\u2074",
      "\\u2075",
      "\\u2076",
      "\\u2077",
      "\\u2078",
      "\\u2079",
    },
    subscript = {
      "\\u2080",
      "\\u2081",
      "\\u2082",
      "\\u2083",
      "\\u2084",
      "\\u2085",
      "\\u2086",
      "\\u2087",
      "\\u2088",
      "\\u2089",
    },
  }
  local numbers = scripts[script]
  local number_string = tostring(number)
  local result = ""
  for i = 1, #number_string do
    local char = number_string:sub(i, i)
    local num = tonumber(char)
    if num then
      result = result .. numbers[num + 1]
    else
      result = result .. char
    end
  end
  return result
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local RIGHT_DIVIDER = utf8.char(0xe0bc)
  local colours = config.resolved_palette.tab_bar

  local active_tab_index = 0
  for _, t in ipairs(tabs) do
    if t.is_active == true then
      active_tab_index = t.tab_index
    end
  end

  -- local active_bg = colours.active_tab.bg_color
  local active_bg = config.resolved_palette.ansi[6]
  -- local active_fg = colours.background
  local active_fg = "#000000"
  local inactive_bg = colours.inactive_tab.bg_color
  local inactive_fg = colours.inactive_tab.fg_color
  local new_tab_bg = colours.new_tab.bg_color

  local s_bg, s_fg, e_bg, e_fg

  if tab.tab_index == #tabs - 1 then
    if tab.is_active then
      s_bg = active_bg
      s_fg = active_fg
      e_bg = new_tab_bg
      e_fg = active_bg
    else
      s_bg = inactive_bg
      s_fg = inactive_fg
      e_bg = new_tab_bg
      e_fg = inactive_bg
    end
  elseif tab.tab_index == active_tab_index - 1 then
    s_bg = inactive_bg
    s_fg = inactive_fg
    e_bg = active_bg
    e_fg = inactive_bg
  elseif tab.is_active then
    s_bg = active_bg
    s_fg = active_fg
    e_bg = inactive_bg
    e_fg = active_bg
  else
    s_bg = inactive_bg
    s_fg = inactive_fg
    e_bg = inactive_bg
    e_fg = inactive_bg
  end


  local muxpanes = wezterm.mux.get_tab(tab.tab_id):panes()
  local count = #muxpanes == 1 and "" or #muxpanes

  return {
    { Background = { Color = s_bg } },
    { Foreground = { Color = s_fg } },
    { Text = " " .. tab.tab_index + 1 .. ": " .. tab.active_pane.title .. numberStyle(count, "superscript") .. " " },
    { Background = { Color = e_bg } },
    { Foreground = { Color = e_fg } },
    { Text = RIGHT_DIVIDER },
  }
end)

wezterm.on('update-status', function(window, pane)
  local palette = window:effective_config().resolved_palette
  local firstTabActive = window:mux_window():tabs_with_info()[1].is_active

  local RIGHT_DIVIDER = utf8.char(0xe0b0)
  local text = '   '

  if window:leader_is_active() then
    text = '   '
  end

  local divider_bg = firstTabActive and palette.ansi[6] or palette.tab_bar.inactive_tab.bg_color

  window:set_left_status(wezterm.format({
    { Foreground = { Color = "#000000" } },
    { Background = { Color = palette.ansi[5] } },
    { Text = text },
    { Background = { Color = divider_bg } },
    { Foreground = { Color = palette.ansi[5] } },
    { Text = RIGHT_DIVIDER },
  }))
end)

local window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#000000"
custom.tab_bar.background = "#040404"
custom.tab_bar.inactive_tab.bg_color = "#0f0f0f"
custom.tab_bar.new_tab.bg_color = "#080808"

local darkTheme = "OLEDppuccin"
local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return darkTheme
  else
    return "Catppuccin Latte"
  end
end

local font = get_font("cartograph")
local act = wezterm.action
return {
  disable_default_key_bindings = false,
  leader = { key = "a", mods = "CTRL", timeout_milliseconds = 5002 },
  keys = {
    {
      key = "\\",
      mods = "LEADER",
      action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
    },
    {
      key = "-",
      mods = "LEADER",
      action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }),
    },
    { key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
    { key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
    { key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
    { key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },
    -- -- Shift + 'hjkl' to resize panes
    { key = "h", mods = "LEADER|SHIFT", action = act({ AdjustPaneSize = { "Left", 5 } }) },
    { key = "j", mods = "LEADER|SHIFT", action = act({ AdjustPaneSize = { "Down", 5 } }) },
    { key = "k", mods = "LEADER|SHIFT", action = act({ AdjustPaneSize = { "Up", 5 } }) },
    { key = "l", mods = "LEADER|SHIFT", action = act({ AdjustPaneSize = { "Right", 5 } }) },
    -- numbers to navigate to tabs
    { key = "1", mods = "LEADER", action = act({ ActivateTab = 0 }) },
    { key = "2", mods = "LEADER", action = act({ ActivateTab = 1 }) },
    { key = "3", mods = "LEADER", action = act({ ActivateTab = 2 }) },
    { key = "4", mods = "LEADER", action = act({ ActivateTab = 3 }) },
    { key = "5", mods = "LEADER", action = act({ ActivateTab = 4 }) },
    { key = "6", mods = "LEADER", action = act({ ActivateTab = 5 }) },
    { key = "7", mods = "LEADER", action = act({ ActivateTab = 6 }) },
    { key = "8", mods = "LEADER", action = act({ ActivateTab = 7 }) },
    { key = "9", mods = "LEADER", action = act({ ActivateTab = 8 }) },
    { key = "9", mods = "LEADER", action = act({ ActivateTab = 9 }) },
    { key = "0", mods = "LEADER", action = act({ ActivateTab = -1 }) },
    -- 'c' to create a new tab
    { key = "c", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },
    -- 'x' to kill the current pane
    { key = "x", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },
    -- 'z' to toggle the zoom for the current pane
    { key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
    -- 'v' to visually select in the current pane
    { key = "v", mods = "LEADER", action = "ActivateCopyMode" },
    { key = ' ', mods = "LEADER", action = act.QuickSelect },
    {
      key = 'o',
      mods = "LEADER",
      action = wezterm.action.QuickSelectArgs {
        label = 'open url',
        patterns = {
          'https?://\\S+'
        },
        action = wezterm.action_callback(function(window, pane)
          local url = window:get_selection_text_for_pane(pane)
          wezterm.log_info('opening: ' .. url)
          wezterm.open_with(url)
        end),
      },
    },
  },
  font = font.font,
  font_size = font.size,
  font_rules = fonts.font_rules,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = false,
  tab_max_width = 50,

  window_decorations = "RESIZE",
  window_padding = window_padding,
  color_schemes = {
    ["OLEDppuccin"] = custom,
  },
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  clean_exit_codes = { 130 },
  audible_bell = "Disabled",
  initial_rows = 20,
  initial_cols = 70,
  cursor_thickness = "2",
}

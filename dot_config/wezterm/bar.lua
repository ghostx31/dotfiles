local wezterm = require("wezterm")

local M = {}

M.config = {
  dividers = "slant_right",
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
    numerals = "arabic",
    pane_count = "superscript",
    brackets = {
      active = { "", ":" },
      inactive = { "", ":" },
    },
  },
  clock = {
    enabled = true,
    format = "%H:%M",
  },
}

local function tableMerge(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        tableMerge(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

local C = {}

M.setup = function(config)
  M.config = tableMerge(M.config, config)
  local dividers = {
    slant_right = {
      left = utf8.char(0xe0be),
      right = utf8.char(0xe0bc),
    },
    slant_left = {
      left = utf8.char(0xe0ba),
      right = utf8.char(0xe0b8),
    },
    arrows = {
      left = utf8.char(0xe0b2),
      right = utf8.char(0xe0b0),
    },
    rounded = {
      left = utf8.char(0xe0b6),
      right = utf8.char(0xe0b4),
    },
  }

  C.div = {
    l = "",
    r = "",
  }
  if M.config.dividers then
    C.div.l = dividers[M.config.dividers].left
    C.div.r = dividers[M.config.dividers].right
  end

  C.leader = {
    enabled = M.config.indicator.leader.enabled or true,
    off = M.config.indicator.leader.off,
    on = M.config.indicator.leader.on,
  }

  C.mode = {
    enabled = M.config.indicator.mode.enabled,
    names = M.config.indicator.mode.names,
  }

  C.tabs = {
    numerals = M.config.tabs.numerals,
    pane_count_style = M.config.tabs.pane_count,
    brackets = {
      active = M.config.tabs.brackets.active,
      inactive = M.config.tabs.brackets.inactive,
    },
  }

  C.clock = {
    enabled = M.config.clock.enabled,
    format = M.config.clock.format,
  }

  C.p = (M.config.dividers == "rounded") and "" or " "

  wezterm.log_info(C)
end

-- superscript/subscript
local function numberStyle(number, script)
  local scripts = {
    superscript = {
      "⁰",
      "¹",
      "²",
      "³",
      "⁴",
      "⁵",
      "⁶",
      "⁷",
      "⁸",
      "⁹",
    },
    subscript = {
      "₀",
      "₁",
      "₂",
      "₃",
      "₄",
      "₅",
      "₆",
      "₇",
      "₈",
      "₉",
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

local roman_numerals = {
  "Ⅰ",
  "Ⅱ",
  "Ⅲ",
  "Ⅳ",
  "Ⅴ",
  "Ⅵ",
  "Ⅶ",
  "Ⅷ",
  "Ⅸ",
  "Ⅹ",
  "Ⅺ",
  "Ⅻ",
}

-- custom tab bar
wezterm.on(
  "format-tab-title",
  function(tab, tabs, panes, config, hover, max_width)
    local colours = config.resolved_palette.tab_bar

    local active_tab_index = 0
    for _, t in ipairs(tabs) do
      if t.is_active == true then
        active_tab_index = t.tab_index
      end
    end

    local rainbow = {
      config.resolved_palette.ansi[2],
      config.resolved_palette.indexed[16],
      config.resolved_palette.ansi[4],
      config.resolved_palette.ansi[3],
      config.resolved_palette.ansi[5],
      config.resolved_palette.ansi[1],
    }

    local i = tab.tab_index % 6
    local active_bg = rainbow[i + 1]
    local active_fg = colours.background
    local inactive_bg = colours.inactive_tab.bg_color
    local inactive_fg = colours.inactive_tab.fg_color
    local new_tab_bg = colours.new_tab.bg_color

    local s_bg, s_fg, e_bg, e_fg

    -- the last tab
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
      e_bg = rainbow[(i + 1) % 6 + 1]
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

    local pane_count = ""
    if C.tabs.pane_count_style then
      local tabi = wezterm.mux.get_tab(tab.tab_id)
      local muxpanes = tabi:panes()
      local count = #muxpanes == 1 and "" or tostring(#muxpanes)
      pane_count = numberStyle(count, C.tabs.pane_count_style)
    end

    local index_i
    if C.tabs.numerals == "roman" then
      index_i = roman_numerals[tab.tab_index + 1]
    else
      index_i = tab.tab_index + 1
    end

    if tab.is_active then
      index = string.format(
        "%s%s%s ",
        C.tabs.brackets.active[1],
        index_i,
        C.tabs.brackets.active[2]
      )
    else
      index = string.format(
        "%s%s%s ",
        C.tabs.brackets.inactive[1],
        index_i,
        C.tabs.brackets.inactive[2]
      )
    end

    -- start and end hardcoded numbers are the Powerline + " " padding
    local fillerwidth = 2 + string.len(index) + string.len(pane_count) + 2

    local tabtitle = tab.active_pane.title
    local width = config.tab_max_width - fillerwidth - 1
    if (#tabtitle + fillerwidth) > config.tab_max_width then
      tabtitle = wezterm.truncate_right(tabtitle, width) .. "…"
    end

    local title = string.format(" %s%s%s%s", index, tabtitle, pane_count, C.p)

    return {
      { Background = { Color = s_bg } },
      { Foreground = { Color = s_fg } },
      { Text = title },
      { Background = { Color = e_bg } },
      { Foreground = { Color = e_fg } },
      { Text = C.div.r },
    }
  end
)

-- custom status
wezterm.on("update-status", function(window, pane)
  local active_kt = window:active_key_table() ~= nil
  local show = C.leader.enabled or (active_kt and C.mode.enabled)
  if not show then
    window:set_left_status("")
    return
  end

  local palette = window:effective_config().resolved_palette

  local leader = ""
  if C.leader.enabled then
    local leader_text = C.leader.off
    if window:leader_is_active() then
      leader_text = C.leader.on
    end
    leader = wezterm.format({
      { Foreground = { Color = palette.background } },
      { Background = { Color = palette.ansi[5] } },
      { Text = " " .. leader_text .. C.p },
    })
  end

  local mode = ""
  if C.mode.enabled then
    local mode_text = ""
    local active = window:active_key_table()
    if C.mode.names[active] ~= nil then
      mode_text = C.mode.names[active] .. ""
    end
    mode = wezterm.format({
      { Foreground = { Color = palette.background } },
      { Background = { Color = palette.ansi[5] } },
      { Attribute = { Intensity = "Bold" } },
      { Text = mode_text },
      "ResetAttributes",
    })
  end

  local first_tab_active = window:mux_window():tabs_with_info()[1].is_active
  local divider_bg = first_tab_active and palette.ansi[2]
      or palette.tab_bar.inactive_tab.bg_color

  local divider = wezterm.format({
    { Background = { Color = divider_bg } },
    { Foreground = { Color = palette.ansi[5] } },
    { Text = C.div.r },
  })

  window:set_left_status(leader .. mode .. divider)

  if C.clock.enabled then
    local time = wezterm.time.now():format(C.clock.format)
    window:set_right_status(wezterm.format({
      { Background = { Color = palette.tab_bar.background } },
      { Foreground = { Color = palette.ansi[6] } },
      { Text = time },
    }))
  end
end)

return M

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "catppuccin"
lvim.builtin.lualine.colorscheme = "catppuccin"
lvim.builtin.nvimtree.colorscheme = "catppuccin"
lvim.builtin.bufferline.options.always_show_bufferline = "true"
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.bufferline.options.separator_style = "slant"
lvim.builtin.bufferline.options.right_mouse_command = "bdelete! %d"
local header = {
  type = "text",
  val = {
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣶⣿⣿⣿⣿⣶⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀ ",
    "⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡿⠿⠛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠿⢿⣿⣿⣿⡇⠀⠀⠀⠀⠀ ",
    "⠀⠀⠀⠀⠀⠀⢸⣿⣿⠏⣠⣤⡄⣠⣤⡌⢿⣿⣿⣿⣿⡿⢁⣤⣄⢀⣤⣄⠹⣿⣿⡇⠀⠀⠀⠀⠀ ",
    "⠀⠀⠀⠀⠀⠀⠸⣿⣿⠀⢿⣿⣿⣿⣿⡟⢸⣿⣿⣿⣿⡇⠸⣿⣿⣿⣿⡿⠀⣿⣿⠇⠀⠀⠀⠀⠀ ",
    "⠀⠀⠀⠀⠀⠀⠀⢻⣿⣆⠀⠙⠿⠟⠋⢀⣾⣿⣿⣿⣿⣷⡀⠈⠻⡿⠋⠁⣰⣿⡟⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣶⣶⣶⣾⣿⣿⡿⠋⠙⢿⣿⣿⣷⣶⣶⣶⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢁⣴⣧⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠙⠛⠙⠛⠛⠋⠛⠋⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  },
  opts = {
    position = "center",
    hl = "Label",
  },
}
lvim.builtin.alpha.dashboard.section.header = header
local text = require "lvim.interface.text"
lvim.builtin.alpha.dashboard.section.footer = {
  type = "text",
  val = text.align_center({ width = 0 }, {
    "",
    "Pain",
  }, 0.5),
  opts = {
    position = "center",
    hl = "Number"
  },
}
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.insert_mode = {
  ["jk"] = "<Esc>",
}
vim.g.localleader = "\\"
vim.g.termguicolors = true
-- vim.set.mouse = "r"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
vim.o.guifont = "CartographCF Nerd Font"
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "yaml",
  "go"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true


-- Additional Plugins
lvim.plugins = {
  { "junegunn/vim-emoji" },
  { "ggandor/lightspeed.nvim" },
  { "catppuccin/nvim",
    as = "catppuccin",
    run = ":CatppuccinCompile",
    config = function()
      vim.g.catppuccin_flavour = "mocha"
      require("catppuccin").setup()
      vim.cmd "colorscheme catppuccin"
    end
  },
  { "andweeb/presence.nvim" },
  { "github/copilot.vim" },
  { "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" },
  },
  { "fatih/vim-go" },
  { "p00f/nvim-ts-rainbow",
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "ellisonleao/glow.nvim",
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
}

vim.g.catppuccin_flavour = "mocha"

vim.g.mkdp_auto_start = 0

require("catppuccin").setup({
  dim_inactive = {
    enabled = false,
  },
  transparent_background = false,
  term_colors = true,
  compile = {
    enabled = true,
    path = vim.fn.stdpath "cache" .. "/catppuccin",
  },
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
  },
  color_overrides = {
    mocha = {
      base = "#000000",
      mantle = "#010101",
      crust = "#020202",
    },
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    cmp = true,
    gitgutter = true,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = true,
    },
    dap = {
      enabled = false,
      enable_ui = false,
    },
    which_key = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    dashboard = true,
    neogit = true,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = true,
    notify = true,
    symbols_outline = true,
  },
})
vim.cmd [[colorscheme catppuccin]]

function string.starts(self, str)
  return self:find("^" .. str) ~= nil
end

local hide = function()
  local home = vim.fn.expand("$HOME") .. "/Code/git/"
  local dataconfig = vim.fn.expand("$HOME") .. "/.local/share/"
  local configdir = vim.fn.expand("$HOME") .. "/.config/"
  local blacklistDir = {
    [vim.fn.resolve(home .. "Personal")] = "Breaking stuff.",
    [vim.fn.resolve(configdir .. "lvim/config.lua")] = "Breaking neovim config",
    [vim.fn.resolve(dataconfig .. "/lunarvim/lvim")] = "Breaking neovim config"
  }

  local current_file = vim.fn.expand("%:p")
  for k, v in pairs(blacklistDir) do
    if current_file:starts(k) then
      return v
    end
  end
  return false
end

require("presence"):setup({
  auto_update        = true,
  neovim_image_text  = "idk it just works",
  main_image         = "file",
  -- client_id           = "793271441293967371",
  log_level          = nil,
  debounce_timeout   = 10,
  enable_line_number = false,
  blacklist          = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches

  buttons             = function(repo)
    if repo == nil then
      return false
    end
    local visible = {
      "github.com/catppuccin",
      "github.com/ghostx31",
    }

    for _, visible_url in ipairs(visible) do
      if repo:find(visible_url) then
        return {
          {
            label = "Checkout the repository",
            url = repo,
          },
        }
      end
    end
    return false
  end,
  editing_text        = function(s)
    local hidden = hide()
    if hidden then
      return hidden
    end
    return "Writing in " .. s
  end,
  git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
  plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
  vimsence_client_id  = '439476230543245312',
  reading_text        = function(s)
    local hidden = hide()
    if hidden then
      return hidden
    end
    return "Reading in " .. s
  end,
  file_explorer_text  = function(s)
    local hidden = hide()
    if hidden then
      return hidden
    end
    return "Browsing in " .. s
  end,
  workspace_text      = function(s)
    local hidden = hide()
    if s ~= nil and not hidden then
      return "Working in " .. s
    else
      return nil
    end
  end,
  line_number_text    = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})

-- require 'lspconfig'.marksman.setup {}
require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = true,
  space_char_blankline = " ",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
}

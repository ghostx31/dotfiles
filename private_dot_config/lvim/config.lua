--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "catppuccin"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
lvim.builtin.lualine.colorscheme = "catppuccin"
lvim.builtin.nvimtree.colorscheme = "catppuccin"
lvim.builtin.bufferline.options.always_show_bufferline = "true"
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- if you don't want all the parsers change this to a table of the ones you want
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
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  { "catppuccin/nvim" },
  { "andweeb/presence.nvim" },
  { "github/copilot.vim" },
  { "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, }
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
vim.g.catppuccin_flavour = "mocha"
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1

-- " set to 1, the vim will refresh markdown when save the buffer or
-- " leave from insert mode, default 0 is auto refresh markdown as you edit or
-- " move the cursor
-- " default: 0
vim.g.mkdp_refresh_slow = 0

-- " set to 1, the MarkdownPreview command can be use for all files,
-- " by default it can be use in markdown file
-- " default: 0
vim.g.mkdp_command_for_global = 0

-- " set to 1, preview server available to others in your network
-- " by default, the server listens on localhost (127.0.0.1)
-- " default: 0
vim.g.mkdp_open_to_the_world = 0

-- " use custom IP to open preview page
-- " useful when you work in remote vim and preview on local browser
-- " more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
-- " default empty
vim.g.mkdp_open_ip = ''

-- " specify browser to open preview page
-- " for path with space
-- " valid: `/path/with\ space/xxx`
-- " invalid: `/path/with\\ space/xxx`
-- " default: ''
vim.g.mkdp_browser = ''

-- " set to 1, echo preview page url in command line when open preview page
-- " default is 0
vim.g.mkdp_echo_preview_url = 0

-- " a custom vim function name to open preview page
-- " this function will receive url as param
-- " default is empty
vim.g.mkdp_browserfunc = ''

-- " options for markdown render
-- " mkit: markdown-it options for render
-- " katex: katex options for math
-- " uml: markdown-it-plantuml options
-- " maid: mermaid options
-- " disable_sync_scroll: if disable sync scroll, default 0
-- " sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
-- "   middle: mean the cursor position alway show at the middle of the preview page
-- "   top: mean the vim top viewport alway show at the top of the preview page
-- "   relative: mean the cursor position alway show at the relative positon of the preview page
-- " hide_yaml_meta: if hide yaml metadata, default is 1
-- " sequence_diagrams: js-sequence-diagrams options
-- " content_editable: if enable content editable for preview page, default: v:false
-- " disable_filename: if disable filename header for preview page, default: 0
-- vim.g.mkdp_preview_options = {
--      'mkit': {},
--      'katex': {},
--      'uml': {},
--      'maid': {},
--      'disable_sync_scroll': 0,
--      'sync_scroll_type': 'middle',
--      'hide_yaml_meta': 1,
--      'sequence_diagrams': {},
--      'flowchart_diagrams': {},
--      'content_editable': v:false,
--      'disable_filename': 0,
--      'toc': {}
--      }

-- " use a custom markdown style must be absolute path
-- " like '/Users/username/markdown.css' or expand('~/markdown.css')
vim.g.mkdp_markdown_css = ''

-- " use a custom highlight style must absolute path
-- " like '/Users/username/highlight.css' or expand('~/highlight.css')
vim.g.mkdp_highlight_css = ''

-- " use a custom port to start server or empty for random
vim.g.mkdp_port = ''

-- " preview page title
-- " ${name} will be replace with the file name
vim.g.mkdp_page_title = '「${name}」'

-- " recognized filetypes
-- " these filetypes will have MarkdownPreview... commands
vim.g.mkdp_filetypes = 'markdown'

--" set default theme (dark or light)
-- " By default the theme is define according to the preferences of the system
vim.g.mkdp_theme = 'dark'
require("catppuccin").setup({
 dim_inactive = {
  enabled = false,
  shade = "dark",
  percentage = 0.15,
 },
 transparent_background = false,
 term_colors = false,
 compile = {
  enabled = false,
  path = vim.fn.stdpath "cache" .. "/catppuccin",
 },
 styles = {
  comments = { "italic" },
  conditionals = { "italic" },
  loops = {},
  functions = {},
  keywords = {},
  strings = {},
  variables = {},
  numbers = {},
  booleans = {},
  properties = {},
  types = {},
  operators = {},
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
  coc_nvim = true,
  lsp_trouble = false,
  cmp = true,
  lsp_saga = false,
  gitgutter = true,
  gitsigns = true,
  leap = false,
  telescope = true,
  nvimtree = {
   enabled = true,
   show_root = true,
   transparent_panel = false,
  },
  neotree = {
   enabled = false,
   show_root = true,
   transparent_panel = false,
  },
  dap = {
   enabled = false,
   enable_ui = false,
  },
  which_key = false,
  indent_blankline = {
   enabled = true,
   colored_indent_levels = false,
  },
  dashboard = true,
  neogit = false,
  vim_sneak = false,
  fern = false,
  barbar = false,
  bufferline = true,
  markdown = true,
  lightspeed = false,
  ts_rainbow = false,
  hop = false,
  notify = true,
  telekasten = true,
  symbols_outline = true,
  mini = false,
  aerial = false,
  vimwiki = true,
  beacon = true,
 },
 color_overrides = {},
 highlight_overrides = {},
})
vim.cmd [[colorscheme catppuccin]]

-- The setup config table shows all available config options with their default values:
require("presence"):setup({
    -- General options
    auto_update         = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
    main_image          = "neovim", -- Main image display (either "neovim" or "file")
    client_id           = "793271441293967371", -- Use your own Discord application client id (not recommended)
    log_level           = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false, -- Displays the current line number instead of the current project
    blacklist           = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons             = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets         = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)

    -- Rich Presence text options
    editing_text        = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})

-- function map(mode, lhs, rhs, opts)
--     local options = { noremap = true }
--     if opts then
--         options = vim.tbl_extend("force", options, opts)
--     end
--     vim.api.nvim_set_keymap(mode, lhs, rhs, options)
-- end

-- map("n", "<C-m>", ":MarkdownPreview", { silent = true })

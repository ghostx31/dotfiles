" Plug {{{
call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-telescope/telescope.nvim'
Plug 'catppuccin/nvim', {'as':'catppuccin'}
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'kyazdani42/nvim-tree.lua'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', {'do': 'yarn install' }
Plug 'sheerun/vim-polyglot'
Plug 'glepnir/dashboard-nvim'
Plug 'preservim/nerdcommenter'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'feline-nvim/feline.nvim', { 'branch': 'develop' }
Plug 'akinsho/bufferline.nvim'
Plug 'BurntSushi/ripgrep'
call plug#end()
" }}}
" VIM CONFIGURATION {{{
set mouse=v
set tabstop=4
set softtabstop=4
set number
syntax on 
set nocompatible
filetype on
filetype indent on
filetype plugin on
set wildmenu
set wildmode=list:longest
let mapleader = " "
nmap <leader>vs :vsplit<cr>
nmap <leader>hs :split<cr>
imap jj <Esc>
colorscheme catppuccin
set foldenable
set foldmethod=marker
set foldmarker={{{,}}}
set shiftwidth=4
set expandtab 
set hlsearch
set history=100
set encoding=utf-8
" }}}
" COC {{{
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}}
" Dashboard {{{
let g:dashboard_default_executive ='telescope'
let g:dashboard_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
let g:dashboard_custom_shortcut={
\ 'last_session'       : 'SPC l l',
\ 'find_history'       : 'SPC d h ',
\ 'find_file'          : 'SPC d f',
\ 'new_file'           : 'SPC n n',
\ 'change_colorscheme' : 'SPC w q',
\ 'find_word'          : 'SPC f a',
\ 'book_marks'         : 'SPC b b',
\ }
" }}}
" NvimTree {{{
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_indent_markers = 0 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_create_in_closed_folder = 0 "1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_refresh_wait = 500 "1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue
lua << EOF
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nautilus,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'right',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  }
}
EOF
" }}}
" NerdCommenter {{{
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
" }}}
" Telescope {{{
lua << EOF
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
}
EOF

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" }}}
" Feline {{{
lua << EOF
if not pcall(require, "feline") then
  return
end

local colors = {
    bg = '#1A1823',
    fg = '#D9E0EE',
    yellow = '#FAE3B0',
    cyan = '#B5E8E0',
    darkblue = '#96CDFB',
    green = '#ABE9B3',
    orange = '#F8BD96',
    violet = '#DDB6F2',
    magenta = '#E8A2AF',
    blue = '#96CDFB',
    red = '#F28FAD'
}

local vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.red,
    VISUAL = colors.magenta,
    OP = colors.green,
    BLOCK = colors.blue,
    REPLACE = colors.violet,
    ['V-REPLACE'] = colors.violet,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.green,
    SHELL = colors.green,
    TERM = colors.green,
    NONE = colors.yellow
}

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
  if os == 'UNIX' then
      icon = ' '
  elseif os == 'MAC' then
      icon = ' '
  else
      icon = ' '
  end
  return icon .. os
end

local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'

local lsp_get_diag = function(str)
local count = vim.lsp.diagnostic.get_count(0, str)
return (count > 0) and ' '..count..' ' or ''
end

-- LuaFormatter off

local comps = {
  vi_mode = {
      left = {
          provider = function()
            return '  ' .. vi_mode_utils.get_vim_mode()
          end,
          hl = function()
              local val = {
                  name = vi_mode_utils.get_mode_highlight_name(),
                  fg = vi_mode_utils.get_mode_color(),
                  -- fg = colors.bg
              }
              return val
          end,
          right_sep = ' '
      },
      right = {
          -- provider = '▊',
          provider = '' ,
          hl = function()
              local val = {
                  name = vi_mode_utils.get_mode_highlight_name(),
                  fg = vi_mode_utils.get_mode_color()
              }
              return val
          end,
          left_sep = ' ',
          right_sep = ' '
      }
  },
  file = {
      info = {
          provider = {
            name = 'file_info',
            opts = {
              type = 'relative-short',
              file_readonly_icon = '  ',
              -- file_readonly_icon = '  ',
              -- file_readonly_icon = '  ',
              -- file_readonly_icon = '  ',
              -- file_modified_icon = '',
              file_modified_icon = '',
              -- file_modified_icon = 'ﱐ',
              -- file_modified_icon = '',
              -- file_modified_icon = '',
              -- file_modified_icon = '',
            }
          },
          hl = {
              fg = colors.blue,
              style = 'bold'
          }
      },
      encoding = {
          provider = 'file_encoding',
          left_sep = ' ',
          hl = {
              fg = colors.violet,
              style = 'bold'
          }
      },
      type = {
          provider = 'file_type'
      },
      os = {
          provider = file_osinfo,
          left_sep = ' ',
          hl = {
              fg = colors.violet,
              style = 'bold'
          }
      },
      position = {
          provider = 'position',
          left_sep = ' ',
          hl = {
              fg = colors.cyan,
              -- style = 'bold'
          }
      },
  },
  left_end = {
      provider = function() return '' end,
      hl = {
          fg = colors.bg,
          bg = colors.blue,
      }
  },
  line_percentage = {
      provider = 'line_percentage',
      left_sep = ' ',
      hl = {
          style = 'bold'
      }
  },
  scroll_bar = {
      provider = 'scroll_bar',
      left_sep = ' ',
      hl = {
          fg = colors.blue,
          style = 'bold'
      }
  },
  diagnos = {
      err = {
          -- provider = 'diagnostic_errors',
          provider = function()
              return '' .. lsp_get_diag("Error")
          end,
          -- left_sep = ' ',
          enabled = function() return lsp.diagnostics_exist('Error') end,
          hl = {
              fg = colors.red
          }
      },
      warn = {
          -- provider = 'diagnostic_warnings',
          provider = function()
              return '' ..  lsp_get_diag("Warn")
          end,
          -- left_sep = ' ',
          enabled = function() return lsp.diagnostics_exist('Warn') end,
          hl = {
              fg = colors.yellow
          }
      },
      info = {
          -- provider = 'diagnostic_info',
          provider = function()
              return '' .. lsp_get_diag("Info")
          end,
          -- left_sep = ' ',
          enabled = function() return lsp.diagnostics_exist('Info') end,
          hl = {
              fg = colors.blue
          }
      },
      hint = {
          -- provider = 'diagnostic_hints',
          provider = function()
              return '' .. lsp_get_diag("Hint")
          end,
          -- left_sep = ' ',
          enabled = function() return lsp.diagnostics_exist('Hint') end,
          hl = {
              fg = colors.cyan
          }
      },
  },
  lsp = {
      name = {
          provider = 'lsp_client_names',
          -- left_sep = ' ',
          right_sep = ' ',
          -- icon = '  ',
          icon = '慎',
          hl = {
              fg = colors.yellow
          }
      }
  },
  git = {
      branch = {
          provider = 'git_branch',
          icon = ' ',
          -- icon = ' ',
          left_sep = ' ',
          hl = {
              fg = colors.violet,
              style = 'bold'
          },
      },
      add = {
          provider = 'git_diff_added',
          hl = {
              fg = colors.green
          }
      },
      change = {
          provider = 'git_diff_changed',
          hl = {
              fg = colors.orange
          }
      },
      remove = {
          provider = 'git_diff_removed',
          hl = {
              fg = colors.red
          }
      }
  }
}

local components = {
active = {},
inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], comps.git.branch)
table.insert(components.active[1], comps.git.add)
table.insert(components.active[1], comps.git.change)
table.insert(components.active[1], comps.git.remove)
table.insert(components.inactive[1], comps.vi_mode.left)
table.insert(components.inactive[1], comps.file.info)
table.insert(components.active[3], comps.diagnos.err)
table.insert(components.active[3], comps.diagnos.warn)
table.insert(components.active[3], comps.diagnos.hint)
table.insert(components.active[3], comps.diagnos.info)
table.insert(components.active[3], comps.lsp.name)
table.insert(components.active[3], comps.file.os)
table.insert(components.active[3], comps.file.position)
table.insert(components.active[3], comps.line_percentage)
table.insert(components.active[3], comps.scroll_bar)
table.insert(components.active[3], comps.vi_mode.right)


-- TreeSitter
-- local ts_utils = require("nvim-treesitter.ts_utils")
-- local ts_parsers = require("nvim-treesitter.parsers")
-- local ts_queries = require("nvim-treesitter.query")
--[[ table.insert(components.active[2], {
provider = function()
  local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
  return ("%d:%s [%d, %d] - [%d, %d]")
    :format(node:symbol(), node:type(), node:range())
end,
enabled = function()
  local ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
  return ok and ts_parsers.has_parser()
end
}) ]]

-- require'feline'.setup {}
require'feline'.setup {
  colors = { bg = colors.bg, fg = colors.fg },
  components = components,
  vi_mode_colors = vi_mode_colors,
  force_inactive = {
      filetypes = {
          'packer',
          'NvimTree',
          'fugitive',
          'fugitiveblame'
      },
      buftypes = {'terminal'},
      bufnames = {}
  }
}
EOF
" }}}
" Bufferline {{{
lua << EOF
require('bufferline').setup {
   options = {
      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
      buffer_close_icon = "",
      modified_icon = "",
      close_icon = "",
      show_close_icon = true,
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      view = "multiwindow",
      show_buffer_close_icons = true,
      separator_style = "thin",
      always_show_bufferline = true,
      diagnostics = false,
      custom_filter = function(buf_number)
         -- Func to filter out our managed/persistent split terms
         local present_type, type = pcall(function()
            return vim.api.nvim_buf_get_var(buf_number, "term_type")
         end)

         if present_type then
            if type == "vert" then
               return false
            elseif type == "hori" then
               return false
            end
            return true
         end

         return true
      end,
   },
}
EOF
" }}}
" TreeSitter {{{
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",
  sync_install = false,
  highlight = {
      enable = true,
    },
}
EOF

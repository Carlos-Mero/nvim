vim.opt.display = "lastline"
vim.opt.smoothscroll = true

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'tf', builtin.find_files, {})
vim.keymap.set('n', 'tg', builtin.live_grep, {})
vim.keymap.set('n', 'tb', builtin.buffers, {})
vim.keymap.set('n', 'th', builtin.help_tags, {})
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('v', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('v', 'k', 'gk')
vim.keymap.set('n', 'z', '<cmd>bd|bp<CR>')
vim.keymap.set('n', 'q', '<cmd>q<CR>', {noremap = true, silent = true})
vim.keymap.set({'i', 'c', 't', 'v'}, 'vd', '<ESC>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<CR>', {buffer = bufnr})

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "c", "cpp", "json", "json5", "markdown", "markdown_inline", "toml", "csv",
      "lua", "vim", "vimdoc", "query", "python", "yaml", "xml", "latex", "html",
      "css", "javascript", "typescript", "swift", "rust", "bibtex", "bash", "fish",
      "make", "godot_resource", "ssh_config", "typst"},
  sync_install = true,
  auto_install = true,
  ignore_install = {},
  modules = {},
  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 16777216 -- 16MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      scope_incremental = '<TAB>',
    }
  },
  indent = {
    enable = true
  },
}

vim.api.nvim_set_keymap("n", "<leader>t", ":term<CR>", {noremap = true, silent = true})
local term_mode = vim.api.nvim_create_augroup("TERM_MODE", {clear = true})
vim.api.nvim_create_autocmd({"TermOpen"}, {
    pattern = "*",
    group = term_mode,
    command = [[normal i]]
})
vim.api.nvim_create_autocmd({"TermOpen"}, {
    pattern = "*",
    group = term_mode,
    command = [[setlocal nonumber]]
})

local function nvim_tree_keymap(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
  vim.keymap.set('n', 'o',       api.node.open.edit,                  opts('Open'))
  vim.keymap.set('n', '<TAB>',       api.node.open.edit,              opts('Open'))
  vim.keymap.set('n', '<CR>',   api.tree.change_root_to_node,         opts('CD'))
  vim.keymap.set('n', '>',       api.node.navigate.sibling.next,      opts('Next Sibling'))
  vim.keymap.set('n', '<',       api.node.navigate.sibling.prev,      opts('Previous Sibling'))
  vim.keymap.set('n', '.',       api.node.run.cmd,                    opts('Run Command'))
  vim.keymap.set('n', '-',       api.tree.change_root_to_parent,      opts('Up'))
  vim.keymap.set('n', 'n',       api.fs.create,                       opts('Create'))
  vim.keymap.set('n', 'D',       api.fs.remove,                       opts('Delete'))
  vim.keymap.set('n', 'd',       api.fs.trash,                        opts('Trash'))
  vim.keymap.set('n', 'r',       api.fs.rename_basename,              opts('Rename: Basename'))
  vim.keymap.set('n', 's',       api.node.run.system,                 opts('Run System'))
  vim.keymap.set('n', 'S',       api.tree.search_node,                opts('Search'))
  vim.keymap.set('n', 'u',       api.fs.rename_full,                  opts('Rename: Full Path'))
  vim.keymap.set('n', 'U',       api.tree.toggle_custom_filter,       opts('Toggle Filter: Hidden'))
  vim.keymap.set('n', 'W',       api.tree.collapse_all,               opts('Collapse'))
  vim.keymap.set('n', 'x',       api.fs.cut,                          opts('Cut'))
  vim.keymap.set('n', 'y',       api.fs.copy.filename,                opts('Copy Name'))
  vim.keymap.set('n', 'Y',       api.fs.copy.relative_path,           opts('Copy Relative Path'))
  vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'z',       api.tree.close,                      opts('Close'))
end

require('nvim-tree').setup({
    on_attach = nvim_tree_keymap,
    view = {width = 24}
})
require('telescope').setup{
    defaults = {
        mappings = {
            n = {
                ["q"] = "close",
                ["o"] = "select_default",
                ["J"] = "preview_scrolling_down",
                ["K"] = "preview_scrolling_up",
                ["H"] = "preview_scrolling_left",
                ["L"] = "preview_scrolling_right",
            },
        },
    },
}

vim.cmd([[
  set hls ic
  set number
  set cursorline
  set linebreak
  set smartindent
  set smartcase
  set encoding=utf-8
  set laststatus=2
  set ts=4
  set expandtab
  set shiftwidth=4
  set nofoldenable
  set display=lastline
  set noshowmode
  set noshowcmd
  set noimdisable
  set signcolumn=no
  set pumheight=13
  set spr

  let g:loaded_matchparen = 1
  set diffopt=vertical
  au FileType csv setlocal nowrap
  set mouse=a
  set mousescroll=ver:1,hor:1
"  let g:python3_host_prog = '/opt/homebrew/bin/python3.11'

  nnoremap <leader>n :NvimTreeToggle<CR>
  nnoremap <silent>    ; <Cmd>BufferPrevious<CR>
  nnoremap <silent>    ' <Cmd>BufferNext<CR>
  nnoremap <leader>w <Cmd>TypstWatch<CR>
  nnoremap <leader>/ :nohl<CR>
  nnoremap <leader>x :bd<CR>
  nnoremap <M-x> :bd!<CR>
  noremap <SPACE>h <C-W>h
  noremap <C-h> <C-W>h
  noremap <SPACE>j <C-W>j
  noremap <C-j> <C-W>j
  noremap <SPACE>k <C-W>k
  noremap <C-k> <C-W>k
  noremap <SPACE>l <C-W>l
  noremap <C-l> <C-W>l
  noremap <SPACE>H <C-W>H
  noremap <SPACE>J <C-W>J
  noremap <SPACE>K <C-W>K
  noremap <SPACE>L <C-W>L
  noremap <SPACE>+ 3<C-W>+
  noremap <SPACE>- 3<C-W>-
  noremap <SPACE>> <C-W>>
  noremap <SPACE>< <C-W><
  noremap <SPACE>w <C-W>_
  tnoremap <C-x> <C-\><C-N>
  tnoremap <ESC> <C-\><C-N>
  noremap <SPACE><Down> <C-W><Down>
  noremap <SPACE><Up> <C-W><Up>
  noremap <SPACE><Left> <C-W><Left>
  noremap <SPACE><Right> <C-W><Right>
  noremap J <C-D>
  noremap K <C-U>
  noremap H g0
  noremap L g$
  noremap D <C-D>
  noremap U <C-U>
  inoremap <M-j> <Down>
  inoremap <M-k> <Up>
  inoremap <M-h> <Left>
  inoremap <M-l> <Right>
  inoremap <M-Left> <C-O>0
  inoremap <M-Right> <C-O>$
  inoremap <M-Up> <C-O>gg
  inoremap <M-Down> <C-O>G
  noremap <c-n> :%!xxd<CR>

  colorscheme tokyonight-moon

  hi dbknum guifg=#f9f9f9 guibg=#ec6645 gui=bold
  hi dbkline guibg=#2e2431
  hi dstnum guifg=#ffffff guibg=#aebbe7 gui=bold
  hi dstline guibg=#105021
  hi Normal guifg=#ffffff guibg=None ctermfg=None ctermbg=None
  hi Function guifg=#bdd0f1 gui=bold
  hi Structure gui=bold
  hi Class gui=bold
  hi Title guifg=#bdd0f1 gui=bold
  hi PMenuSel gui=bold
  hi NormalNC guibg=None
  hi Type guifg=#e2bdee
  hi LspInlayHint guibg=None
  hi CursorLine guibg=None ctermbg=None
  hi Operator guifg=#80a1d9
  hi Property guifg=#c7eca1
  hi @property guifg=#c7eca1
  hi link @lsp.type.property Property
  hi link @lsp.typemod.unknown.dependentName.cpp Property
  hi @type.builtin guifg=#e2bdee
  hi Statement guifg=#ffffff gui=bold
  hi @conditional guifg=#ffffff gui=bold
  hi @nospell guifg=#c7eca1
  hi @none guifg=#bdd0f1
  hi link cConditional Repeat
  hi Todo guifg=#ffffff guibg=#f18342 gui=bold
  hi link Noise Special
  hi @lsp.typemod.text.math.typst gui=bold
  hi @lsp.typemod.pol.math.typst guifg=#eecdef gui=bold
  hi link @lsp.typemod.string.math.typst String
  hi @lsp.type.function.typst guifg=#c7eca1 gui=bold
  hi link @lsp.typemod.function.math.typst Function
  hi @lsp.type.link.typst guifg=#eea8e2
  hi @lsp.type.label.typst guifg=#bdd0f1
  hi @lsp.type.heading.typst guifg=#eff3ff gui=bold
  hi link typstMarkupHeading Normal
  hi link @lsp.type.raw.typst Statement
  hi @keyword guifg=#bdd0f1 gui=None
  hi link @identifier.typst Macro
  hi link @text.typst Normal
  hi @field guifg=#c7eca1
  hi Special guifg=#bdd0f1
  hi PreProc guifg=#90dc93
  hi texMathDelimZoneTI guifg=#919191
  hi texMathDelimZoneTD guifg=#919191
  hi LineNr guifg=#8e7faa ctermfg=15
  hi cursorlinenr guifg=#f0f0f0 guibg=#eea8e2
  hi Visual guifg=#ffffff guibg=#eea8e2 guisp=#eea8e2 ctermfg=255 ctermbg=141
  hi DiagnosticUnnecessary guifg=#8e7faa ctermfg=15
  hi DiagnosticSignError guibg=#faf0f8 guifg=Red
  hi DiagnosticSignWarn guibg=#faf0f8 guifg=Yellow
  hi DiagnosticSignInfo guibg=#faf0f8 guifg=DarkBlue
  hi DiagnosticSignHint guibg=#faf0f8 guifg=SlateBlue
  hi link CocFloatActive String
  hi link CocSearch String
  hi Macro guifg=#ea735c
  hi Comment cterm=italic gui=italic guifg=#939fc9
  hi link CocSemMacro Macro
  hi link CocSemProperty Normal
  hi Structure gui=bold
  hi link CocSemClass Structure
  hi Repeat gui=bold
  hi Directory gui=bold
  hi BufferCurrentSign guifg=#82aaff
  hi BufferCurrentMod guifg=#82aaff
  hi BufferLineIndicatorSelected guibg=#eea8e2
  hi MatchParen guifg=#fdfdfd guibg=#eea8e2
  hi mkdBlockquote guifg=#aaaaaa gui=italic
  hi @punctuation.special guifg=#e2bdee
  hi @namespace.cpp guifg=#90dc93 gui=bold
  hi link @constant.builtin.cpp Macro
  hi link @keyword.conditional.cpp @conditional
  hi link @keyword.conditional.c @conditional
  hi @string.csv guifg=#eecdef gui=bold
  hi link @property.yaml @keyword
  hi @constant.typst guifg=#eecdef gui=bold
  hi @markup.math.typst guifg=#bdd0f1 gui=bold
  hi @markup.raw.typst guifg=NONE
  hi @markup.raw.block.typst guifg=NONE
  hi @variable guifg=NONE
  hi AerialLine guifg=#c7eca1 gui=bold
  hi link @constant.builtin.c Macro
  hi PMenuSel guifg=#eecdef guibg=#4a314a guisp=#4a314a gui=bold ctermfg=202 ctermbg=252 cterm=bold
]])

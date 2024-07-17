vim.o.encoding = "utf-8"
vim.o.termguicolors = true
vim.o.number = true
vim.o.smartcase = true
vim.o.breakindent = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.updatetime = 241
vim.o.timeoutlen = 241
vim.o.signcolumn = 'no'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.linebreak = true
vim.o.hlsearch = true
vim.o.foldenable = false
vim.o.showmode = false
vim.o.laststatus = 2
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.display = 'lastline'
vim.o.pumheight = 13
vim.o.smoothscroll = true
vim.o.mousescroll = 'ver:1,hor:1'

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'tf', builtin.find_files, {})
vim.keymap.set('n', 'tg', builtin.live_grep, {})
vim.keymap.set('n', 'tb', builtin.buffers, {})
vim.keymap.set('n', 'th', builtin.help_tags, {})
vim.keymap.set('n', 'z', '<cmd>bd|bp<CR>')
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<CR>', {buffer = bufnr})

local kopts = {noremap = true, silent = true}
vim.keymap.set('n', 'q', '<cmd>q<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>n', '<Cmd>NvimTreeToggle<CR>', kopts)
vim.keymap.set('n', ';', '<Cmd>BufferPrevious<CR>', kopts)
vim.keymap.set('n', "'", '<Cmd>BufferNext<CR>', kopts)
vim.keymap.set('n', '<leader>w', '<Cmd>TypstWatch<CR>', kopts)
vim.keymap.set('n', '<leader>/', '<Cmd>nohl<CR>', kopts)
vim.keymap.set('n', '<leader>x', '<Cmd>bd<CR>', kopts)
vim.keymap.set('n', '<M-x>', '<Cmd>bd!<CR>', kopts)
vim.keymap.set('n', '<SPACE>h', '<C-W>h', kopts)
vim.keymap.set('n', '<C-h>', '<C-W>h', kopts)
vim.keymap.set('n', '<SPACE>j', '<C-W>j', kopts)
vim.keymap.set('n', '<C-j>', '<C-W>j', kopts)
vim.keymap.set('n', '<SPACE>k', '<C-W>k', kopts)
vim.keymap.set('n', '<C-k>', '<C-W>k', kopts)
vim.keymap.set('n', '<SPACE>l', '<C-W>l', kopts)
vim.keymap.set('n', '<C-l>', '<C-W>l', kopts)
vim.keymap.set('n', '<SPACE>H', '<C-W>H', kopts)
vim.keymap.set('n', '<SPACE>J', '<C-W>J', kopts)
vim.keymap.set('n', '<SPACE>K', '<C-W>K', kopts)
vim.keymap.set('n', '<SPACE>L', '<C-W>L', kopts)
vim.keymap.set('n', '<SPACE>+', '3<C-W>+', kopts)
vim.keymap.set('n', '<SPACE>-', '3<C-W>-', kopts)
vim.keymap.set({'n', 'v'}, 'j', 'gj', kopts)
vim.keymap.set({'n', 'v'}, 'k', 'gk', kopts)
vim.keymap.set({'n', 'v'}, 'J', '<C-D>', kopts)
vim.keymap.set({'n', 'v'}, 'K', '<C-U>', kopts)
vim.keymap.set({'n', 'v'}, 'H', 'g0', kopts)
vim.keymap.set({'n', 'v'}, 'L', 'g$', kopts)
vim.keymap.set({'n', 'v'}, 'D', '<C-D>', kopts)
vim.keymap.set({'n', 'v'}, 'U', '<C-U>', kopts)
vim.keymap.set('n', '<c-n>', ':%!xxd<CR>', kopts)
vim.keymap.set("n", "<leader>t", ":term<CR>", kopts)

vim.keymap.set('i', '<M-j>', '<Down>', opts)
vim.keymap.set('i', '<M-k>', '<Up>', opts)
vim.keymap.set('i', '<M-h>', '<Left>', opts)
vim.keymap.set('i', '<M-l>', '<Right>', opts)
vim.keymap.set('i', '<M-Left>', '<C-O>0', opts)
vim.keymap.set('i', '<M-Right>', '<C-O>$', opts)
vim.keymap.set('i', '<M-Up>', '<C-O>gg', opts)
vim.keymap.set('i', '<M-Down>', '<C-O>G', opts)

vim.keymap.set('t', '<C-x>', '<C-\\><C-N>', opts)
vim.keymap.set('t', '<ESC>', '<C-\\><C-N>', opts)

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
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'csv',
    command = 'setlocal nowrap'
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


vim.cmd.colorscheme 'tokyonight'

local function set_highlight(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

set_highlight('dbknum', { fg = '#f9f9f9', bg = '#ec6645', bold = true })
set_highlight('dbkline', { bg = '#2e2431' })
set_highlight('dstnum', { fg = '#ffffff', bg = '#aebbe7', bold = true })
set_highlight('dstline', { bg = '#105021' })
set_highlight('Normal', { fg = '#ffffff', bg = 'None' })
set_highlight('Function', { fg = '#bdd0f1', bold = true })
set_highlight('Structure', { bold = true })
set_highlight('Class', { bold = true })
set_highlight('Title', { fg = '#bdd0f1', bold = true })
set_highlight('PMenuSel', { bold = true })
set_highlight('NormalNC', { bg = 'None' })
set_highlight('Type', { fg = '#e2bdee' })
set_highlight('LspInlayHint', { bg = 'None' })
set_highlight('CursorLine', { bg = 'None' })
set_highlight('Operator', { fg = '#80a1d9' })
set_highlight('Property', { fg = '#c7eca1' })
set_highlight('@property', { fg = '#c7eca1' })
set_highlight('@type.builtin', { fg = '#e2bdee' })
set_highlight('Statement', { fg = '#ffffff', bold = true })
set_highlight('@conditional', { fg = '#ffffff', bold = true })
set_highlight('@nospell', { fg = '#c7eca1' })
set_highlight('@none', { fg = '#bdd0f1' })
set_highlight('Todo', { fg = '#ffffff', bg = '#f18342', bold = true })
set_highlight('@lsp.typemod.text.math.typst', { bold = true })
set_highlight('@lsp.typemod.pol.math.typst', { fg = '#eecdef', bold = true })
set_highlight('@lsp.type.function.typst', { fg = '#c7eca1', bold = true })
set_highlight('@lsp.type.link.typst', { fg = '#eea8e2' })
set_highlight('@lsp.type.label.typst', { fg = '#bdd0f1' })
set_highlight('@lsp.type.heading.typst', { fg = '#eff3ff', bold = true })
set_highlight('@keyword', { fg = '#bdd0f1', bold = false, italic = false })
set_highlight('@field', { fg = '#c7eca1' })
set_highlight('Special', { fg = '#bdd0f1' })
set_highlight('PreProc', { fg = '#90dc93' })
set_highlight('texMathDelimZoneTI', { fg = '#919191' })
set_highlight('texMathDelimZoneTD', { fg = '#919191' })
set_highlight('LineNr', { fg = '#8e7faa' })
set_highlight('cursorlinenr', { fg = '#f0f0f0', bg = '#eea8e2' })
set_highlight('Visual', { fg = '#ffffff', bg = '#eea8e2', sp = '#eea8e2' })
set_highlight('Macro', { fg = '#ea735c' })
set_highlight('Comment', { italic = true, fg = '#939fc9' })
set_highlight('Structure', { bold = true })
set_highlight('Repeat', { bold = true })
set_highlight('Directory', { bold = true })
set_highlight('BufferCurrentSign', { fg = '#82aaff', bg = '#102140' })
set_highlight('BufferCurrentMod', { fg = '#82aaff', bg = '#102140' })
set_highlight('BufferLineIndicatorSelected', { bg = '#eea8e2' })
set_highlight('MatchParen', { fg = '#fdfdfd', bg = '#eea8e2' })
set_highlight('mkdBlockquote', { fg = '#aaaaaa', italic = true })
set_highlight('@punctuation.special', { fg = '#e2bdee' })
set_highlight('@namespace.cpp', { fg = '#90dc93', bold = true })
set_highlight('@string.csv', { fg = '#eecdef', bold = true })
set_highlight('@constant.typst', { fg = '#eecdef', bold = true })
set_highlight('@markup.math.typst', { fg = '#bdd0f1', bold = true })
set_highlight('@markup.raw.typst', { fg = 'NONE' })
set_highlight('@markup.raw.block.typst', { fg = 'NONE' })
set_highlight('@variable', { fg = 'NONE' })
set_highlight('AerialLine', { fg = '#c7eca1', bold = true })

vim.api.nvim_set_hl(0, '@lsp.type.property', { link = 'Property' })
vim.api.nvim_set_hl(0, '@lsp.typemod.unknown.dependentName.cpp', { link = 'Property' })
vim.api.nvim_set_hl(0, 'cConditional', { link = 'Repeat' })
vim.api.nvim_set_hl(0, 'Noise', { link = 'Special' })
vim.api.nvim_set_hl(0, '@lsp.typemod.string.math.typst', { link = 'String' })
vim.api.nvim_set_hl(0, '@lsp.typemod.function.math.typst', { link = 'Function' })
vim.api.nvim_set_hl(0, 'typstMarkupHeading', { link = 'Normal' })
vim.api.nvim_set_hl(0, '@lsp.type.raw.typst', { link = 'Statement' })
vim.api.nvim_set_hl(0, '@identifier.typst', { link = 'Macro' })
vim.api.nvim_set_hl(0, '@text.typst', { link = 'Normal' })
vim.api.nvim_set_hl(0, '@property.yaml', { link = '@keyword' })
vim.api.nvim_set_hl(0, '@constant.builtin.c', { link = 'Macro' })
vim.api.nvim_set_hl(0, '@constant.builtin.cpp', { link = 'Macro' })
vim.api.nvim_set_hl(0, '@keyword.conditional.cpp', { link = '@conditional' })
vim.api.nvim_set_hl(0, '@keyword.conditional.c', { link = '@conditional' })

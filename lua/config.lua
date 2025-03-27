local function open_currpdf()
	local file = vim.fn.expand("%:p:r") .. ".pdf"
	vim.fn.system("open " .. file)
	vim.notify("Opened file " .. file, vim.log.levels.INFO)
end

local function compile_typst()
	local file = vim.fn.expand('%:p:r')
	local filepdf = file .. ".pdf"
	local cmd = "typst c " .. file .. ".typ"
	local result = vim.fn.system(cmd)
	if vim.v.shell_error ~= 0 then
		vim.notify("Typst compilation failed:\n" .. result, vim.log.levels.ERROR)
	else
		vim.notify("Typst compiled successfully to: " .. filepdf, vim.log.levels.INFO)
		vim.fn.system("open " .. filepdf)
	end
end

local function compile_latex()
	local file = vim.fn.expand('%:p:r')
	local filepdf = file .. ".pdf"
	local cmd = "xelatex " .. file .. ".tex"
	local result = vim.fn.system(cmd)
	if vim.v.shell_error ~= 0 then
		vim.notify("XeLaTeX compilation failed:\n" .. result, vim.log.levels.ERROR)
	else
		vim.notify("XeLaTeX compiled successfully to: " .. filepdf, vim.log.levels.INFO)
		vim.fn.system("open " .. filepdf)
	end
end

vim.o.encoding = "utf-8"
vim.o.termguicolors = true
vim.o.number = true
-- vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.breakindent = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.updatetime = 241
vim.o.timeoutlen = 241
-- vim.o.signcolumn = 'no'
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
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.display = 'lastline'
vim.o.pumheight = 13
vim.o.smoothscroll = true
vim.o.mousescroll = 'ver:1,hor:1'

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'tf', builtin.find_files, {})
vim.keymap.set('n', 'tg', builtin.live_grep, {})
vim.keymap.set('n', 'tb', builtin.buffers, {})
vim.keymap.set('n', 'th', builtin.help_tags, {})
vim.keymap.set('n', 'z', '<cmd>bd<CR>')
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<CR>', {buffer = bufnr})

local kopts = { noremap = true, silent = true }
vim.keymap.set('n', 'q', '<cmd>q<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>n', '<Cmd>NvimTreeToggle<CR>', kopts)
vim.keymap.set('n', ';', '<Cmd>bp<CR>', kopts)
vim.keymap.set('n', "'", '<Cmd>bn<CR>', kopts)
vim.keymap.set('n', '<leader>o', open_currpdf, kopts)
vim.keymap.set('n', '<leader>w', compile_typst, kopts)
vim.keymap.set('n', '<leader>c', compile_latex, kopts)
vim.keymap.set('n', '<leader>p', '<Cmd>TypstPreviewToggle<CR>', kopts)
vim.keymap.set('n', '<leader>m', '<Cmd>RenderMarkdown toggle<CR>', kopts)
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
--vim.api.nvim_set_keymap({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
--vim.api.nvim_set_keymap({ "n", "v" }, "<leader>c", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.cmd([[cab cc CodeCompanionChat Toggle]])

require'gitsigns'.setup()
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "c", "cpp", "json", "json5", "markdown", "markdown_inline", "toml",
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
        if (ok and stats and stats.size > max_filesize) or lang == "csv" then
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
-- require('render-markdown').setup({
-- 	heading = {enabled = false},
-- })

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename', 'aerial'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress', 'filesize'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {'searchcount', 'selectioncount', 'diagnostics'},
    lualine_z = {'branch'}
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require("codecompanion").setup({
  adapters = {
    qwen = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "qwen", -- Give this adapter a different name to differentiate it from the default ollama adapter
        schema = {
          model = {
            default = "qwen2.5:7b-instruct",
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
  },
  strategies = {
    chat = {
      adapter = 'qwen',
    },
    inline = {
      adapter = 'qwen',
    },
  },
})

vim.cmd.colorscheme 'tokyonight'

vim.api.nvim_set_hl(0, 'dbknum', { fg = '#f9f9f9', bg = '#ec6645', bold = true })
vim.api.nvim_set_hl(0, 'dbkline', { bg = '#2e2431' })
vim.api.nvim_set_hl(0, 'dstnum', { fg = '#ffffff', bg = '#aebbe7', bold = true })
vim.api.nvim_set_hl(0, 'dstline', { bg = '#105021' })
vim.api.nvim_set_hl(0, 'Normal', { fg = '#ffffff', bg = 'None' })
vim.api.nvim_set_hl(0, 'Function', { fg = '#bdd0f1', bold = true })
vim.api.nvim_set_hl(0, 'Structure', { bold = true })
vim.api.nvim_set_hl(0, 'Class', { bold = true })
vim.api.nvim_set_hl(0, 'Title', { fg = '#bdd0f1', bold = true })
vim.api.nvim_set_hl(0, 'PMenuSel', { fg = '#eecdef', bold = true })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'None' })
vim.api.nvim_set_hl(0, 'Type', { fg = '#e2bdee' })
vim.api.nvim_set_hl(0, 'LspInlayHint', { bg = 'None' })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'None' })
vim.api.nvim_set_hl(0, 'Operator', { fg = '#80a1d9' })
vim.api.nvim_set_hl(0, 'Property', { fg = '#c7eca1' })
vim.api.nvim_set_hl(0, '@property', { fg = '#c7eca1' })
vim.api.nvim_set_hl(0, '@type.builtin', { fg = '#e2bdee' })
vim.api.nvim_set_hl(0, 'Statement', { fg = '#ffffff', bold = true })
vim.api.nvim_set_hl(0, '@conditional', { fg = '#ffffff', bold = true })
vim.api.nvim_set_hl(0, '@nospell', { fg = '#c7eca1' })
vim.api.nvim_set_hl(0, '@none', { fg = '#bdd0f1' })
vim.api.nvim_set_hl(0, 'Todo', { fg = '#ffffff', bg = '#f18342', bold = true })
vim.api.nvim_set_hl(0, '@lsp.typemod.text.math.typst', { bold = true })
vim.api.nvim_set_hl(0, '@lsp.typemod.pol.math.typst', { fg = '#eecdef', bold = true })
vim.api.nvim_set_hl(0, '@lsp.type.function.typst', { fg = '#c7eca1', bold = true })
vim.api.nvim_set_hl(0, '@lsp.type.link.typst', { fg = '#eea8e2' })
vim.api.nvim_set_hl(0, '@lsp.type.label.typst', { fg = '#bdd0f1' })
vim.api.nvim_set_hl(0, '@lsp.type.heading.typst', { fg = '#eff3ff', bold = true })
vim.api.nvim_set_hl(0, '@keyword', { fg = '#bdd0f1', bold = false, italic = false })
vim.api.nvim_set_hl(0, '@field', { fg = '#c7eca1' })
vim.api.nvim_set_hl(0, 'Special', { fg = '#bdd0f1' })
vim.api.nvim_set_hl(0, 'PreProc', { fg = '#90dc93' })
vim.api.nvim_set_hl(0, 'texMathDelimZoneTI', { fg = '#919191' })
vim.api.nvim_set_hl(0, 'texMathDelimZoneTD', { fg = '#919191' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#8e7faa' })
vim.api.nvim_set_hl(0, 'cursorlinenr', { fg = '#eecdef', bg = 'NONE', bold = true })
vim.api.nvim_set_hl(0, 'Visual', { fg = '#ffffff', bg = '#eea8e2', sp = '#eea8e2' })
vim.api.nvim_set_hl(0, 'Macro', { fg = '#ea735c' })
vim.api.nvim_set_hl(0, 'Comment', { italic = true, fg = '#939fc9' })
vim.api.nvim_set_hl(0, 'Structure', { bold = true })
vim.api.nvim_set_hl(0, 'Repeat', { bold = true })
vim.api.nvim_set_hl(0, 'Directory', { bold = true })
vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#fdfdfd', bg = '#eea8e2' })
vim.api.nvim_set_hl(0, 'mkdBlockquote', { fg = '#aaaaaa', italic = true })
vim.api.nvim_set_hl(0, '@punctuation.special', { fg = '#e2bdee' })
vim.api.nvim_set_hl(0, '@namespace.cpp', { fg = '#90dc93', bold = true })
vim.api.nvim_set_hl(0, '@string.csv', { fg = '#eecdef', bold = true })
vim.api.nvim_set_hl(0, '@constant.typst', { fg = '#eecdef', bold = true })
vim.api.nvim_set_hl(0, '@markup.math.typst', { fg = '#bdd0f1', bold = true })
vim.api.nvim_set_hl(0, '@markup.raw.typst', { fg = 'NONE' })
vim.api.nvim_set_hl(0, '@markup.raw.block.typst', { fg = 'NONE' })
vim.api.nvim_set_hl(0, '@variable', { fg = 'NONE' })
vim.api.nvim_set_hl(0, 'AerialLine', { fg = '#c7eca1', bold = true })
vim.api.nvim_set_hl(0, '@lsp.type.variable', {fg = '#c7eca1', italic = true, bold = true})
vim.api.nvim_set_hl(0, '@lsp.type.function.typst', { fg = '#eecdef', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', {fg = '#939fc9', italic = true})
vim.api.nvim_set_hl(0, '@nospell.latex', {fg = "NONE", bg = "NONE"})
-- vim.api.nvim_set_hl(0, '@spell.latex', { link = "String" })

vim.api.nvim_set_hl(0, '@property.json', {fg = '#dfa341', bold = true})
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
vim.api.nvim_set_hl(0, '@none.html', { link = 'Normal' })
vim.api.nvim_set_hl(0, '@tag.html', { link = '@none' })

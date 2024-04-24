vim.cmd([[
  syntax off
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
  let g:loaded_netrw = 1
  let g:loaded_netrwPlugin = 1
  set diffopt=vertical
  au FileType csv setlocal nowrap
  set mouse=a
  set mousescroll=ver:1,hor:1
  let g:python3_host_prog = '/opt/homebrew/bin/python3'

  nnoremap <leader>n :NvimTreeToggle<CR>
  nnoremap <silent>    ; <Cmd>BufferPrevious<CR>
  nnoremap <silent>    ' <Cmd>BufferNext<CR>
  nnoremap <silent>    qf :lua vim.lsp.buf.code_action()<CR>
  nnoremap <leader>w <Cmd>TypstWatch<CR>
  nnoremap <leader>p :TypstPreview<CR>
  nnoremap <leader>s :TypstPreviewStop<CR>
  nnoremap <leader>t :TagbarToggle<CR>
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

]])

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
--    {
--        "iamcco/markdown-preview.nvim",
--        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--        ft = { "markdown" },
--        build = function() vim.fn["mkdp#util#install"]() end,
--    },
    {'folke/tokyonight.nvim', lazy=false, priority=1000,
    config = function() vim.cmd([[colorscheme tokyonight-moon]]) end,},
    --'sainnhe/everforest'
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            local lualine_require = require("lualine_require")
            lualine_require.require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto',
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
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename', 'aerial'},
                    lualine_x = {'encoding', 'filetype', 'selectioncount'},
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
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            })
        end
    },
    'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',
    'romgrk/barbar.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-nvim-lua',
--    'kdheepak/cmp-latex-symbols',
    {'kaarmu/typst.vim', ft='typst'},
    {
        'chomosuke/typst-preview.nvim',
        ft = 'typst',
        build = function() require 'typst-preview'.update() end,
    },
--    {'williamboman/mason.nvim', config=function() require("mason").setup() end},
--    {'williamboman/mason-lspconfig.nvim',
--      config = function()require("mason-lspconfig").setup() end},
    'mfussenegger/nvim-dap',
    'neovim/nvim-lspconfig',
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    {
        'stevearc/aerial.nvim',
        on_attach = function(bufnr)
            -- Jump forwards/backwards with '{' and '}'
            vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
            vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
        opts = {
            backends = {'treesitter'},
            autojump = true
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    }
})

require('config')
require('lsp')
require('dapconfig')

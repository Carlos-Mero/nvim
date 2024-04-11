local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

lspconfig.sourcekit.setup {
  cmd = {'/usr/bin/sourcekit-lsp'},
  filetypes = { 'swift' },
  root_dir = lspconfig.util.root_pattern('Package.swift', 'buildServer.json', 'compile_commands.json', '.git', '.vimrc'),
  capabilities = capabilities
}
lspconfig.clangd.setup {
  capabilities = capabilities,
}
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
}
lspconfig.jedi_language_server.setup {
  capabilities = capabilities,
}
lspconfig.ruff_lsp.setup {
  capabilities = capabilities,
}
--lspconfig.lua_ls.setup {
--  capabilities = capabilities,
--  settings = {
--    Lua = {
--      runtime = {
--        version = 'LuaJIT',
--      },
--      diagnostics = {
--        globals = {'vim'},
--      },
--      workspace = {
--        library = vim.api.nvim_get_runtime_file("", true),
--        checkThirdParty = false,
--      },
--      telemetry = {
--        enable = false,
--      },
--    },
--  },
--}

--local start_typst_lsp = function ()
--  vim.lsp.start({
--    name = 'typst-lsp',
--    cmd = {'typst-lsp'},
--    --root_dir = vim.fs.dirname(vim.fs.find({'*.typ'}, { upward = true })[1]),
--    settings = {exportPdf = "never"},
--  })
--end
--vim.api.nvim_create_autocmd("FileType", {
--  desc = 'Auto start typst-lsp for neovim.',
--  pattern = 'typst',
--  callback = start_typst_lsp
--})

local luasnip = require 'luasnip'
local cmp = require 'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' }
  },
}

cmp.setup.filetype('lua', {
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'path' }
  })
})

cmp.setup.filetype({'latex', 'markdown'}, {
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    -- { name = 'vimtex', }
    { name = 'latex_symbols' },
    option = {
      strategy = 0,
    }
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

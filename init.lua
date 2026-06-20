vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.have_nerd_font = true

vim.lsp.log.set_level 'off'

local gh = function(repo)
  return "https://github.com/" .. repo
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "markdown-preview.nvim"
        and (ev.data.kind == "install" or ev.data.kind == "update") then
      vim.system({ "sh", "-c", "cd " .. ev.data.path .. "/app && yarn install" }):wait()
    end
  end,
})

vim.pack.add({
  { src = gh("iamcco/markdown-preview.nvim"), opt = true },
  -- { src = gh("catppuccin/nvim") },
  -- { src = gh("neanias/everforest-nvim"), name = "everforest" },
  { src = gh("rebelot/kanagawa.nvim") },
  { src = gh("nvim-lualine/lualine.nvim") },
  { src = gh("nvim-tree/nvim-tree.lua") },
  { src = gh("nvim-tree/nvim-web-devicons") },
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("nvim-telescope/telescope.nvim") },
  { src = gh("habamax/vim-godot"), opt = true },
  { src = gh("mfussenegger/nvim-dap") },
  { src = gh("neovim/nvim-lspconfig") },
  { src = gh("lewis6991/gitsigns.nvim") },
  { src = gh("stevearc/aerial.nvim") },
  { src = gh("Julian/lean.nvim"), opt = true },
  { src = gh("mikavilpas/yazi.nvim") },
})

require("lualine").setup()
require("nvim-tree").setup()
require("gitsigns").setup()
require("aerial").setup({
  on_attach = function(bufnr)
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})

require("yazi").setup({
  open_for_directories = false,
})
vim.keymap.set("n", "ya", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })
vim.keymap.set("n", "ycw", "<cmd>Yazi cwd<cr>", { desc = "Open yazi in nvim cwd" })
vim.keymap.set("n", "<c-up>", "<cmd>Yazi toggle<cr>", { desc = "Resume yazi session" })

vim.g.mkdp_filetypes = { "markdown" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.cmd.packadd("markdown-preview.nvim")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gdscript", "gsl" },
  callback = function()
    vim.cmd.packadd("vim-godot")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"lean"},
  callback = function()
    vim.cmd.packadd("lean.nvim")
    require("lean").setup({
      lsp = {
        on_attach = on_attach,
      },
      mappings = true,
    })
  end
})

require('lsp')
require('dapconfig')
require('config')

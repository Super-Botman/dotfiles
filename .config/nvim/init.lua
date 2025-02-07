-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require("configs")

vim.cmd [[colorscheme tokyonight]]
vim.g.coq_settings = { auto_start = "shut-up" }
vim.g.mapleader = " "
vim.opt.mouse = ""
vim.wo.relativenumber = true
vim.wo.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.bo.softtabstop = 2
vim.keymap.set("n", "<tab>", ":tabNext<CR>", {})
vim.keymap.set("n", "<Leader><Leader>n", ":noh<CR>", {})
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", {})
vim.filetype.on = true
vim.filetype.add({
  extension = {
    c3 = "c3",
    c3i = "c3",
    c3t = "c3",
  },
})

vim.keymap.set("n", "<Leader>ff", ":FzfLua files<CR>", {})
vim.keymap.set("n", "<Leader>fg", ":FzfLua grep<CR>", {})
vim.keymap.set("n", "<Leader>fm", ":FzfLua manpages<CR>", {})
vim.keymap.set("n", "<Leader>f", ":NvimTreeToggle<CR>", {})

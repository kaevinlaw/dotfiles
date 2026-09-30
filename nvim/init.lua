-------------------------------------------------
-- Options
-------------------------------------------------
vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.cmd("syntax on")

vim.opt.errorbells = false
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = false          -- matches your set noexpandtab
vim.opt.list = true
vim.opt.listchars = { trail = "." }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.exrc = true
vim.opt.scrollback = 100000
vim.opt.path:append("**")
vim.opt.splitbelow = true
vim.opt.splitright = true

-------------------------------------------------
-- Leader
-------------------------------------------------
vim.g.mapleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-------------------------------------------------
-- Keymaps
-------------------------------------------------
local map = vim.keymap.set

-- escape
map("i", "jk", "<Esc>")
map("v", "jk", "<Esc>")

-- toggle last two files
map("n", "<Leader><Leader>", "<C-^>")

-- window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Y = yank to end of line
map("n", "Y", "y$")

-- keep cursor centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- undo breakpoints
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", "!", "!<C-g>u")
map("i", "?", "?<C-g>u")

-- move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- add to jump list on large moves
map("n", "k", function()
  return (vim.v.count > 4 and ("m'" .. vim.v.count) or "") .. "k"
end, { expr = true })

map("n", "j", function()
  return (vim.v.count > 4 and ("m'" .. vim.v.count) or "") .. "j"
end, { expr = true })

-------------------------------------------------
-- Commands
-------------------------------------------------
vim.api.nvim_create_user_command("Reload", function()
  vim.cmd("source " .. vim.env.MYVIMRC)
end, {})

vim.api.nvim_create_user_command("Config", function()
  vim.cmd("Ex ~/.config/nvim/")
end, {})

-------------------------------------------------
-- Bootstrap lazy.nvim
-------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

-------------------------------------------------
-- Early plugin globals (before lazy)
-------------------------------------------------
local plugin_dir = vim.fn.stdpath("config") .. "/plugin_config"
for _, name in ipairs({
  "vimwiki.vim",
  "fzf_rg.vim",
  "vista.vim",
  "tmuxline.vim",
  "undotree.vim",
}) do
  local path = plugin_dir .. "/" .. name
  if vim.fn.filereadable(path) == 1 then
    vim.cmd("source " .. path)
  end
end

-------------------------------------------------
-- Plugins
-------------------------------------------------
require("lazy").setup({
  -- Themes
  "NLKNguyen/papercolor-theme",
  "morhetz/gruvbox",
  "romgrk/doom-one.vim",
  { "dracula/vim", name = "dracula" },
  "tyrannicaltoucan/vim-deep-space",

  -- Fuzzy finder (keep for now; replace in step 4)
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  "junegunn/fzf.vim",

  -- UI
  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",
  "edkolev/tmuxline.vim",
  "liuchengxu/vista.vim",

  -- Tools
  "vimwiki/vimwiki",
  "aklt/plantuml-syntax",
  "rhysd/git-messenger.vim",
  {
    "catgoose/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  "will133/vim-dirdiff",
  "mbbill/undotree",
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        -- 1. Initialize Treesitter (No more .configs module)
        require('nvim-treesitter').setup()

        -- 2. Direct parser installation method for the new branch
        require('nvim-treesitter').install({ "vim", "vimdoc", "lua", "markdown" })

        -- 3. Highlighting is largely native now, but this hooks up extra features
        vim.api.nvim_create_autocmd("FileType", {
          callback = function()
            pcall(vim.treesitter.start)
          end,
        })
      end,
    },
  -- Optional / commented in your old config
  -- { "neoclide/coc.nvim", branch = "release" },
  -- "Yggdroot/indentLine",
  -- "github/copilot.vim",
})

-------------------------------------------------
-- Colorscheme + highlights
-------------------------------------------------
vim.cmd("colorscheme deep-space")
vim.opt.background = "dark"

vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NonText ctermbg=NONE
  highlight clear LineNr
  highlight clear SignColumn
]])

-------------------------------------------------
-- Small plugin settings
-------------------------------------------------
pcall(function()
  require("colorizer").setup()
end)

vim.g.indentLine_char = "|"
vim.g.markdown_syntax_conceal = 0

-------------------------------------------------
-- Binary editing (xxd)
-------------------------------------------------
local binary_group = vim.api.nvim_create_augroup("Binary", { clear = true })

vim.api.nvim_create_autocmd("BufReadPre", {
  group = binary_group,
  pattern = "*.bin",
  callback = function()
    vim.opt_local.binary = true
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = binary_group,
  pattern = "*.bin",
  callback = function()
    if vim.opt_local.binary:get() then
      vim.cmd("%!xxd")
      vim.opt_local.filetype = "xxd"
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = binary_group,
  pattern = "*.bin",
  callback = function()
    if vim.opt_local.binary:get() then
      vim.cmd("%!xxd -r")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = binary_group,
  pattern = "*.bin",
  callback = function()
    if vim.opt_local.binary:get() then
      vim.cmd("%!xxd")
      vim.opt_local.modified = false
    end
  end,
})

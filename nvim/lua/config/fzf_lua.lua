local fzf = require("fzf-lua")

fzf.setup({
  winopts = {
    width = 0.95,
    height = 0.90,
    preview = {
      default = "bat",
      border = "border",
    },
  },
  files = {
    rg_opts = "--files --hidden --follow --no-ignore-vcs -g '!{.cache,.ccache,.clangd,.conan,.git}/*'",
    fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude .cache --exclude .ccache --exclude .clangd --exclude .conan",
  },
  grep = {
    rg_opts = "--vimgrep --smart-case --follow --hidden -g '!{.git,.cache,.ccache,.clangd,.conan}/*'",
  },
})

local map = vim.keymap.set
map("n", "<Leader>p", fzf.files, { desc = "Find files" })
map("n", "<Leader>rg", fzf.live_grep, { desc = "Live grep" })
map("n", "<Leader>b", fzf.buffers, { desc = "Buffers" })
map("n", "<Leader>h", fzf.help_tags, { desc = "Help tags" })
map("n", "<Leader>o", fzf.oldfiles, { desc = "Recent files" })
map("n", "<Leader>P", fzf.resume, { desc = "FzfLua resume" })

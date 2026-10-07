local M = {}

-- Servers installed by mason (lspconfig names). mason-lspconfig enables them
-- automatically once installed.
-- Not listed here because they come from apt (see ansible utilities.yml):
--   clangd                 -> enabled below
--   shellcheck, ansible-lint -> used by bashls / ansiblels when on PATH
M.mason_servers = {
  "lua_ls",
  "pyright",
  "ruff",
  "bashls",
  "ansiblels",
  "yamlls",
  "dockerls",
  "marksman",
}

function M.setup()
  -- ansiblels only attaches to yaml.ansible, which nvim doesn't detect itself
  vim.filetype.add({
    pattern = {
      [".*/ansible/.*%.ya?ml"] = "yaml.ansible",
      [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
      [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
    },
  })

  vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = { border = "rounded" },
  })

  -- advertise blink.cmp's completion capabilities to every server
  vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  })

  -- clangd from apt (mason has no linux-arm64 build)
  vim.lsp.config("clangd", {
    cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
  })
  vim.lsp.enable("clangd")

  -- Keymaps (buffer-local, only where a server is attached).
  -- Built-in since nvim 0.11: K hover, grn rename, gra code action,
  -- gri implementation, gO document symbols, <C-s> signature help (insert).
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(ev)
      local fzf = require("fzf-lua")
      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
      end

      -- ported from coc
      map("gd", vim.lsp.buf.definition, "Go to definition")
      map("gy", vim.lsp.buf.type_definition, "Go to type definition")
      map("gi", vim.lsp.buf.implementation, "Go to implementation")
      map("grr", fzf.lsp_references, "References") -- coc's gr; plain gr would delay grn/gra/gri
      map("<Leader>s", fzf.lsp_live_workspace_symbols, "Workspace symbols")
      map("<Leader>j", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
      map("<Leader>k", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
    end,
  })
end

return M

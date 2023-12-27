-- conform.lua
--
-- Formatting and linting

return {
  'stevearc/conform.nvim',
  event = "BufWritePre", -- load the plugin before saving
  keys = {
    {
      "<leader>f",
      function() require("conform").format({ lsp_fallback = true }) end,
      desc = "Format",
    },
  },
  opts = {
    formatters_by_ft = {
      python = { 'ruff_fix', 'ruff_format' },
      markdown = { 'inject' },
    },
    -- format_on_save = {
    --   timeout_ms = 500,
    --   lsp_fallback = true,
    -- },
  }
}

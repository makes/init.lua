-- conform.lua
--
-- Formatting and linting

return {
  'stevearc/conform.nvim',

  config = function()
    require("conform").setup({
      formatters_by_ft = {
        python = { 'ruff_fixx', 'ruff_format' },
        markdown = { 'injected' },
      },
      linters_by_ft = {
        python = { 'mypy', 'ruff_check' },
      }
      -- format_on_save = {
      --   timeout_ms = 500,
      --   lsp_fallback = true,
      -- },
    })

    vim.keymap.set(
      'n',
      '<leader>f',
      function()
        require("conform").format({
          lsp_fallback = true,
        })
      end,
      { desc = 'Auto-format (conform.nvim)' }
    )
  end
}

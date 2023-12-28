-- conform.lua
--
-- Formatting and linting

return {
  'stevearc/conform.nvim',

  config = function()
    require("conform").setup({
      formatters_by_ft = {
        python = { 'ruff_fix', 'ruff_format' },
        markdown = { 'injected' },
      },
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
      { desc = 'Auto-format.' }
    )
  end
}

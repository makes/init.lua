return {
  'nvim-neotest/neotest',
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false }, -- Enable debugging with DAP
          runner = "pytest", -- Use pytest as the test runner
          python = "python", -- Specify the Python interpreter
        }),
      },
    })
    vim.keymap.set('n', '<leader>tn', function() require("neotest").run.run({ strategy = "dap" }) end, { desc = "[T]est [N]earest (debug)" })
    vim.keymap.set('n', '<leader>tf', function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "[T]est [F]ile" })
    vim.keymap.set('n', '<leader>ts', require("neotest").summary.toggle, { desc = "[T]est [S]ummary" })
  end,
}


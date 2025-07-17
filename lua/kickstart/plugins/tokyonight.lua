return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require('tokyonight').setup {
        style = "night", -- `storm`, `moon`, `night` or `day`
        transparent = true, -- disable background color
        styles = {
          -- syntax groups `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et

-- smart-splits.lua
--
-- Pane navigation with terminal multiplexer integration

return {
  'mrjones2014/smart-splits.nvim',

  config = function()
    require('smart-splits').setup {
      at_edge = function(ctx)
        local mux = ctx.mux

        -- only care when wezterm integration is active
        if not mux or mux.type ~= 'wezterm' or not mux.is_in_session() then
          return
        end

        -- Are we also at the edge of the wezterm pane layout?
        -- (i.e. no wezterm pane in that direction)
        local at_mux_edge = mux.current_pane_at_edge and mux.current_pane_at_edge(ctx.direction)

        if not at_mux_edge then
          -- Not at wezterm edge: let smart-splits do its normal mux navigation
          return
        end

        -- At both Neovim edge and Wezterm edge:
        -- for left/right, switch wezterm tab instead.
        if ctx.direction == 'left' or ctx.direction == 'right' then
          local rel = ctx.direction == 'left' and -1 or 1

          vim.system({
            'wezterm',
            'cli',
            'activate-tab',
            '--tab-relative',
            tostring(rel),
          }, { detach = true })
        end

        -- For up/down (or anything else), you can optionally fall back
        -- to the default behaviors:
        -- ctx.split() -- make a new Neovim split
        -- ctx.wrap()  -- wrap around Neovim windows
      end,
    }

    vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { desc = 'Move focus to the left window' })
    vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { desc = 'Move focus to the right window' })
    vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { desc = 'Move focus to the lower window' })
    vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { desc = 'Move focus to the upper window' })

    vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left, { desc = 'Resize window left' })
    vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right, { desc = 'Resize window right' })
    vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down, { desc = 'Resize window down' })
    vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up, { desc = 'Resize window up' })

    vim.keymap.set('n', '<leader>wh', require('smart-splits').swap_buf_left, { desc = 'Swap buffer with left window' })
    vim.keymap.set('n', '<leader>wl', require('smart-splits').swap_buf_right, { desc = 'Swap buffer with right window' })
    vim.keymap.set('n', '<leader>wj', require('smart-splits').swap_buf_down, { desc = 'Swap buffer with lower window' })
    vim.keymap.set('n', '<leader>wk', require('smart-splits').swap_buf_up, { desc = 'Swap buffer with upper window' })
  end,
}

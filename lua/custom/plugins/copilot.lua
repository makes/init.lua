return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    suggestion = {
      enabled = not vim.g.ai_cmp,
      auto_trigger = true,
      keymap = {
        accept = "<Tab>", -- false when handled by nvim-cmp / blink.cmp
        next = "<M-ä>",
        prev = "<M-ö>",
      },
    },
    panel = { enabled = true, auto_refresh = false },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
}

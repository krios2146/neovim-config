-- Plugins with no additional configuration goes here
return {
  require 'themes',
  { 'tpope/vim-sleuth' }, -- Detect `tabstop` and `shiftwidth` automatically
  { 'numToStr/Comment.nvim', opts = {} }, -- Linewise/blockwise comments
  { 'windwp/nvim-ts-autotag', opts = {} }, -- Same as `autopairs` but for HTML tags
  { 'wakatime/vim-wakatime' }, -- Wakatime - time tracker
  { 'tpope/vim-fugitive' }, -- Git integration

  -- Highlight todo, notes, etc. in the comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  -- Collection of various small independent plugins/modules
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 } -- Better 'around' & 'inner' experience
      require('mini.surround').setup() -- Adds mappings for surround text with ", (, etc.
    end,
  },

  -- Fancy notifications
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require 'notify'
    end,
  },

  -- Different UI for the `vim.ui.input`
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
}

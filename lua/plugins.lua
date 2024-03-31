-- Plugins with no additional configuration goes here
return {
  { 'tpope/vim-sleuth' }, -- Detect `tabstop` and `shiftwidth` automatically
  { 'numToStr/Comment.nvim', opts = {} }, -- Linewise/blockwise comments
  { 'windwp/nvim-ts-autotag', opts = {} }, -- Same as `autopairs` but for HTML tags
  { 'wakatime/vim-wakatime' }, -- Wakatime - time tracker
  { 'tpope/vim-fugitive' }, -- Git integration

  -- Theme installation
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

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
}

-- File tree
return {
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        actions = {
          open_file = { quit_on_open = true },
        },
      }
      vim.keymap.set('n', '<leader>pv', vim.cmd.NvimTreeOpen, { desc = '[P]roject [V]iew' })
    end,
  },
}

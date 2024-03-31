-- Diagnostics popup
return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    config = function()
      vim.keymap.set('n', '<leader>wd', function()
        require('trouble').toggle 'workspace_diagnostics'
      end, { desc = '[W]orkspace [D]iagnostics' })

      vim.keymap.set('n', '<leader>dd', function()
        require('trouble').toggle 'document_diagnostics'
      end, { desc = '[D]ocument [Diagnostics]' })
    end,
  },
}

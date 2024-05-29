-- Useful plugin to show pending keybindings
return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()
      require('which-key').register {
        ['<leader>'] = {
          c = { '[C]ode' },
          d = { '[D]iagnostics & [D]ocument' },
          r = { '[R]ename' },
          s = { '[S]earch' },
          w = { '[W]orkspace' },
          g = { '[G]it' },
          h = { 'Git [H]unk' },
        },
      }
    end,
  },
}

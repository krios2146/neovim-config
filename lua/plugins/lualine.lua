-- Lualine
return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      sections = {
        lualine_x = {
          { 'datetime', style = '%H:%M:%S' },
          'filetype',
        },
      },
      extensions = { 'fugitive', 'trouble', 'lazy', 'mason', 'nvim-tree' },
    },
  },
}

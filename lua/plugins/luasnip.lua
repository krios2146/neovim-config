return {
  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
    },
    -- mappings are in the nvim-cmp plugin config
    config = function()
      require('luasnip').setup {
        update_events = { 'TextChanged', 'TextChangedI' }, -- live update of dynamic snippet nodes
        ext_opts = {
          [require('luasnip.util.types').choiceNode] = {
            active = {
              virt_text = { { '●', 'DiagnosticHint' } }, -- Add virt_text if on the choiceNode
            },
          },
        },
      }
      -- sourcing snippets directory
      require('luasnip.loaders.from_lua').load { paths = { '~/.config/nvim/lua/snippets' } }
    end,
  },
}

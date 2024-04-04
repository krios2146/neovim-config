-- Moved to function to clean space in actual `setup` function
local function get_dependecies()
  return {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' }, -- It sets `vim.ui.select` to telescope. Used in `code_action` for example
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  }
end

-- Customizable, under cursor dropdown layout for pickers
local function get_dropdown_layout(height, width, transparency)
  return {
    layout_strategy = 'cursor',
    layout_config = {
      height = height or 0.5,
      width = width or 0.5,
    },
    initial_mode = 'normal',
    winblend = transparency or 30,
    sorting_strategy = 'ascending',
  }
end

-- Helper functions for mapping keys
local function map_search(key, func, desc)
  vim.keymap.set('n', '<leader>s' .. key, func, { desc = '[S]earch ' .. desc })
end

local function map_git(key, func, desc)
  vim.keymap.set('n', '<leader>g' .. key, func, { desc = '[G]it ' .. desc })
end

-- For some reason documented variant of integration of Trouble and Telescope isn't working
-- Error Trouble v.2 = paths to the files duplicates
-- Trouble v.3 just don't work, no errors, no files shown
local function open_with_trouble(opts)
  require('telescope.actions').send_to_qflist(opts)
  vim.cmd 'Trouble quickfix' -- Should be with `cmd`. Navigation won't work if opened differently
end

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = get_dependecies(),
    config = function()
      require('telescope').setup {
        defaults = {
          layout_config = {
            horizontal = {
              preview_width = 0.5, -- Make default preview bigger
            },
          },
          mappings = { -- Change default qflist to the Trouble
            i = { ['<M-q>'] = open_with_trouble },
            n = { ['<M-q>'] = open_with_trouble },
          },
        },
        pickers = {
          spell_suggest = get_dropdown_layout(0.35, 0.4),
        },
        extensions = { -- Mainly used for code_action
          ['ui-select'] = get_dropdown_layout(0.4, 0.7),
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'

      -- Modifications for some builtin Telescope functions
      local builtin_grep_open_files = function()
        builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
      end

      local builtin_config_files = function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end

      -- Mappings
      map_search('h', builtin.help_tags, '[H]elp')
      map_search('k', builtin.keymaps, '[K]eymaps')
      map_search('f', builtin.find_files, '[F]iles')
      map_search('s', builtin.spell_suggest, '[S]pell suggestions')
      map_search('w', builtin.grep_string, '[W]ord')
      map_search('g', builtin.live_grep, '[G]rep')
      map_search('d', builtin.diagnostics, '[D]iagnostics')
      map_search('r', builtin.resume, '[R]esume')
      map_search('o', builtin.oldfiles, '[O]ld Files')
      map_search('/', builtin_grep_open_files, '[/] in Open Files')
      map_search('n', builtin_config_files, '[N]eovim config')
      map_search('<BS>', builtin.buffers, 'Existing buffers')
      map_search('F', builtin.current_buffer_fuzzy_find, '[F]uzzy [F]ind Current buffer')

      map_git('c', builtin.git_commits, '[C]ommits')
      map_git('b', builtin.git_branches, '[B]ranches')
      map_git('s', builtin.git_status, '[S]status')
    end,
  },
}

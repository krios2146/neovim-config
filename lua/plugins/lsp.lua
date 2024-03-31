-- Servers to install
local function get_servers()
  return {
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    },
    volar = {
      filetype = { 'typescript', 'javascript', 'vue' },
      init_options = {
        vue = { hybridMode = false },
      },
    },
    tsserver = {},
    tailwindcss = {},
    ltex = {},
  }
end

-- Additional tools to install
local function get_tools()
  return {
    'stylua',
    'prettier',
    'eslint_d',
  }
end

-- Mappings
local function map_keys(event)
  local function map_lsp(keys, func, desc) -- Helper function for mapping LSP related keys
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  end

  local telescope = require 'telescope.builtin'

  map_lsp('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
  map_lsp('gr', telescope.lsp_references, '[G]oto [R]eferences')
  map_lsp('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')
  map_lsp('<leader>td', telescope.lsp_type_definitions, '[T]ype [D]efinition')
  map_lsp('<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
  map_lsp('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  map_lsp('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map_lsp('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  map_lsp('K', vim.lsp.buf.hover, 'Hover Documentation')
  map_lsp('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
end

-- Installing servers with Mason
local function install_servers_with_mason_lsp_config()
  local servers = get_servers()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

  require('mason-lspconfig').setup {
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        require('lspconfig')[server_name].setup(server)
      end,
    },
  }
end

-- Installing tools with Mason
local function install_tools_with_mason()
  local servers = get_servers()

  local ensure_installed = vim.tbl_keys(servers or {})

  vim.list_extend(ensure_installed, get_tools())

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }
end

-- LSPs setup
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} }, -- Useful status updates for LSPs
      { 'folke/neodev.nvim', opts = {} }, -- Extension for lua LSP that adds neovim completion
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          map_keys(event)

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Setting up cursor idle popups
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      require('mason').setup()

      install_tools_with_mason()
      install_servers_with_mason_lsp_config()

      -- Updating LSPs diagnostics signs
      vim.cmd [[
        sign define DiagnosticSignError text= linehl= texthl=DiagnosticSignError numhl= 
        sign define DiagnosticSignWarn text= linehl= texthl=DiagnosticSignWarn numhl= 
        sign define DiagnosticSignInfo text=  linehl= texthl=DiagnosticSignInfo numhl= 
        sign define DiagnosticSignHint text= linehl= texthl=DiagnosticSignHint numhl= 
      ]]

      -- Show most severe diagnostic first if there are more then one of them
      vim.diagnostic.config {
        severity_sort = true,
      }

      -- NOTE: Gleam should be installed without Mason
      require('lspconfig').gleam.setup {}
    end,
  },
}

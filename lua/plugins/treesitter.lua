return { {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.install").prefer_git = true
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "lua", "python", "gleam" },
            sync_installed = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = { enable = true },
            textobjects = { enable = true },
        })
    end,
} }

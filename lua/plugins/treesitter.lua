return {{
	"nvim-treesitter/nvim-treesitter", 
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.install").prefer_git = true
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "lua", "python", "rust" },
			sync_installed = false,
			highlight = { enabled = true },
			indent = { enabled = true }
		})
	end
}}

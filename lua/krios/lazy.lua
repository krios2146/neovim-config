local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
	'nvim-lua/plenary.nvim',
	{
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
	},
	"rebelot/kanagawa.nvim"
})
vim.cmd("colorscheme kanagawa")


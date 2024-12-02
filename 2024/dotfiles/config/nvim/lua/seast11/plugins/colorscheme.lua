return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		name = "tokyonight",
		config = function()
			vim.cmd("colorscheme tokyonight") -- default to this bad hombre
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		priority = 1000,
		name = "cyberdream",
	},
	{
		"Mofiqul/vscode.nvim",
		priority = 1000,
		name = "vscode",
	},
	{
		"morhetz/gruvbox",
		priority = 1000,
		name = "gruvbox",
	},
	{
		"catppuccin/nvim",
		priority = 1000,
		name = "catppuccin",
	},
	{
		"craftzdog/solarized-osaka.nvim",
		priority = 1000,
		name = "solarized-osaka",
	},
}

return {
  'nvim-treesitter/nvim-treesitter',
  config = function ()
  require'nvim-treesitter.configs'.setup {
  	ensure_installed = { "lua", texlab },
  	sync_install = true,
  	auto_install = true,
  	highlight = {
  		enable = true
  	}
  }
  end
}

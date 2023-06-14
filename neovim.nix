{config,pkgs,...}: {

programs.neovim = {
		enable = true;
		defaultEditor = true;
		vimAlias = true;
};

home.file = {
	"nvim" = {
		enable = true;
		target = ".config/nvim";
		source = config.lib.file.mkOutOfStoreSymlink ./neovim;
		recursive = true;
	};

	};
}

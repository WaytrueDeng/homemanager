{config,pkgs,...}: {

home.file = {
	"wofi" = {
		enable = true;
		target = ".config/wofi";
		source = config.lib.file.mkOutOfStoreSymlink ./hyprland/wofi;
		recursive = true;
	};

	};
}

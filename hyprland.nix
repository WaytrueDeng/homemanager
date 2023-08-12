{config,pkgs,...}: {

home.file = {
	"hyprland" = {
		enable = true;
		target = ".config/hypr";
		source = config.lib.file.mkOutOfStoreSymlink ./hyprland/hypr;
		recursive = true;
	};

	};
}

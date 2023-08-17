
{config,pkgs,...}: {

home.file = {
	"waybar" = {
		enable = true;
		target = ".config/waybar";
		source = config.lib.file.mkOutOfStoreSymlink ./hyprland/waybar;
		recursive = true;
	};

	};
}

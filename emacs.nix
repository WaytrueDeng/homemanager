
{ config, pkgs, ... }:
{
	programs.emacs.enable = true;
	home.file = {
		"file.dotEmacs" = {
			enable = true;
			target = ".emacs.d";
			source = config.lib.file.mkOutOfStoreSymlink ./emacs;
			# source =  ./emacs;
			recursive = true;
		};


	};
}

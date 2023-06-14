
{ config, pkgs, ... }:
{
	programs.emacs.enable = true;
	home.file = {
		dotEmacs = {
			enable = true;
			target = ".emacs.d";
			source = config.lib.file.mkOutOfStoreSymlink ./emacs;
			recursive = true;
		};


	};
}

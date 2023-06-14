
{ config, pkgs, ... }:
{
  programs.kitty.enable = true;
  programs.kitty.extraConfig = ''
  font_family FiraCode Nerd Font Mono
  italic_font      auto
  bold_font        auto
  bold_italic_font auto
  font_size 20.0
  disable_ligatures never

  background #1e1f28
  foreground #f8f8f2
  cursor #bbbbbb
  selection_background #44475a
  color0 #000000
  color8 #545454
  color1 #ff5555
  color9 #ff5454
  color2 #50fa7b
  color10 #50fa7b
  color3 #f0fa8b
  color11 #f0fa8b
  color4 #bd92f8
  color12 #bd92f8
  color5 #ff78c5
  color13 #ff78c5
  color6 #8ae9fc
  color14 #8ae9fc
  color7 #bbbbbb
  color15 #ffffff
  selection_foreground #1e1f28
  macos_option_as_alt both
  '';
}

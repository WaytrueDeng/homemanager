# ZSH
```nix tangle:zsh.nix
{config, pkgs, ...}:
  {
programs.zsh= {
  enable = true;
  enableAutosuggestions = true;
  enableSyntaxHighlighting = true;
  initExtra = ''
  eval "$(zoxide init zsh)" 
  eval "$(starship init zsh)"

  ZSH_TMUX=$(tmux ls | grep "zsh")
  #ZSH_TMUX=`ps aux | grep "tmux new-session -s zsh" | grep -v grep`
  if [[ -n $ZSH_TMUX ]]; then
    tmux a -t zsh 
  else
    tmux new-session -s zsh && tmux a -t zsh
  fi
    
  
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  export QT_QPA_PLATFORMTHEME=qt5ct
  export PATH=/home/waytrue/.cargo/bin/:/home/waytrue/.local/bin:$PATH
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
  export PATH="${PATH+:$PATH}:/opt/homebrew/bin:/opt/homebrew/sbin";
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

  # Preferred editor for local and remote sessions
  # if [[ -n $SSH_CONNECTION ]]; then
  #   export EDITOR='vim'
  # else
  export EDITOR='nvim'
  # fi
  
  # Compilation flags
  # export ARCHFLAGS="-arch x86_64"
  
  # Set personal aliases, overriding those provided by oh-my-zsh libs,
  # plugins, and themes. Aliases can be placed here, though oh-my-zsh
  # users are encouraged to define aliases within the ZSH_CUSTOM folder.
  # For a full list of active aliases, run `alias`.
  #
  # Example aliases
  # alias zshconfig="mate ~/.zshrc"
  # alias ohmyzsh="mate ~/.oh-my-zsh"
  alias v="nvim"
  alias cd="z"

  ## Colorize the ls output ##
  alias ls='ls --color=auto'

  ## Use a long listing format ##
  alias ll='ls -la'
  alias ll='ls -la'
  alias ip="ip -c"
  '';
  };

  programs.starship = {
      enable = true;
      enableZshIntegration = true;

  };


  programs.zoxide = {
      enable = true;
      enableZshIntegration = true;

  };
  }
```
# tmux
```nix tangle:tmux.nix
{config,pkgs,...}:{
  programs.tmux = {
      enable = true;
      clock24 = true;
	plugins = with pkgs.tmuxPlugins; [
		sensible
		yank
		{
			plugin = dracula;
			extraConfig = ''
				set -g @dracula-show-battery false
				set -g @dracula-show-powerline true
				set -g @dracula-refresh-rate 1
			'';
		}
	];

	extraConfig = ''
		set -g mouse on
set -g default-terminal "screen-256color"

setw -g xterm-keys on
set -s escape-time 0                     # faster command sequences
set -sg repeat-time 0                   # increase repeat timeout
set -s focus-events on

set -g prefix C-a                        # GNU-Screen compatible prefix
bind C-a send-prefix 

set -q -g status-utf8 on                  # expect UTF-8 (tmux < 2.2)
setw -q -g utf8 on

set -g history-limit 5000                 # boost history

# edit configuration
#bind e new-window -n "~/.tmux.conf.local" sh -c '${EDITOR:-vim} ~/.tmux.conf.local && tmux source ~/.tmux.conf && tmux display "~/.tmux.conf sourced"'

# reload configuration
bind r source-file ~/.config/tmux/tmux.conf \; display 'tmux.conf sourced'


# -- display -------------------------------------------------------------------

set -g @plugin 'dracula/tmux'
set -g @dracula-plugins "time network-bandwidth cpu-usage ram-usage"
set -g @dracula-show-powerline true
set-option -g status-position top
# the default is 5, it can accept any number
set -g @dracula-refresh-rate 1

set -g base-index 1           # start windows numbering at 1
setw -g pane-base-index 1     # make pane numbering consistent with windows

setw -g automatic-rename on   # rename window to reflect current program
set -g renumber-windows on    # renumber windows when a window is closed

set -g set-titles on          # set terminal title

set -g display-panes-time 800 # slightly longer pane indicators display time
set -g display-time 1000      # slightly longer status messages display time

set -g status-interval 10     # redraw status line every 10 seconds

# clear both screen and history
bind -n C-l send-keys C-l \; run 'sleep 0.2' \; clear-history

# activity
set -g monitor-activity on
set -g visual-activity off


# -- navigation ----------------------------------------------------------------

# create session
bind C-c new-session

# find session
bind C-f command-prompt -p find-session 'switch-client -t %%'

# session navigation
bind BTab switch-client -l  # move to last session

# split current window horizontally
bind v split-window -h
# split current window vertically
bind C-s split-window -v

# pane navigation
bind -r h select-pane -L  # move left
bind -r j select-pane -D  # move down
bind -r k select-pane -U  # move up
bind -r l select-pane -R  # move right
bind > swap-pane -D       # swap current pane with the next one
bind < swap-pane -U       # swap current pane with the previous one

# maximize current pane
bind + run 'cut -c3- ~/.tmux.conf | sh -s _maximize_pane "#{session_name}" #D'

# pane resizing
bind -r H resize-pane -L 2
bind -r J resize-pane -D 2
bind -r K resize-pane -U 2
bind -r L resize-pane -R 2

# window navigation
unbind n
unbind p
bind -r C-h previous-window # select previous window
bind -r C-l next-window     # select next window
bind Tab last-window        # move to last active window

# toggle mouse
bind m run "cut -c3- ~/.tmux.conf | sh -s _toggle_mouse"


# -- urlview -------------------------------------------------------------------

bind U run "cut -c3- ~/.tmux.conf | sh -s _urlview #{pane_id}"


# -- facebook pathpicker -------------------------------------------------------

bind F run "cut -c3- ~/.tmux.conf | sh -s _fpp #{pane_id} #{pane_current_path}"


# -- copy mode -----------------------------------------------------------------

bind Enter copy-mode # enter copy mode

bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi C-v send -X rectangle-toggle
bind -T copy-mode-vi y send -X copy-selection-and-cancel
bind -T copy-mode-vi Escape send -X cancel
bind -T copy-mode-vi H send -X start-of-line
bind -T copy-mode-vi L send -X end-of-line

# copy to X11 clipboard
if -b 'command -v xsel > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xsel -i -b"'
if -b '! command -v xsel > /dev/null 2>&1 && command -v xclip > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xclip -i -selection clipboard >/dev/null 2>&1"'
# copy to Wayland clipboard
if -b 'command -v wl-copy > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | wl-copy"'
# copy to macOS clipboard
if -b 'command -v pbcopy > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | pbcopy"'
if -b 'command -v reattach-to-user-namespace > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | reattach-to-user-namespace pbcopy"'
# copy to Windows clipboard
if -b 'command -v clip.exe > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | clip.exe"'
if -b '[ -c /dev/clipboard ]' 'bind y run -b "tmux save-buffer - > /dev/clipboard"'


# -- buffers -------------------------------------------------------------------

bind b list-buffers     # list paste buffers
bind p paste-buffer -p  # paste from the top paste buffer
bind P choose-buffer    # choose which buffer to paste from

	'';
  };
}
```

* software
```nix tangle:software.nix
{config,pkgs,...}:{
}
```

* kitty
```nix tangle:kitty.nix
{config,pkgs,...}:{
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
```

{ config, pkgs, ... }:
  {
programs.zsh= {
  enable = true;
  enableAutosuggestions = true;
  enableSyntaxHighlighting = true;
  initExtra = ''
  eval "$(zoxide init zsh)" 
  eval "$(starship init zsh)"

  #ZSH_TMUX=$(tmux ls | grep "zsh")
  #ZSH_TMUX=`ps aux | grep "tmux new-session -s zsh" | grep -v grep`
  #if [[ -n $ZSH_TMUX ]]; then
  #  tmux a -t zsh 
  #else
  #  tmux new-session -s zsh && tmux a -t zsh
  #fi
    
  
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

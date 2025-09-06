{ config, pkgs, lib, ... }:
  
{
  imports = [
    ./starship.nix
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      la="eza -la";
      cp="cp -i";
      # nord="nordvpn status";
      # nordc="nordvpn c";
      # nordd="nordvpn d";
      yt-dlp-mp3="yt-dlp -x --audio-format mp3 -o '%(title)s'";
      yt-dlp-video="yt-dlp -o '%(title)s' --remux-video mkv --embed-metadata";
      yt-dlp-video-allAudio="yt-dlp -o '%(title)s' -f 'bv*+mergeall[ext=m4a]' --audio-multistream --embed-metadata"; # ext=m4a might work for every video, not sure
      yt-dlp-video-allAudio-playlist="yt-dlp -o '%(playlist_index)s %(title)s' -f 'bv*+mergeall[ext=m4a]' --audio-multistream --embed-metadata"; # ext=m4a might work for every video, not sure
      "7z-ultra"="7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on";
      # win11="sudo ~/.BLmount.sh";
      # unwin11="sudo ~/.BLunmount.sh";
      getip="ip addr show | grep -Eo '192.168.[0-9]{1,3}.[0-9]{1,3}/' | rev | cut -c 2- | rev";
      #dockerips='docker inspect -f "{{.Name}}: {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $(docker ps -q)';
      dc="docker-compose";
      dct="docker-compose --profile test";
    };

    initContent = lib.mkOrder 1200 ''
      eval "$(starship init zsh)"
      # [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
      #source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k/powerkevek10k.zsh-theme
      #this improves speed
      #zcompile ~/.p10k.zsh ~/.zshrc

      ## Options section
      setopt correct                                                  # Auto correct mistakes
      setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
      setopt nocaseglob                                               # Case insensitive globbing
      setopt rcexpandparam                                            # Array expension with parameters
      setopt nocheckjobs                                              # Don't warn about running processes when exiting
      setopt numericglobsort                                          # Sort filenames numerically when it makes sense
      setopt nobeep                                                   # No beep
      setopt appendhistory                                            # Immediately append history instead of overwriting
      setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
      setopt autocd                                                   # if only directory path is entered, cd there.
      setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
      setopt histignorespace                                          # Don't save commands that start with space

      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' # Case insensitive tab completion
      zstyle ':completion:*' rehash true                              # automatically find new executables in path 
      zstyle ':completion:*' menu select                              # Highlight menu selection
      # Speed up completions
      zstyle ':completion:*' accept-exact '*(N)'
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path ~/.zsh/cache
      #export EDITOR=/usr/bin/nano
      #export VISUAL=/usr/bin/nano


      ## Keybindings section
      # bindkey -e
      bindkey '^[[7~' beginning-of-line                               # Home key
      bindkey '^[[H' beginning-of-line                                # Home key
      bindkey '^[[8~' end-of-line                                     # End key
      bindkey '^[[F' end-of-line                                     # End key
      bindkey '^[[2~' overwrite-mode                                  # Insert key
      bindkey '^[[3~' delete-char                                     # Delete key
      bindkey '^[[C'  forward-char                                    # Right key
      bindkey '^[[D'  backward-char                                   # Left key
      bindkey '^[[5~' history-beginning-search-backward               # Page up key
      bindkey '^[[6~' history-beginning-search-forward                # Page down key

      # Navigate words with ctrl+arrow keys
      bindkey '^[Oc' forward-word                                     #
      bindkey '^[Od' backward-word                                    #
      bindkey '^[[1;5D' backward-word                                 #
      bindkey '^[[1;5C' forward-word                                  #
      bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
      bindkey '^[[3;5~' kill-word                                     # delete coming word
      bindkey '^[[Z' undo                                             # Shift+tab undo last action

      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d "" cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
      }

    '';

    plugins = [
      # {
      #   name = "powerlevel10k";
      #   src = pkgs.zsh-powerlevel10k;
      #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      # }
      # {
      #   name = "powerlevel10k-config";
      #   src = ~/.p10k.zsh;
      #   file = "p10k.zsh";
      # }
      { # applies the zsh shell to `nix-shell`
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
    oh-my-zsh = {
      enable = true;
      #theme = "powerlevel10k/powerlevel10k";
      #customPkgs = [ pkgs.zsh-powerlevel10k ];
      plugins = [ "git" ];
    };
  };
}

{ config, pkgs, lib, ... }:

let
  darwinConfig = lib.optionalAttrs pkgs.stdenv.isDarwin {
    initContent = ''
      export PATH="$PATH:$HOME/.local/bin"
      if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
    profileExtra = ''
      export EDITOR='vim'
    '';
  };
in
  {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      defaultKeymap = "viins";
      initContent = ''
        export PATH="$PATH:$HOME/.local/bin"
      '';
      profileExtra = ''
        export EDITOR='vim'
        export NIXOS_OZONE_WL=1

        if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
          eval $(gnome-keyring-daemon -sd)
          export SSH_AUTH_SOCK=~/.1password/agent.sock
          systemctl --user import-environment PATH

          exec Hyprland
        fi
      '';
    } // darwinConfig;
  }

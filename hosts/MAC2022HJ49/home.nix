{ config, pkgs, ... }:

{
  home.username = "lapis";
  home.homeDirectory = "/Users/lapis";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    aws-sam-cli
    aws-vault
    awscli
    bat
    bottom
    bruno
    bruno-cli
    e1s
    gettext
    gh
    gobject-introspection
    jq
    libyaml
    ripgrep
    sops
    tldr
    yarn
    yq
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets = {
      "git-config" = {
        sopsFile = ../../secrets/git-config;
        format = "binary";
      };
      "git-heyjobs-config" = {
        sopsFile = ../../secrets/git-heyjobs-config;
        format = "binary";
      };
    };
  };


  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      idiomatic_version_file_enable_tools = ["ruby" "node"];
    };
  };

  imports = [
    ../../user-config/command-not-found.nix
    ../../user-config/direnv.nix
    ../../user-config/eza.nix
    ../../user-config/fzf.nix
    ../../user-config/ghostty.nix
    ../../user-config/git.nix
    ../../user-config/kitty.nix
    ../../user-config/neovim.nix
    ../../user-config/starship.nix
    ../../user-config/tmux.nix
    ../../user-config/vim.nix
    ../../user-config/zoxide.nix
    ../../user-config/zsh.nix
  ];
}

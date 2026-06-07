{ config, pkgs, ... }:

{
  home.username = "lapis";
  home.homeDirectory = "/Users/lapis";
  home.stateVersion = "24.11";
  home.sessionVariables.NH_FLAKE = "/Users/lapis/Projects/nix";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    _1password-cli
    aws-vault
    awscli2
    bat
    bear
    bottom
    bruno
    bruno-cli
    claude-code
    devenv
    e1s
    fd
    gettext
    gh
    gobject-introspection
    jq
    libyaml
    nh
    ripgrep
    sops
    tldr
    uv
    yarn
    yq
  ];

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    globalConfig.settings = {
      idiomatic_version_file_enable_tools = ["ruby" "node"];
    };
  };

  imports = [
    ../../user-config/sops.nix
    ../../user-config/atuin.nix
    ../../user-config/nix-index.nix
    ../../user-config/direnv.nix
    ../../user-config/eza.nix
    ../../user-config/firefox.nix
    ../../user-config/fzf.nix
    ../../user-config/ghostty.nix
    ../../user-config/git.nix
    ../../user-config/neovim.nix
    ../../user-config/starship.nix
    ../../user-config/tmux.nix
    ../../user-config/vim.nix
    ../../user-config/yazi.nix
    ../../user-config/zoxide.nix
    ../../user-config/zsh.nix
  ];
}

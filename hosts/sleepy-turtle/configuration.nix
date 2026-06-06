# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  environment.shells = [ pkgs.zsh ];
  environment.systemPackages = with pkgs; [
    curl
    git
    kdePackages.ark
    polkit_gnome
    vim
    wget
    brightnessctl
  ];
  environment.variables.EDITOR = "vim";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings.General.Experimental = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_ADDRESS = "pt_BR.UTF-8";
  i18n.extraLocaleSettings.LC_IDENTIFICATION = "pt_BR.UTF-8";
  i18n.extraLocaleSettings.LC_MEASUREMENT = "pt_BR.UTF-8";
  i18n.extraLocaleSettings.LC_MONETARY = "pt_BR.UTF-8";
  i18n.extraLocaleSettings.LC_NAME = "pt_BR.UTF-8";
  i18n.extraLocaleSettings.LC_NUMERIC = "pt_BR.UTF-8";
  i18n.extraLocaleSettings.LC_PAPER = "pt_BR.UTF-8";
  i18n.extraLocaleSettings.LC_TELEPHONE = "pt_BR.UTF-8";
  i18n.extraLocaleSettings.LC_TIME = "pt_BR.UTF-8";

  networking.hostName = "sleepy-turtle";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.networkmanager.wifi.powersave = false;
  networking.wireless.iwd.settings.Network.EnableIPv6 = false;
  networking.firewall.checkReversePath = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  programs.command-not-found.enable = false;

  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = [ "tortoise" ];
  programs._1password.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  programs.seahorse.enable = true;
  # SSH agent is provided by 1password (see SSH_AUTH_SOCK in user-config/zsh.nix)
  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.dedicatedServer.openFirewall = true;
  programs.steam.localNetworkGameTransfers.openFirewall = true;
  programs.zsh.enable = true;

  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs; [
    thunar-archive-plugin
    thunar-media-tags-plugin
    thunar-volman
  ];
  programs.xfconf.enable = true;
  services.tumbler.enable = true;

  security.pam.services.hyprlock = { };
  security.rtkit.enable = true;

  services.logind.settings.Login.HandlePowerKey = "ignore";
  services.logind.settings.Login.HandlePowerKeyLongPress = "poweroff";

  services.blueman.enable = true;
  services.dbus.enable = true;
  services.fprintd.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.wireplumber.extraConfig."51-bluez" = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
    };
  };
  services.printing.enable = true;
  services.upower.enable = true;

  # First installed version, used to manage state. DO NOT CHANGE UNLESS THERE'S A GOOD REASON TO
  system.stateVersion = "23.11"; # Did you read the comment?

  swapDevices = [
    {
      device = "/swapfile";
      size = 4000;
    }
  ];

  time.timeZone = "Europe/Berlin";
  # time.timeZone = "America/Sao_Paulo";

  users.defaultUserShell = pkgs.zsh;
  users.users.tortoise.isNormalUser = true;
  users.users.tortoise.extraGroups = [
    "networkmanager"
    "wheel"
    "video"
    "audio"
  ];
  users.users.tortoise.shell = pkgs.zsh;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  xdg.portal.config.common.default = "*";
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
  ];
}

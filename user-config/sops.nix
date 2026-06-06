{ config, ... }:

{
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets = {
      "git-config" = {
        sopsFile = ../secrets/git-config;
        format = "binary";
      };
      "git-heyjobs-config" = {
        sopsFile = ../secrets/git-heyjobs-config;
        format = "binary";
      };
    };
  };
}

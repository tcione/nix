{ config, pkgs, ... }:

{
  programs.walker = {
    enable = true;
    runAsService = true;
    config = {
      theme = "default";
    };
  };
}

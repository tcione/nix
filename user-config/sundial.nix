{ config, pkgs, ... }:

{
  services.sundial = {
    enable = true;
    logLevel = "debug";
    interval = "*:0/1";
  };
}

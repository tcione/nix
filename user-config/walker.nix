{ config, pkgs, ... }:

{
  programs.walker = {
    enable = true;
    runAsService = true;
    config = {
      theme = "default";
    };

    themes = {
      "sleepy-turtle" = {
        style = builtins.readFile(./files/walker-style.css);
      };
    };
  };
}

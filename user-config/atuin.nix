{ config, pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      style = "compact";
      inline_height = 20;
      show_preview = true;
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "session";
      enter_accept = false;
    };
  };
}

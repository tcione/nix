{ config, pkgs, lib, ... }:

let
  arkenfoxVersion = "144.0";
  arkenfoxUserJs = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/arkenfox/user.js/${arkenfoxVersion}/user.js";
    sha256 = "0gp3wyxljzly37qmgyfqhz48mw6pl9bhwph3yxf1g6a8j7337az4";
  };

  userOverrides = ''
    // === user-overrides — applied after arkenfox ===

    // 0102 — restore previous session on startup
    user_pref("browser.startup.page", 3);

    // 2811/2812 — keep history & cookies across restarts
    user_pref("privacy.clearOnShutdown.history", false);
    user_pref("privacy.clearOnShutdown.cookies", false);
    user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false);
    user_pref("privacy.clearOnShutdown_v2.cookiesAndStorage", false);

    // 2820 — same for the Ctrl-Shift-Del dialog defaults
    user_pref("privacy.cpd.history", false);
    user_pref("privacy.cpd.cookies", false);

    // 1223 — relax cert pinning to warn-only (corporate proxies / MITM AV)
    user_pref("security.cert_pinning.enforcement_level", 1);
  '';
in
{
  programs.firefox = {
    enable = true;
    package = if pkgs.stdenv.hostPlatform.isDarwin then null else pkgs.firefox;
    configPath = ".mozilla/firefox";

    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
      DisableFirefoxStudies = true;

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "@testpilot-containers" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          installation_mode = "force_installed";
        };
        "{c607c8df-14a7-4f28-894f-29e8722976af}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/temporary-containers/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles.default = {
      id = 0;
      isDefault = true;

      extraConfig = (builtins.readFile arkenfoxUserJs) + "\n" + userOverrides;

      # Containers unmanaged: Temporary Containers mutates containers.json at
      # runtime, conflicting with HM's read-only symlink.
    };
  };

  # On macOS, Firefox writes installs.ini with a per-install profile lock that
  # overrides profiles.ini's Default=1. If it points at a profile we don't
  # manage, Firefox reports the profile as missing. Drop it so Firefox recreates
  # it locked to the home-manager-managed profile.
  home.activation = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    firefoxFixInstallsIni = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      installsIni="$HOME/Library/Application Support/Firefox/installs.ini"
      if [ -f "$installsIni" ] && ! grep -qE '^Default=Profiles/default$' "$installsIni"; then
        verboseEcho "firefox: removing stale installs.ini (points to unmanaged profile)"
        run rm -f "$installsIni"
      fi
    '';
  };
}

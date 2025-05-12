{ config, pkgs, lib, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    dictionaries = [
      pkgs.hunspellDictsChromium.en_US
      pkgs.hunspellDictsChromium.de_DE
    ];
    extensions =
      let
        createChromiumExtensionFor = browserVersion: { id, sha256, version }:
          {
            inherit id;
            crxPath = builtins.fetchurl {
              url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
              name = "${id}.crx";
              inherit sha256;
            };
            inherit version;
          };
        createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
      in
        [
          (createChromiumExtension {
            # cookies autodelete
            id = "fhcgjolkccmbidfldomjliifgaodjagh";
            sha256 = "sha256:0bgd7k68wl3invdism0awjdxbdfbm1c7nimfzqhzmv2mvwr6059y";
            version = "3.8.2";
          })
          (createChromiumExtension {
            # ublock origin
            id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
            sha256 = "sha256:1lnk0k8zy0w33cxpv93q1am0d7ds2na64zshvbwdnbjq8x4sw5p6";
            version = "1.63.2";
          })
          (createChromiumExtension {
            # privacy badger
            id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";
            sha256 = "sha256:0iarnnzxxv77mg2adjmmmwhjxnlfl4xa6hczqyxczbikr87sn7yn";
            version = "2025.3.27";
          })
          (createChromiumExtension {
            # 1password
            id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";
            sha256 = "sha256:0yk3akkgq1r1dg0360bq0y4kgnnww8gvqa4lqnmwc4mkpwv6mkp4";
            version = "8.10.70.27";
          })
          (createChromiumExtension {
            # Lexical Dev Tools
            id = "kgljmdocanfjckcgfpcpdoklodllfdpc";
            sha256 = "sha256:0vx5iznxk5wwn3qfmqs8zayqv1mxyszzppbngy6yzqb9nzqc52b9";
            version = "0.16.0.0";
          })
          (createChromiumExtension {
            # Grammarly
            id = "kbfnbcaeplbcioakkpcpgfkobkghlhen";
            sha256 = "sha256:067pcfmgfndkbjbdlw3r5inx4ll4xqm2r8f6y99mnyz4isx9awsx";
            version = "14.1233.0";
          })
        ];
  };
}

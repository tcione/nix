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
              url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc&pv=${version}";
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
            sha256 = "sha256:0c2y84bwyliqkff7xn6swvg6fbsprc65p79bvnxdh88wzqyhf3pd";
            version = "1.67.0";
          })
          (createChromiumExtension {
            # privacy badger
            id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";
            sha256 = "sha256:19vpk8h8q0xgi40hgv1bd24n3napbgbzg12najc3mkapqcvfcmhc";
            version = "2025.9.5";
          })
          (createChromiumExtension {
            # 1password
            id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";
            sha256 = "sha256:0h221jb61kvw5y3ppn4xvsf0675235vyxzlk2493md2irbi88mvp";
            version = "8.11.16.35";
          })
        ];
  };
}

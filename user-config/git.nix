{ config, pkgs, lib, ... }:

{
  programs.delta.enable = true;
  programs.delta.enableGitIntegration = true;

  programs.git = {
    enable = true;
    ignores = [
      "*.pyc"
      ".DS_Store"
      "Desktop.ini"
      "._*"
      "Thumbs.db"
      ".Spotlight-V100"
      ".Trashes"
      ".extra"
      "!.gitkeep"
      "tmux-client*.log"
      "*.swp"
      "__gitignore_*"
      "__todo.txt"
      "vim/.netrwhist"
      "noice.log"
    ];
    settings = {
      alias = {
        aa = "add --all";
        discard = "!f() { git reset --hard && git clean -xfd}; f";
        l = "log --pretty=oneline -n 20 --graph --abbrev-commit";
        l-tree = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        patch = "!f() { git add --all; git commit --amend --no-edit; }; f";
        pull-current = "!f() { git pull origin $(git rev-parse --abbrev-ref HEAD); }; f";
        push-force = "push --force-with-lease";
        s = "status -s";
        uncommit = "!f() { git reset --soft HEAD~1; git reset HEAD; }; f";
        undo = "!f() { git uncommit; git discard; }; f";
      };
      branch.sort = "-committerdate";
      column.ui = "auto";
      commit.verbose = true;
      fetch.all = true;
      fetch.prune = true;
      fetch.pruneTags = true;
      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      merge.tool = "nvimdiff";
      mergetool.keepBackup = false;
      mergetool.nvimdiff.layout = "LOCAL,BASE,REMOTE / MERGED";
      mergetool.prompt = false;
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autoSquash = true;
      rebase.autoStash = true;
      rebase.updateRefs = true;

      include.path = config.sops.secrets."git-config".path;
    };
    includes = [
      {
        condition = "gitdir:~/Projects/heyjobs/";
        path = config.sops.secrets."git-heyjobs-config".path;
      }
    ];
  };
}

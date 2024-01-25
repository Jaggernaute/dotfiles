{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Jaggernaute";
    userEmail = "lucas.videcoq1" + "@" + "gmail.com";

    extraConfig.url = {
      init = {
        defaultBranch = "main";
      };

      "ssh://git@github.com/" = {
        insteadOf = "https://github.com/";
      };
    };

    ignores = [
      # C commons
      ".cache"
      "compile_commands.json"
      "*.gc??"
      "vgcore.*"
      # Python
      "venv"
      # Locked Files
      "*~"
      # Mac folder
      ".DS_Store"
      # Direnv
      ".direnv"
      ".envrc"
      # Nix buid
      "result"
      # IDE Folders
      ".idea"
      ".vscode"
      ".vs"
    ];
  };
}

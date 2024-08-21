{ config, pkgs, inputs, ... }:
let
  username = "charlotte";
  configDir = inputs.dotfiles.outPath;
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    nnn # terminal file manager

    obsidian # note taking tool

    # utils
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    jq # A lightweight and flexible command-line JSON processor
    ripgrep # recursively searches directories for a regex pattern

    # misc
    file
    gawk
    gnumake
    gnused
    gnutar
    tree
    which

    python3
    rust-analyzer
    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    typescript
  ];

  home.sessionVariables = {
    fish_config_dir = "/etc/nixos/dotfiles/fish";
  };

  # ts server alias for neovim
  home.file.".local/bin/typescript-language-server" = {
    source = "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Charlotte Smith";
    userEmail = "charliesmith5019@gmail.com";
  };

  programs.fish = {
    enable = true;
    shellInitLast = "source ${configDir}/fish/config.fish";
  };

  home.file.".config/fish/completions" = {
    source = "${configDir}/fish/completions";
    recursive = true;
  };

  home.file.".config/fish/functions" = {
    source = "${configDir}/fish/functions";
    recursive = true;
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

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

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

  ];

  home.sessionVariables = {
    fish_config_dir = "/etc/nixos/dotfiles/fish";
  };

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

  home.file = builtins.mapAttrs
    (name: value: { source = "${configDir}/${value}"; recursive = true; })
    {
      ".config/fish/completions" = "fish/completions";
      ".config/fish/functions" = "fish/functions";
      ".config/nvim" = "nvim";
      ".config/kitty" = "kitty";
      ".config/tmux" = "tmux";
      ".config/wezterm" = "wezterm";
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

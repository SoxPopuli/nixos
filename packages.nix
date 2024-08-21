{ pkgs, pkgs-23_11, awsvpnclient, ... }:
let
  devPackages = with pkgs; [
    gh
    rustup
    cargo
    gcc
    git
    nil
    zip
    nodejs_20
    tree-sitter
    yarn
    lua-language-server
    docker-compose
    zig
    # Haskell
    ghc
    haskell-language-server
    cabal-install
    #
    vscode-langservers-extracted

    yaml-language-server
    bash-language-server
    shellcheck
    netcoredbg

    vscode-fhs

    pyright
    neovim
    direnv
  ];

  oldPackages = with pkgs-23_11; [
    wezterm #Fails to compile for Rust 1.81
    awscli2
  ];
in
{
  config.environment.systemPackages = with pkgs; [
    curl
    dropbox
    dropbox-cli
    eza
    fd
    firefox
    kate
    keepassxc
    lua
    luajitPackages.luarocks
    ripgrep
    stylua
    tmux
    unzip
    wget
    zoxide
    awsvpnclient
  ]
  ++ oldPackages
  ++ devPackages;
}

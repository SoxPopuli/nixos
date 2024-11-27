{ pkgs, pkgs-23_11, awsvpnclient, ... }:
let
  devPackages = with pkgs; [
    gh
    rustup
    cargo
    gcc

    cmake

    git
    git-absorb

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
    marksman

    taplo

    avalonia-ilspy # DotNet Decompiler

    wezterm 
    mitmproxy

    lutris
  ];

  flakePackages = [
    awsvpnclient
  ];

  oldPackages = with pkgs-23_11; [
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
    htop
    kate
    keepassxc
    lua
    luajitPackages.luarocks
    mpv
    p7zip
    ripgrep
    stylua
    tmux
    tor-browser
    transmission_4
    transmission_4-qt
    unzip
    wget
    wine64
    zoxide
  ]
  ++ flakePackages
  ++ oldPackages
  ++ devPackages;
}

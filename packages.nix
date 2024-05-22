{ pkgs, ... }: {
  config.environment.systemPackages = with pkgs; [
    cargo
    curl
    dropbox
    dropbox-cli
    eza
    fd
    firefox
    gcc
    git
    kate
    keepassxc
    luajitPackages.luarocks
    lua-language-server
    neovim
    nil
    nodejs_20
    ripgrep
    stylua
    tmux
    tree-sitter
    unzip
    wezterm
    wget
    yarn
  ];
}

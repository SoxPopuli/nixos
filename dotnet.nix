{ pkgs, ... }:
{
  config.environment.systemPackages = [
    (with pkgs.dotnetCorePackages; combinePackages [
      sdk_6_0
      sdk_7_0
      sdk_8_0
    ])

    pkgs.fsautocomplete # F# LSP
  ];
}

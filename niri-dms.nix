{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./niri.nix
    ./dms.nix
  ];

}

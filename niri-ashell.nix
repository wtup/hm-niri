{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./niri.nix
    ./ashell.nix
    ./zellij.nix
    ./fish.nix
  ];

}

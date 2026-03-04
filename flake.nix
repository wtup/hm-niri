{
  description = "Home Manager configuration of lperusko";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ashell= {
      url = "github:MalpenZibo/ashell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, niri, dms, ashell, stylix, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations= {
        "lperusko" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit ashell; };
          modules = [
            niri.homeModules.niri
            niri.homeModules.stylix
            stylix.homeModules.stylix
            ./niri-ashell.nix
          ];
        };
        "niri-dms" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            niri.homeModules.niri
            niri.homeModules.stylix
            dms.homeModules.dank-material-shell
            dms.homeModules.niri
            stylix.homeModules.stylix
            ./niri-dms.nix
          ];
        };
      };
    };
}

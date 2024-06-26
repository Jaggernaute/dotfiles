{
  description = "Jaggi dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    hosts.url = "github:StevenBlack/hosts";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = inputs:
    with inputs; let

      cfg = {
        inherit system;
        config.allowUnfree = true;
      };

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = import inputs.nixpkgs-unstable cfg;
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      nixosConfigurations = {
        Bacon = nixpkgs.lib.nixosSystem
          (import ./bacon.nix { inherit inputs system unstable; withNVIDIA=true; });
        Toaster = nixpkgs.lib.nixosSystem
          (import ./toaster.nix { inherit inputs system unstable;
          withNVIDIA=false;});
      };
    };
}

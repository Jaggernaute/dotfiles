{ inputs, system }: with inputs;
let
  username = "jaggi";
in
{
  inherit system;

  specialArgs = {
    inherit username;
    hostname = "Toaster";
  };

  modules =
    let
      home-manager-conf = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${username} = import ./home;
          extraSpecialArgs = {
            inherit username system nix-doom-emacs;
          };
        };
      };

      hosts-conf = {
        networking.stevenBlackHosts.enable = true;
      };

      mod-nixhardware-lst = with nixos-hardware.nixosModules; [
        common-pc-laptop
        common-cpu-intel
        common-pc-ssd
      ];
    in
    [
      ./system
      ./hardware-configuration-laptop.nix
    ] ++ [
      home-manager.nixosModules.home-manager
      home-manager-conf
      hosts.nixosModule
      hosts-conf
    ] ++ mod-nixhardware-lst;
}

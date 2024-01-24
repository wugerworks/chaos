{
  description = "chaos";

  outputs = inputs@{ self, flake-utils, nixpkgs, ... }:

    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ inputs.devshell.overlays.default ];
          };
        in
        {
          devShells.default = pkgs.devshell.mkShell {
            name = "shell";
            env = [ ];
            commands = [
              {
                category = "ops";
                package = pkgs.deploy-rs;
                name = "deploy";
              }
              {
                category = "ops";
                package = inputs.ragenix.packages.${system}.ragenix;
                help = "manage secrets";
              }
              {
                category = "dev";
                package = pkgs.nixd;
              }
              {
                category = "dev";
                package = pkgs.nixpkgs-fmt;
              }
              {
                category = "dev";
                package = pkgs.nixfmt;
              }
            ];
            packages = [ ];
          };

          formatter = pkgs.nixpkgs-fmt;
        }) // {

      nixosConfigurations = {
        amadeus = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            inputs.ragenix.nixosModules.default
            inputs.home-manager.nixosModules.default

            self.nixosModules.core

            ./profiles/amadeus

            self.homeModules.suites.workstation
          ];
        };

        avandra = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            inputs.ragenix.nixosModules.default
            inputs.home-manager.nixosModules.default

            self.nixosModules.core

            ./profiles/avandra

            self.homeModules.suites.server
          ];
        };

        zug = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            inputs.ragenix.nixosModules.default
            inputs.home-manager.nixosModules.default

            self.nixosModules.core

             ./profiles/zug

            self.homeModules.suites.server
          ];
        };
      };

      nixosModules = inputs.haumea.lib.load {
        src = ./nixos;
        inputs = {
          inherit inputs;
          stateVersion = "23.11";
        };
        transformer = inputs.haumea.lib.transformers.liftDefault;
      };

      homeModules = inputs.haumea.lib.load {
        src = ./home;
        inputs = {
          inherit inputs;
          stateVersion = "23.11";
        };
        transformer = inputs.haumea.lib.transformers.liftDefault;
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.flake-utils.follows = "flake-utils";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";

    haumea.url = "github:nix-community/haumea?ref=v0.2.2";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    ragenix.url = "github:yaxitech/ragenix";
    ragenix.inputs.nixpkgs.follows = "nixpkgs";
  };
}

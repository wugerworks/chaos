{
  inputs,
  flake,
}: let
  inherit (flake) nixosConfigurations;
in {
  core = nixosConfigurations.nixos-test-core.config.chaos;
}

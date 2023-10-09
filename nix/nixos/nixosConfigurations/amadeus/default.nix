#TODO: Implement meta.description for std cli, intuitive implementation fails
{
  inputs,
  cell,
}: {
  bee = {
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs;
  };

  imports = [
    cell.nixosProfiles.core
    cell.nixosModules.users
    cell.nixosModules.test
  ];

  chaos = {
    nixos = {
      core = {
        hostName = "amadeus";
        vm.enable = true;
        ssh.enable = true;
      };
      users.wuger.enable = true;
      test = {
        nixos-generators = {
          virtualisation = {
            cores = 2;
            memorySize = 2048;
            graphics = false;
          };
        };
      };
    };
  };
}

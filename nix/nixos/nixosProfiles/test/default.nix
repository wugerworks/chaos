{
  inputs,
  cell,
}: {
  imports = [
    cell.nixosModules.test
    cell.nixosProfiles.core
  ];

  chaos = {
    nixos.core = {
      vm.enable = true;
      ssh.enable = true;
    };
  };

  # sops.age = {
  #   sshKeyPaths = [];
  #   keyFile = "/etc/sops-nix/age.key";
  # };
  # environment.etc = {
  #   "sops-nix/age.key".source = ./__secrets/age.key;
  #   "sops-nix/age.pub".source = ./__secrets/age.pub;
  # };
}

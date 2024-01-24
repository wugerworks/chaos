{ config, lib, ... }: {
  imports = [
    ./_hardware.nix
    ./_network.nix
    cell.core
  ];

  boot.grub = {
    enable = true;
    device = "/dev/sda";
  };
}

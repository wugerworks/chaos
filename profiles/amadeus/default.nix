{ config, lib, ... }: {
  imports = [
    ./_hardware.nix
    ./_samba.nix
    ./_services.nix
    ./_torrents.nix
    ./_users.nix
    ./_zfs-mounts.nix
  ];
}

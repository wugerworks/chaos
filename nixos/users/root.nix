{ root, ... }:
{ config, pkgs, lib, ... }: {
  # Root password
  age.secrets.root-password.file = root.secrets.users.wuger;
  users.users.root = {
    description = lib.mkForce "Wuger";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPasswordFile = lib.mkDefault config.age.secrets.root-password.path;
    shell = lib.mkForce pkgs.zsh;
  };
}

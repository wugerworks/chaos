{ root, ... }:
{ config, pkgs, lib, ... }: {
  age.secrets.wuger-password.file = root.secrets.users.wuger;

  users.users.wuger = {
    isNormalUser = true;
    description = "Wuger";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPasswordFile = lib.mkDefault config.age.secrets.wuger-password.path;
    shell = lib.mkForce pkgs.zsh;
  };

  programs.git = {
    userName = "Wuger";
    userEmail = "accounts+github@wuger.works";
  };
}

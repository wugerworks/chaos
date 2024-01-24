{ root, config, pkgs, ... }: {
  age.secrets.root-password.file = root.secrets.users.wuger;
  users.users.root = {
    description = "Root";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPasswordFile = config.age.secrets.root-password.path;
    shell = pkgs.zsh;
  };
}

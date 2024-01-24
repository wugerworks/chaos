{ root, config, pkgs, ... }: {
  age.secrets.wuger-password.file = root.secrets.users.wuger;

  users.users.wuger = {
    isNormalUser = true;
    description = "Wuger";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPasswordFile = config.age.secrets.wuger-password.path;
    shell = pkgs.zsh;
  };

  programs.git = {
    userName = "Wuger";
    userEmail = "accounts+github@wuger.works";
  };
}

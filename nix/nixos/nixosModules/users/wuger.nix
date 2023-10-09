{
  inputs,
  cell,
  selfCfg,
}: let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs.localLib) helpers;
  l = lib // builtins;
in {
  options = {
    enable = helpers.mkEnableOption false;
  };

  config = l.mkIf selfCfg.enable (l.mkMerge [
    {
      users.users.wuger = {
        uid = 1000;
        description = "Wuger";
        isNormalUser = true;
        initialHashedPassword = "$6$VxuEIVkoVItq2fN7$dsS878W2yBZxvmNoiKY5B2ESARpraVEUfaQ4.6Q5xIRs1v7H6iWnN/vwtiPa8B1QHpdWpqMd3uFoy4x/Um4m./";
        extraGroups = [
          "wheel"
          "networkmanager"
          # desktop
          "video"
          "audio"
          "lp" # printer
          # virtualisation
          "libvirtd"
          "docker"
          "podman"
        ];
      };

      security.sudo.extraRules = [
        {
          users = ["wuger"];
          commands = [
            {
              command = "ALL";
              options = ["SETENV" "NOPASSWD"];
            }
          ];
        }
      ];
    }
  ]);
}

{ config, lib, pkgs, cell, ... }: {
  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wireguard.interfaces.wg0 = {
    listenPort = 51820;
    privateKeyFile = config.age.secrets.wireguard-key.path;
  };
}

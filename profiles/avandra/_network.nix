{ config, lib, pkgs, cell, ... }: {
  imports = [
    cell.net
    cell.net.wireguard
    cell.net.openssh
  ];

  #Wireguard
  age.secrets.wireguard-key.file = cell.secrets.wireguard.avandra.key;
  networking = {
    wireguard.interfaces.wg0 = {
      ips = [ "${cell.secrets.wireguard.avandra.ip}/24" ];
      peers = [{
        publicKey = secrets.wireguard.zug.pub;
        allowedIPs = secrets.wireguard.allowedIPs;
        endpoint = secrets.wireguard.endpoint;
        persistentKeepalive = 25;
      }];
    };
  };
}

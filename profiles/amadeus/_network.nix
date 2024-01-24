{ config, lib, pkgs, cell, ... }: {
  imports = [
    cell.net
    cell.net.openssh
  ];

  #Wireguard
  age.secrets.wireguard-key.file = cell.secrets.wireguard.amadeus.key;
  networking = {
    firewall.allowedUDPPorts = [ 51820 ];
    wireguard.interfaces.wg0 = {
      ips = [ "${cell.secrets.wireguard.amadeus.ip}/24" ];
      listenPort = 51820;
      privateKeyFile = config.age.secrets.wireguard-key.path;
      peers = [{
        publicKey = secrets.wireguard.zug.pub;
        allowedIPs = secrets.wireguard.allowedIPs;
        endpoint = secrets.wireguard.endpoint;
        persistentKeepalive = 25;
      }];
    };
  };
}
 

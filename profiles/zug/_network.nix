{ config, lib, pkgs, cell, ... }: {
  imports = [
    cell.net
    cell.net.wireguard
    cell.net.openssh
  ];


  #Wireguard
  age.secrets.wireguard-key.file = cell.secrets.wireguard.zug.key;
  networking = {
    nat = {
      enable = true;
      externalInterface = "enp0s3";
      internalInterfaces = [ "wg0" ];
    };
    wireguard.interfaces.wg0 = {
      ips = [ "${cell.secrets.wireguard.zug.ip}/24" ];
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.10.0.0/24 -o enp0s3 -j MASQUERADE
      '';
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.10.0.0/24 -o enp0s3 -j MASQUERADE
      '';
      nat = {
          enable = true;
          externalInterface = "enp0s3";
          internalInterfaces = [ "wg0" ];
        };
      peers = [
        {
          publicKey = cell.secrets.wireguard.avandra.pub;
          allowedIPs = [ "10.10.0.2/32" ];
        }
        {
          publicKey = cell.secrets.wireguard.amadeus.pub;
          allowedIPs = [ "10.10.0.3/32" ];
        }
        }
      ];
    };
  };
}

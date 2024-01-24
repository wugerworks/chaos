{ pkgs, cell, ... }: {
  imports = [
    cell.net
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

    firewall.allowedUDPPorts = [ 51820 ];

    wireguard.interfaces.wg0 = {
      listenPort = 51820;
      
      ips = [ "${cell.secrets.wireguard.zug.ip}/24" ];
      
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.10.0.0/24 -o enp0s3 -j MASQUERADE
      '';
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.10.0.0/24 -o enp0s3 -j MASQUERADE
      '';
      
      privateKeyFile = config.age.secrets.wireguard-key.path;

      peers = [
        {
          publicKey = cell.secrets.wireguard.avandra.pub;
          allowedIPs = [ "10.10.0.2/32" ];
        }
        {
          publicKey = cell.secrets.wireguard.amadeus.pub;
          allowedIPs = [ "10.10.0.3/32" ];
        }
      ];
    };
  };
}

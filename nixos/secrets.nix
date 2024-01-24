{ ... }: {
  users = {
    wuger = ../secrets/users/wuger.age;
    root = ../secrets/users/root.age;
  };
  wireguard = {
    allowedIPs = [ "10.10.0.0/24" ];
    endpoint = "wg004.njalla.no:51820";

    # hosts
    avandra = {
      ip = "10.10.0.1";
      key = ../secrets/wireguard/wg-zug.age;
      pub = "AAAAB3NzaC1yc2EAAAADAQABAAACAQCqbCSrjDm6I4ZWpISyTCF4W8/Dra7DLEFwEwpgu24FlVdSeCpyiDfjmVLcZz6SLq/E/3ksKpbbwyqoj5XV3xbdqvi2+a85eDuQzK0Enokw2uzvaGS6NRU+lZcN+FENjwd8ovhbClCU03k7F7GskpcdQe22eZc56Tl63mf/10Y+AkGw23c2Sti+FotH2W3ev/96rFJtlSUyhW2kQaH1jXykmo59d9Cj3j3tAbVBgywDkUsQVGVQIlbYHkHE47bjyO4jX+9xtnZt2RcATBK6BycBHesRGaqM3sFhqhS9tV1pdH/sXz48prA3ZPG23Nr2mURGHn5rRMygJc8ttFcIgZ8W73wBXPzydljj8rjAs9qeMhqDg+8/VStbWorxV5Dvso4AUcvRU/+3INJfxi+2CprkxTX99PK7I2vsZb98MMKCqt5Zg0kghNmTDnfgbwA5Xj+PZvXQYLKs9tVPSFqTBz0K6bM4KW48lfs4I5ofK0p48j5NRaJWFcyHJpBMMF4l0q9clROpBO+lBITuPATVRbq/rQ86sn3meaEmn2d5RCQaJHxRxlzi3YGfoiXebLBbkbgsa6M0B2eLWenrTqVv21NbogkA45UfRgHeEgrxPpM1Rdvpv59D+gyEaIuCgaK8AOkMxwjwAS+adxxAjKUnDtxpSHOFvj15GdgmBH1ANsKg7Q==";
    };
    zug = {
      ip = "10.10.0.2";
      key = ../secrets/wireguard/wg-avandra.age;
      pub = "AAAAC3NzaC1lZDI1NTE5AAAAIINNxebSsKfK4bN3C6D8xVLsL3O3+KAd45qfzPnqetwy";
    };
    amadeus = {
      ip = "10.10.0.3";
      key = ../secrets/wireguard/wg-amadeus.age;
      pub = "AAAAC3NzaC1lZDI1NTE5AAAAIJwbp3ndy12xONTjh48ATM7fOeiGKEPvekaCyq46soQH";
    };
  };
}

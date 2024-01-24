let
  wuger =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGLUBR35SP6PEIn41qBg19x7BoQI2C9uMHyhMla6WYN9";
  avandra =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPOLvgspK/0rp4Sz7ZWNMW6CioSfCBH7bKE72HoU8vim";
  zug =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOthdftwPv6orliN61tTzcSC89L1uvHdT4d8+ErXlndt";
  

  all = [ wuger avandra zug ];
in
{
  # wireguard
  "secrets/wireguard/wg-amadeus.age".publicKeys = [ wuger ];
  "secrets/wireguard/wg-avandra.age".publicKeys = [ wuger avandra ];
  "secrets/wireguard/wg-zug.age".publicKeys = [ wuger zug ];

  # user secrets
  "secrets/users/wuger.age".publicKeys = all;
  "secrets/users/root.age".publicKeys = all;
}

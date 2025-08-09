# { pkgs, lib, ...}:
# let
#   nordvpnPkgs = import (builtins.fetchGit {
#     url = "https://github.com/SanferDsouza/nixpkgs";
#     ref = "nordvpn";
#     rev = "990b687430d6bef9f7bc514ad79b0be7cf4c343f";
#   });
# in 
# {
#   nordvpnPkgs.nordvpn.enable = true;
# }

{pkgs, lib, ...}:

{
  # ===== NORDVPN RELATED =======                
  services.nordvpn.enable = true;                
  environment.etc."hosts.nordvpn" = {            
    mode = "0644";                               
    user = "nordvpn";                            
    group = "nordvpn";                           
    text = "";                                   
  };                                             
  networking.firewall.checkReversePath = false;  
  networking.firewall.enable = true;             
  networking.nameservers = [ "127.0.0.1" ];     # use dnsmasq
  services.resolved.enable = lib.mkForce false;  # current nixos-module for nordvpn uses systemd-resolved
  services.dnsmasq = {                           
    enable = true;                               
    alwaysKeepRunning = true;                    
    settings = {                                 
      addn-hosts = "/etc/hosts.nordvpn";         
    };                                           
  };                                             
  # ===== NORDVPN RELATED =======
}

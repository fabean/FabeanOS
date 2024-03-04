{ pkgs, config, lib, ... }:

let inherit (import ../../options.nix) tailscale; in
lib.mkIf (tailscale == true) {
  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
  };
}

{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix) distrobox; in
lib.mkIf (distrobox == true) {
  environment.systemPackages = [pkgs.distrobox];
}

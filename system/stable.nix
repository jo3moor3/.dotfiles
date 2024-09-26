{ config, lib, pkgs-stable, ... }:

{
  environment.systemPackages = with pkgs-stable; [ pureref ];
}

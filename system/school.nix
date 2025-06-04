{ pkgs, ... }:

{
  ### Basically just 2 inferior discord apps
  environment.systemPackages = with pkgs; [ zoom-us teams-for-linux ];
}

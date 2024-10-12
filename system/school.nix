{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [ zoom-us teams-for-linux ];
}

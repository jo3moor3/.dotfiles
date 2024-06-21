{ config, lib, pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    #virt-manager
    #qemu
    #quickemu # simplifying qemu
    qemu_kvm
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    samba # vm file sharing
    virglrenderer # possible host GPU support for vm
  ];
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.qemuGuest.enable = true;

  users.users.jomor.extraGroups = [ "libvirtd" ];
}

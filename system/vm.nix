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
  # hardware = {
  #   enableIOMMU = true;
  #   vfio.enable = true;
  # };
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
  boot = {
    kernelModules = [ "vfio_pci" "vfio_virqfd" "vfio_iommu_type1" "vfio" ];
    kernelParams = [ "amd_iommu=on" "iommu=pt" ];
  };
}

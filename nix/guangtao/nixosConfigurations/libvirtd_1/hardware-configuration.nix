# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{...}: {
  boot.loader.grub.device = "/dev/sda";
  fileSystems."/" = {device = "/dev/disk/by-label/nixos";};
}

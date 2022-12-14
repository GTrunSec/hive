{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;
  inherit (inputs.cells.common.lib) __inputs__;
in
  {
    desktop = [
      cell.overlays.default
      cell.overlays.python
      __inputs__.rust-overlay.overlays.default
      inputs.cells.emacs.overlays.emacs-overlay
      __inputs__.nixpkgs-wayland.overlays.default
    ];
    macbook = [
      cell.overlays.default
      inputs.cells.emacs.overlays.emacs-darwin
    ];
    libvirtd = [];
  }
  // inputs.cells.common.lib.importRakeLeaves ./overlays {inherit inputs cell;}

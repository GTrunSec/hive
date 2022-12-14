{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;

  nvfetcher-sources = l.foldr (a: b: a // b) {} (map (x: let
    x' =
      if x == "default"
      then "."
      else x;
  in {
    "nvfetcher-${x}" = {
      content = ''
        nix develop github:GTrunSec/cells-lab#update --refresh --command nvfetcher-update nix/guangtao/packages/${x'}/sources.toml
      '';
      description = "update ${x} toolchain with nvfetcher";
    };
  }) ["default" "emacs"]);
in
  {
    fmt = {
      description = "Formats all changed source files";
      content = ''
        treefmt $(git diff --name-only --cached)
      '';
    };
    desktop = {
      args = ["action"];
      description = "Colmena build Guangtao Home Machine";
      content = ''
        colmena {{action}} --on guangtao-o-desktop
      '';
    };
    libvirtd_1 = {
      description = "Colmena build Guangtao Libvirtd Machine";
      content = ''
        colmena build --on guangtao-o-libvirtd_1
      '';
    };
    age = {
      args = ["cell" "file"];
      description = "edit the key age with ragenix";
      content = ''
        ragenix --edit ./nix/{{cell}}/secretProfiles/{{file}} --rules ./nix/{{cell}}/secretProfiles/secrets.nix
      '';
    };
    age-rekey = {
      args = ["cell"];
      description = "re-age key with ragenix";
      content = ''
        ragenix --rules ./nix/{{cell}}/secretProfiles/secrets.nix --rekey
      '';
    };
    darwin-build = {
      args = ["machine"];
      description = "build darwin machine";
      content = ''
        darwin-rebuild build --flake .#guangtao-o-{{machine}}
      '';
    };
    nvfetcher-update = {
      args = ["cell"];
      description = "update packages via nvfetcher";
      content = ''
        nix develop github:GTrunSec/cells-lab#devShells.x86_64-linux.update --refresh --command nvfetcher-update nix/{{cell}}/packages/sources.toml
      '';
    };
  }
  // nvfetcher-sources

{
  description = "Pankomacs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    emacs = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs:
    inputs.parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];

      flake = {
        overlays.default = final: _prev: import ./overlay final;
      };

      perSystem = { pkgs, self', config, system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            inputs.emacs.overlays.default
            inputs.self.overlays.default
          ];
        };
        packages.pankomacs = pkgs.pankomacs;
        packages.default = self'.packages.pankomacs;

        apps.pankomacs.program = "${self'.packages.pankomacs}/bin/emacs";
        apps.default = config.apps.pankomacs;

        formatter = pkgs.nixpkgs-fmt;
      };
    };
}

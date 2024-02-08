{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };

      iio-hyprland = (with pkgs; stdenv.mkDerivation {
          name = "iio-hyprland";
          pname = "iio-hyprland";
          src = ./.;

          nativeBuildInputs = [
            meson
            pkg-config
            dbus
            ninja
          ];

          installPhase = ''
            mkdir -p $out/bin
            cp iio-hyprland $out/bin
          '';
        }
      );
    in rec {
      defaultApp = flake-utils.lib.mkApp {
        drv = defaultPackage;
      };
      defaultPackage = iio-hyprland;
      devShell = pkgs.mkShell {
        buildInputs = [
          iio-hyprland
        ];
      };
    }
  );
}

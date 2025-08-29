{
  outputs =
    {
      self,
      flake-utils,
      nixpkgs,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        devShells.default = pkgs.mkShell {
          inputsFrom = builtins.attrValues packages;
          nativeBuildInputs = [ ];
        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "u-boot";
          version = "ukoos-0.1.0";

          src = ./.;

          nativeBuildInputs = [
            pkgs.pkgsCross.riscv64-musl.stdenv.cc.bintools.bintools
            pkgs.pkgsCross.riscv64-musl.stdenv.cc.cc
            pkgs.bc
            pkgs.bison
            pkgs.flex
            pkgs.python3
          ];

          configurePhase = ''
            runHook preConfigure

            make \
              ''${enableParallelBuilding:+-j''${NIX_BUILD_CORES}} \
              ARCH=riscv \
              BOARD=cv181x \
              CHIP=cv181x \
              CONFIG_USE_DEFAULT_ENV=y \
              CROSS_COMPILE=riscv64-unknown-linux-musl- \
              CVIBOARD=milkv_duos_sd \
              STORAGE_TYPE=sd \
              milkv_duos_defconfig

            runHook postConfigure
          '';

          buildPhase = ''
            runHook preBuild

            make \
              ''${enableParallelBuilding:+-j''${NIX_BUILD_CORES}} \
              ARCH=riscv \
              BOARD=cv181x \
              CHIP=cv181x \
              CONFIG_TFTP_PORT=y \
              CONFIG_USE_DEFAULT_ENV=y \
              CROSS_COMPILE=riscv64-unknown-linux-musl- \
              CVIBOARD=milkv_duos_sd \
              STORAGE_TYPE=sd

            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall

            install -Dt $out -m 0644 u-boot.bin
            install -Dt $out -m 0644 u-boot.dtb
            install -Dt $out/bin tools/mkenvimage

            runHook postInstall
          '';

          enableParallelBuilding = true;
        };
      }
    );
}

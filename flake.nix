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
          nativeBuildInputs = [ pkgs.bear ];
        };
        formatter = pkgs.nixfmt-tree;
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "u-boot";
          version = "ukoos-0.1.0";

          src = ./.;

          nativeBuildInputs = [
            pkgs.pkgsCross.riscv64-musl.stdenv.cc.bintools.bintools
            pkgs.pkgsCross.riscv64-musl.stdenv.cc.cc
            pkgs.bc
            pkgs.bison
            pkgs.dtc
            pkgs.flex
            pkgs.python3
          ];
          buildInputs = [
            pkgs.openssl
          ];

          configurePhase = ''
            runHook preConfigure

            make \
              ARCH=riscv \
              k1_defconfig

            runHook postConfigure
          '';

          buildPhase = ''
            runHook preBuild

            make \
              ARCH=riscv \
              CROSS_COMPILE=riscv64-unknown-linux-musl- \
              ''${enableParallelBuilding:+-j''${NIX_BUILD_CORES}}

            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall

            install -Dt $out -m 0644 u-boot.itb
            install -Dt $out -m 0644 FSBL.bin
            install -Dt $out -m 0644 bootinfo_emmc.bin
            install -Dt $out -m 0644 bootinfo_sd.bin
            install -Dt $out -m 0644 bootinfo_spinand.bin
            install -Dt $out -m 0644 bootinfo_spinor.bin
            install -Dt $out/bin tools/mkenvimage
            install -Dt $out/bin tools/mkimage

            runHook postInstall
          '';

          enableParallelBuilding = true;
        };
      }
    );
}

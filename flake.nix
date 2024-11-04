# in flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };
  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          overlays = [ (import rust-overlay) ];
          pkgs = import nixpkgs {
            inherit system overlays;
          };
          # 👇 new! note that it refers to the path ./rust-toolchain.toml
          # rustToolchain = pkgs.pkgsBuildHost.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
          # rustToolchain = pkgs.pkgsBuildHost.rust-bin.fromRustcRev {
          # Revision for release 1.82.0 https://github.com/rust-lang/rust/releases/tag/1.82.0
          #   rev = "f6e511eec7342f59a25f7c0534f1dbea00d01b14";
          #   components = {
          #     rustc = "sha256-x+OkPVStX00AiC3GupIdGzWluIK1BnI4ZCBbg72+ZuI=";
          # From running nix hash to-sri --type sha256 $(nix-prefetch-url https://github.com/rust-lang/rust/archive/refs/tags/1.82.0.tar.gz)
          #     rust-src = "sha256-18ejLtISITy98XTKO1xPSfIsjPgVQw2jPLAVG92o3Ac=";
          #   };
          # };
          # rustToolchain = pkgs.pkgsBuildHost.rust-bin.stable.latest.default;
          rustToolchain = pkgs.pkgsBuildHost.rust-bin.stable."1.82.0".default;
        in
        with pkgs;
        {
          devShells.default = mkShell {
            # 👇 we can just use `rustToolchain` here:
            buildInputs = [ rustToolchain ];
          };
        }
      );
}

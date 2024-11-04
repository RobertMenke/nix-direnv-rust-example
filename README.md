## About
This is a minimal example that serves as a how-to guide for configuring a nix development shell for rust using nix flakes and direnv. This is not intended to be a robust guide and is instead aimed at beginners that just want to get a basic environment up and running.

## Set up
1. [Install nix](https://nixos.org/download/)
1. [Enable flakes](https://nixos.wiki/wiki/Flakes)
1. [Install direnv](https://direnv.net/docs/installation.html)
1. [Install nix-direnv](https://github.com/nix-community/nix-direnv)
1. Clone the repository `git clone git@github.com:RobertMenke/nix-direnv-rust-example.git`
1. Allow direnv `cd nix-direnv-rust-example && direnv allow`
1. Confirm the setup works with `rustc -V`
1. Optional: run the project `cargo run`. You should see "Hello, world!".

## New to nix and direnv?
This repository is using nix, and specifically nix flakes, to create what nix calls a `devShell`. A `devShell` is essentially a toolchain, or the specific binaries (programming languages, CLI tools, etc) that your project needs to build, run, and ship. The file `flake.nix` defines the dev shell. For a deeper understanding of nix flakes, start with this [tutorial](https://nixos-and-flakes.thiscute.world/).

`direnv` is a tool that can configure your shell in response to entering or leaving a directory. In this case, it tells nix to create the `devShell` when we `cd` into the directory. The configuration for `direnv` is very simple and can be found in `.envrc`.

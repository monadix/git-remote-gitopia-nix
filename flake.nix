{
  description = "Nix flake for git-remote-gitopia";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    git-remote-gitopia = {
      url = "file+https://server.gitopia.com/releases/gitopia/git-remote-gitopia/v1.8.0/git-remote-gitopia_1.8.0_linux_amd64.tar.gz";
      flake = false;
    };
  };

  outputs = { nixpkgs, flake-utils, git-remote-gitopia, ... }: 
  flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
  let 
    pkgs = import nixpkgs {
      inherit system;
    };

  in {
    packages.default = pkgs.stdenv.mkDerivation rec {

      name = "git-remote-gitopia";

      src = git-remote-gitopia;
      
      unpackPhase = ''
        mkdir -p $out/bin
        tar -xzf $src -C $out/bin
      '';
      
    };
  });
}

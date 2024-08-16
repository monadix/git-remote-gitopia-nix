{
  description = "Nix flake for git-remote-gitopia";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }: 
  flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
  let 
    pkgs = import nixpkgs {
      inherit system;
    };
    
    systemArch = if system == "x86_64-linux" then "linux_amd64" 
      else if system == "i686-linux" then "linux_386"
      else if system == "x86_64-darwin" then "darwin_amd64"
      else if system == "aarch64-darwin" then "darwin_arm64"
      else if system == "aarch32-linux" then "linux_arm"
      else if system == "aarch64-linux" then "linux_arm64"
      else "unknown";

  in {
    packages.default = pkgs.stdenv.mkDerivation rec {

      name = "git-remote-gitopia";
      
      src = builtins.fetchurl {
        url = "https://server.gitopia.com/releases/gitopia/git-remote-gitopia/v1.8.0/git-remote-gitopia_1.8.0_${systemArch}.tar.gz";
        sha256 = "1ampr861mw3yfnaka1ii164h79baic9qzjl9pwy1zc5763nm6lq0";
      };
      
      unpackPhase = ''
        mkdir -p $out/bin
        tar -xzf $src -C $out/bin
      '';
      
    };
  });
}

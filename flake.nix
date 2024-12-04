{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    let
      supportedSystems = with flake-utils.lib.system; [
        x86_64-linux
        x86_64-darwin
        aarch64-darwin
      ];
    in
    flake-utils.lib.eachSystem supportedSystems (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

      in
      {
        packages = {
          nginx-ldap-auth-service = import ./nginx-ldap-auth-service { inherit pkgs; };
          default = self.packages.${system}.nginx-ldap-auth-service;
        };

      }
    );
}

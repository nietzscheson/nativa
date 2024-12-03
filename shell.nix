{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    cmake
    jq
    nodejs_20
  ];

  packages = with pkgs; [
    git
    neovim
    httpie
    pre-commit
    go
    go-task
    docker
    amazon-ecr-credential-helper
  ];

  GIT_EDITOR = "${pkgs.neovim}/bin/nvim";
}
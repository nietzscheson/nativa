{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let
  android-nixpkgs = import <android-nixpkgs> {
    channel = "beta";
  };

  android-sdk = android-nixpkgs.sdk (sdkPkgs: with sdkPkgs; [
    cmdline-tools-latest
    build-tools-34-0-0
    platform-tools
    platforms-android-34
    emulator
  ]);
in
mkShell {
  nativeBuildInputs = with pkgs; [
    cmake
    jq
    nodejs_20
    jdk
    android-tools
    android-studio
    android-sdk
    e2fsprogs
    watchman
    home-manager
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
  shellHook = ''
  export JAVA_HOME="${pkgs.jdk}/lib/openjdk"
  export ANDROID_AVD_HOME=$HOME/.android/avd
  export PATH=$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH
  #export ANDROID_HOME="${android-sdk}/share/android-sdk"
  #export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH
  '';
}

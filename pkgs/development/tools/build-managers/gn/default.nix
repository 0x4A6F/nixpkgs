{ callPackage, ... } @ args:

callPackage ./generic.nix args {
  # Note: Please use the recommended version for Chromium, e.g.:
  # https://github.com/archlinux/svntogit-packages/blob/packages/gn/trunk/chromium-gn-version.sh
  rev = "5e19d2fb166fbd4f6f32147fbb2f497091a54ad8";
  revNum = "2077"; # git describe HEAD --match initial-commit | cut -d- -f3
  version = "2022-12-12";
  sha256 = "sha256-YPxUmf6EvH+gQjUjBi8sJjELdm/BDtPLvWvO6hrlrqw=";
}

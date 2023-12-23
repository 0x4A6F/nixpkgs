{ lib
, copyDesktopItems
, fetchFromGitHub
, makeDesktopItem
, stdenv
, unzip
, alsa-lib
, gcc-unwrapped
, git
, godot3-export-templates
, godot3-headless
, libGLU
, libX11
, libXcursor
, libXext
, libXfixes
, libXi
, libXinerama
, libXrandr
, libXrender
, libglvnd
, libpulseaudio
, zlib
, udev
}:

let
  preset =
    if stdenv.isLinux then "Linux/X11"
    else if stdenv.isDarwin then "Mac OSX"
    else throw "unsupported platform";
in

stdenv.mkDerivation rec {
  pname = "4D-Minesweeper";
  version = "2.0";

  src = fetchFromGitHub {
    owner = "gapophustu";
    repo = "4D-Minesweeper";
    rev = "db176d8aa5981a597bbae6a1a74aeebf0f376df4";
    sha256 = "sha256-A5QKqCo9TTdzmK13WRSAfkrkeUqHc4yQCzy4ZZ9uX2M=";
  };

  nativeBuildInputs = [
    copyDesktopItems
    godot3-headless
    unzip
  ];

  buildInputs = [
    # determine buildInputs vs runtimeDependencies
    #alsa-lib
    #gcc-unwrapped.lib
    #git
    #zlib
  ];

  runtimeDependencies = map lib.getLib [
    alsa-lib
    libGLU
    libX11
    libXcursor
    libXext
    libXfixes
    libXi
    libXinerama
    libXrandr
    libXrender
    libglvnd
    libpulseaudio
    udev
  ];

  buildPhase = ''
    runHook preBuild

    # Cannot create file '/homeless-shelter/.config/godot/projects/...'
    export HOME=$TMPDIR

    # Link the export-templates to the expected location. The --export commands
    # expects the template-file at .../templates/3.2.3.stable/linux_x11_64_release
    # with 3.2.3 being the version of godot.
    mkdir -p $HOME/.local/share/godot
    ln -s ${godot3-export-templates}/share/godot/templates $HOME/.local/share/godot

    mkdir -p $out/share/4d-minesweeper
    godot3-headless --export "${preset}" --path source $out/share/4d-minesweeper/4d-minesweeper

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/icons/hicolor/scalable/apps/
    install -Dm644 source/icon.svg $out/icons/hicolor/scalable/apps/

    mkdir -p $out/bin
    ln -s $out/share/4d-minesweeper/4d-minesweeper $out/bin

    # Patch binaries.
    interpreter=$(cat $NIX_CC/nix-support/dynamic-linker)
    patchelf \
      --set-interpreter $interpreter \
      --set-rpath ${lib.makeLibraryPath runtimeDependencies} \
      $out/bin/4d-minesweeper

    runHook postInstall
  '';

  # otherwise godot doesn't find runtimeDependencies
  dontFixup = true;

  # TODO: why is this done?
  #dontStrip = true;

  # TODO: determine failures in --verbose mode
  # XcursorGetTheme could not get cursor theme
  # Failed loading custom cursor: left_ptr
  # Failed loading custom cursor: xterm
  # Failed loading custom cursor: hand2
  # Failed loading custom cursor: cross
  # Failed loading custom cursor: watch
  # Failed loading custom cursor: left_ptr_watch
  # Failed loading custom cursor: fleur
  # Failed loading custom cursor: hand1
  # Failed loading custom cursor: X_cursor
  # Failed loading custom cursor: sb_v_double_arrow
  # Failed loading custom cursor: sb_h_double_arrow
  # Failed loading custom cursor: size_bdiag
  # Failed loading custom cursor: size_fdiag
  # Failed loading custom cursor: hand1
  # Failed loading custom cursor: sb_v_double_arrow
  # Failed loading custom cursor: sb_h_double_arrow
  # Failed loading custom cursor: question_arrow

  desktopItems = [
    (makeDesktopItem {
      name = "4D Minesweeper";
      exec = "4d-minesweeper";
      icon = "icon.svg";
      comment = meta.description;
      desktopName = "4D Minesweeper";
      genericName = "4D Minesweeper";
      categories = [ "Game" ];
    })
  ];

  meta = with lib; {
    homepage = "https://github.com/gapophustu/4D-Minesweeper";
    description = "A 4D Minesweeper game written in godot";
    license = licenses.mpl20;
    platforms   = [ "x86_64-linux" ];
    maintainers = with maintainers; [ merspieler ];
  };
}

{ lib
, stdenv
, rustPlatform
, fetchFromGitHub
, pkg-config
, glib
, cairo
, pango
, gdk-pixbuf
, atk
, gtk4
, Foundation
, wrapGAppsHook4
, gobject-introspection
, xvfb-run
, testers
, czkawka
, makeDesktopItem
}:

rustPlatform.buildRustPackage rec {
  pname = "czkawka";
  version = "6.1.0";

  src = fetchFromGitHub {
    owner = "qarmin";
    repo = "czkawka";
    rev = version;
    hash = "sha256-uKmiBNwuu3Eduf0v3p2VYYNf6mgxJTBUsYs+tKZQZys=";
  };

  cargoHash = "sha256-iBO99kpITVl7ySlXPkEg2YecS1lonVx9CbKt9WI180s=";

  desktopItem = makeDesktopItem {
    name = pname;
    exec = "${pname}_gui";
    icon = pname;
    desktopName = "Czkawka";
    comment = "A simple, fast and easy to use app to remove unnecessary files from your computer";
    categories  = [ "System" "FileTools" ];
  };

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook4
    gobject-introspection
  ];

  buildInputs = [
    glib
    cairo
    pango
    gdk-pixbuf
    atk
    gtk4
  ] ++ lib.optionals stdenv.hostPlatform.isDarwin [
    Foundation
  ];

  nativeCheckInputs = [
    xvfb-run
  ];

  postInstall = ''
    install -Dm444 ${desktopItem}/share/applications/czkawka.desktop $out/share/applications/com.github.qarmin.czkawka.desktop
    install -Dm444 data/icons/com.github.qarmin.czkawka.svg -t $out/share/icons/hicolor/scalable/apps
    install -Dm444 data/com.github.qarmin.czkawka.metainfo.xml -t $out/share/metainfo
  '';

  checkPhase = ''
    runHook preCheck
    xvfb-run cargo test
    runHook postCheck
  '';

  doCheck = stdenv.hostPlatform.isLinux
          && (stdenv.hostPlatform == stdenv.buildPlatform);

  passthru.tests.version = testers.testVersion {
    package = czkawka;
    command = "czkawka_cli --version";
  };

  meta = with lib; {
    changelog = "https://github.com/qarmin/czkawka/raw/${version}/Changelog.md";
    description = "A simple, fast and easy to use app to remove unnecessary files from your computer";
    homepage = "https://github.com/qarmin/czkawka";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ yanganto _0x4A6F ];
  };
}

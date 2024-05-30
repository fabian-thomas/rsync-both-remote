{ stdenv, lib, makeWrapper, coreutils, openssl, openssh, rsync }:

stdenv.mkDerivation {
  pname = "rsync-both-remote";
  version = "1.0";
  src = ./.;

  meta.mainProgram = "rsync-both-remote";

  phases = [ "installPhase" "fixupPhase" "postFixup" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/rsync-both-remote $out/bin/
  '';

  fixupPhase = ''
    patchShebangs --build $out/bin/rsync-both-remote
  '';

  buildInputs = [ makeWrapper ];
  postFixup = "wrapProgram $out/bin/rsync-both-remote --suffix PATH : ${lib.makeBinPath [coreutils openssl rsync]}";
}

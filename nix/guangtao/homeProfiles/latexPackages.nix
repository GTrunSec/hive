{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  home.packages = with nixpkgs; [
    (
      texlive.combine
      {
        inherit
          (texlive)
          collection-plaingeneric
          collection-latexextra
          collection-fontsrecommended
          collection-pictures
          collection-bibtexextra
          collection-mathscience
          collection-langgerman
          scheme-basic
          xetex
          cjk
          ctex
          xecjk
          dvipng
          fontspec
          euenc
          ;
      }
    )
  ];
}

{ emacsWithPackagesFromUsePackage, emacs-pgtk }:
emacsWithPackagesFromUsePackage {
  package = emacs-pgtk;
  config = ./config.org;
  defaultInitFile = true;
  alwaysEnsure = true;
  alwaysTangle = true;
  extraEmacsPackages =
    e: with e; [
      treesit-grammars.with-all-grammars
      nix-ts-mode
      doom-themes
      vertico
      orderless
      marginalia
      embark
      consult
      embark-consult
      consult-dir
      doom-modeline
      nerd-icons
      flycheck
      which-key
      lsp-mode
      lsp-ui
      treemacs
      lsp-treemacs
      consult-lsp
      treemacs-icons-dired
      treemacs-nerd-icons
      nerd-icons
      all-the-icons
    ];
  override = _: prev: { use-package = prev.emacs; };
}

{ pkgs, lib, ... }:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    ref = "nixos-25.05";
  });
in
{
  imports = [
    # For home-manager
    nixvim.homeModules.nixvim

    ./keymaps.nix
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;

    # clipboard.register = "unnamedplus";
    # clipboard.providers.xclip.enable = true; #I duuno man 
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      scrolloff = 8;
    };

    # colorschemes.onedark.enable = true;
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        dim_inactive = true;
      };
    };

  };
}

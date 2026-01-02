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
    clipboard.providers.wl-copy.enable = true;
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      scrolloff = 8;
      ignorecase = true;
      smartcase = true;
    };
    autoCmd = [
      {
        desc = "Saves view of file while leaving";
        command = "mkview";
        event = ["BufWinLeave"];
        pattern = ["?*"]; # ? is one of any, * is any of any. Both == requires a named buffer
      }
      {
        desc = "Loads view of the file";
        command = "silent! loadview";
        event = ["BufWinEnter"];
        pattern = ["?*"];
      }
    ];

    # colorschemes.onedark.enable = true;
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        dim_inactive = true;
      };
    };

  };
}

{ pkgs, ... }: 

{
  #home.file.".config/nvim".source = pkgs.fetchFromGitHub {
  #  #"owner" = "NvChad";
  #  #"repo" = "starter";
  #  #"rev" = "925399d90ca46163bf49ce97e153adb4f7a6c8b5";
  #  #"hash" = "sha256-WDJKltB4TI2a1N8RfTPGt27Ulw1OdwUwyRkD5WSXaP8=";
  #  "owner" = "NvChad";
  #  "repo" = "NvChad";
  #  "rev" = "478299d3455e22e375df468bba7cf9e2cadcc189";
  #  "hash" = "sha256-ism2CvyCl3SIdLRdKHXthGip1sH3PEUTEioHoFdfOJ0=";
  #};
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      mason-nvim
    ];
    extraConfig = ''
      set shiftwidth=2
      set tabstop=2
      set expandtab
    '';
  };
}

{pkgs,...}:
{
  home.packages = with pkgs; [
    citrix_workspace
    texliveFull
    sshfs
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "libsoup-2.74.3"
  ];
}

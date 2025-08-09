{ pkgs, ... }:

{
  home.file.".config/yakuakerc".text = ''
    [Desktop Entry]
    DefaultProfile=Profile 1.profile

    [Dialogs]
    FirstRun=false

    [Window]
    Height=75

    [Window]
    KeepOpen=false
  '';
}

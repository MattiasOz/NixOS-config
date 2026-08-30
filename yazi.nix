{pkgs, ...}:
let
  matsMotions = pkgs.runCommand "matsMotions" {} ''
    cp -r ${
      pkgs.fetchFromGitHub {
        owner = "dedukun";
        repo = "relative-motions.yazi";
        rev = "a603d9ea924dfc0610bcf9d3129e7cba605d4501";
        sha256 = "sha256-9i6x/VxGOA3bB3FPieB7mQ1zGaMK5wnMhYqsq4CvaM4=";
      }
    } $out

    substituteInPlace $out/main.lua --replace-fail "ya.mgr_emit" "ya.emit"
  '';
in
{
  programs.yazi = {
		enable = true;
		enableZshIntegration = true;
		shellWrapperName = "y";

		settings = {
			mgr = {
				show_hidden = false;
			};
			preview = {
				max_width = 1000;
				max_height = 1000;
			};
		};

		plugins = {
      # starship = pkgs.fetchFromGitHub {
      #   owner = "Rolv-Apneseth";
      #   repo = "starship.yazi";
      #   rev = "6a0f3f788971b155cbc7cec47f6f11aebbc148c9";
      #   hash = "sha256-q1G0Y4JAuAv8+zckImzbRvozVn489qiYVGFQbdCxC98=";
      # };
			# relative-motions = pkgs.fetchFromGitHub {
			# 	owner = "dedukun";
			# 	repo = "relative-motions.yazi";
			# 	rev = "ce2e890227269cc15cdc71d23b35a58fae6d2c27";
			# 	sha256 ="sha256-Ijz1wYt+L+24Fb/rzHcDR8JBv84z2UxdCIPqTdzbD14=";
			# };
      relative-motions = matsMotions;
			# relative-motions = pkgs.fetchFromGitHub {
			# 	owner = "dedukun";
			# 	repo = "relative-motions.yazi";
			# 	rev = "a603d9ea924dfc0610bcf9d3129e7cba605d4501";
			# 	sha256 ="sha256-9i6x/VxGOA3bB3FPieB7mQ1zGaMK5wnMhYqsq4CvaM4=";
			# };
		};

		initLua = ''
require("relative-motions"):setup({ show_numbers="relative_absolute", show_motion = true, enter_mode ="first" });
		'';

		keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "1" ];
          run = "plugin relative-motions 1";
          desc = "Move in relative steps";
        }{
          on = [ "2" ];
          run = "plugin relative-motions 2";
          desc = "Move in relative steps";
        }{
          on = [ "3" ];
          run = "plugin relative-motions 3";
          desc = "Move in relative steps";
        }{
          on = [ "4" ];
          run = "plugin relative-motions 4";
          desc = "Move in relative steps";
        }{
          on = [ "5" ];
          run = "plugin relative-motions 5";
          desc = "Move in relative steps";
        }{
          on = [ "6" ];
          run = "plugin relative-motions 6";
          desc = "Move in relative steps";
        }{
          on = [ "7" ];
          run = "plugin relative-motions 7";
          desc = "Move in relative steps";
        }{
          on = [ "8" ];
          run = "plugin relative-motions 8";
          desc = "Move in relative steps";
        }{
          on = [ "9" ];
          run = "plugin relative-motions 9";
          desc = "Move in relative steps";
        }
			];
		};
	};
}

{pkgs,...}:
{
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     wayle = prev.wayle.overrideAttrs (old: rec {
  #       version = "0.6.0";
  #
  #       src = prev.fetchFromGitHub {
  #         owner = "wayle-rs";
  #         repo = "wayle";
  #         rev = "v${version}";
  #         hash = "sha256-AOHehdowgxEV1b+CwrAhJsUqxQnARIGZPWMRcdH0h+U=";
  #       };
  #       # cargoHash = "sha256-4PUXJwUP5h/ggZQbY78BdqMh5oZes1XCeWuT2/S94Z4=";
  #       cargoDeps = prev.rustPlatform.fetchCargoVendor {
  #         inherit src;
  #         hash = "sha256-4PUXJwUP5h/ggZQbY78BdqMh5oZes1XCeWuT2/S94Z4=";
  #       };
  #     });
  #   })
  # ];
  services.wayle = {
    enable = true;
    settings = {
      styling = {
        scale = 0.6;
      };
      wallpaper = {
        engine-enabled = false;
      };
      bar = {
        scale = 0.6;
        location = "top";
        layout = [
          {
            monitor = "*";
            left = [
              "dashboard"
              "custom-sunsetr"
            ];
            center = [
              "hyprland-workspaces"
            ];
            right = [
              "systray"
              "volume"
              "network"
              "bluetooth"
              { module = "custom-batteryWatt"; class = "batteryWatt";}
              "clock"
            ];
          }
        ];
      };
      modules = {
        clock = {
          format = "%H:%M";
          dropdown-show-seconds = true;
          icon-show = false;
        };
        bluetooth = {
          label-show = false;
        };
        hyprland-workspaces = {
          app-icons-show = true;
          border-show = true;
        };
        network = {
          label-show = false;
        };
        systray = {
          icon-scale = 1.5;
          item-gap = 0.75;
        };
        volume = {
          label-show = false;
        };
        weather = {
          location = "Luleå";
          time-format = "24h";
        };
        custom = [
          {
            id = "sunsetr";
            command = ''
              sunStatus=$(sunsetr status)
              alt=""
              if [[ $sunStatus == *"ERROR"* ]]; then 
                alt="Error";
              elif [[ $sunStatus == *"Night"* ]]; then
                alt="Night";
              elif [[ $sunStatus == *"Day"* ]]; then
                alt="Day";
              else
                alt="Sunset";
              fi
              printf "{\"alt\":\"%s\"}\n" $alt
            '';
            left-click = ''
              if [[ $(sunsetr status) == *"ERROR"* ]]; then 
                sunsetr --background
              else
                sunsetr stop
              fi
            '';
            label-show = false;
            icon-name = "md-battery_android_frame_1-symbolic";
            icon-map = { 
              Night = "ld-moon-symbolic"; 
              Day = "ld-sun-symbolic"; 
              Error = "ld-eye-off-symbolic"; 
              Sunset = "ld-sun-moon-symbolic";
            };
          }
          {
            id = "batteryWatt";
            command = ''
              percentage=$(cat /sys/class/power_supply/BAT1/capacity)
              watt=$(($(cat /sys/class/power_supply/BAT1/power_now) / 1000000)) 
              alt=$(cat /sys/class/power_supply/BAT1/status)
              [ "$alt" = "Discharging" ] && watt="-$watt"
              [ "$percentage" -le 20 ] && alt="Critical"
              [ "$alt" = "Not charging" ] && alt="Charging" #two words confuse it
              class=$alt
              [ "$watt" -le -20 ] && class="Critical"
              printf "{\"percentage\":%s, \"alt\":\"%s\", \"watt\":%s, \"class\":\"%s\"}\n" $percentage $alt $watt $class
            '';
            interval_ms = 2000;
            # icon-name = "ld-zap-symbolic";
            icon-names = [
              "md-battery_android_0-symbolic"
              "md-battery_android_frame_1-symbolic"
              "md-battery_android_frame_2-symbolic"
              "md-battery_android_frame_3-symbolic"
              "md-battery_android_frame_4-symbolic"
              "md-battery_android_frame_5-symbolic"
              "md-battery_android_frame_6-symbolic"
              "md-battery_android_frame_full-symbolic"
            ];
            icon-map = { Critical = "md-battery_android_alert-symbolic"; Charging = "md-battery_android_frame_bolt-symbolic"; };
            icon-show = false;
            format = "{{ percentage }}% {{ watt }} W";
            left-click = "dropdown:battery";
            # class-format = "what even is this {{alt}}";
          }
        ];
      };
    };
  };
  xdg.configFile."wayle/styles/index.scss".text = ''
    @import "custom";
  '';
}

{
  pkgs,
  lib,
  ...
}: let
  scriptsDir = ./scripts;
  scripts = builtins.attrNames (builtins.readDir scriptsDir);

  fireColors = {
    red = "#ff4500";
    orange = "#ff8c00";
    yellow = "#ffd700";
    bg = "rgba(10, 10, 10, 0.3)";
  };
in {
  home.file = builtins.listToAttrs (
    map (name: {
      name = ".config/waybar/scripts/" + name;
      value = {
        source = "${scriptsDir}/${name}";
        executable = true;
      };
    })
    scripts
  );

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;

    settings = [
      {
        layer = "top";
        position = "top";
        height = 34;
        margin-top = 8;
        margin-left = 12;
        margin-right = 12;
        spacing = 0;

        modules-left = [
          "custom/nixos"
          "hyprland/workspaces"
          "cpu"
          "memory"
          "custom/gpu"
        ];

        modules-center = ["clock"];

        modules-right = [
          "pulseaudio"
          "backlight"
          "battery"
          "temperature"
          "tray"
          "custom/swaync"
          "custom/power"
        ];

        "custom/nixos" = {
          format = "󱄅";
          on-click = "fuzzel";
          tooltip = false;
        };

        cpu = {
          format = " {usage}%";
          interval = 2;
        };
        memory = {
          format = " {used:0.1f}G";
          interval = 2;
        };

        "custom/gpu" = {
          exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
          format = "󰾲 {}%";
          interval = 2;
        };

        clock = {
          timezone = "Europe/Belgrade";
          format = "󰥔 {:%H:%M}";
          format-alt = "󰃭 {:%d.%m.%Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        tray = {
          icon-size = 15;
          spacing = 10;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          on-click = "pavucontrol";
          format-icons.default = ["󰕿" "󰖀" "󰕾"];
        };

        backlight = {format = "󰃠 {percent}%";};
        battery = {
          format = "{icon} {capacity}%";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        temperature = {format = " {temperatureC}°C";};

        "custom/swaync" = {
          format = "󰂚";
          on-click = "swaync-client -t -sw";
          tooltip = false;
        };

        "custom/power" = {
          format = "⏻";
          on-click = "wlogout";
          tooltip = false;
        };
      }
    ];

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: rgba(15, 15, 15, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 17px;
        color: #ffffff;
      }

      #waybar > box {
        padding: 2px 10px;
      }

      #workspaces button,
      #custom-nixos,
      #clock,
      #pulseaudio,
      #custom-swaync,
      #custom-power,
      #tray {
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.03) 100%);
        border: 1px solid rgba(255, 255, 255, 0.12);
        color: #ffffff;
        padding: 0 14px;
        margin: 4px 4px;
        border-radius: 12px;
        transition: all 0.3s ease;
      }

      /* Заменяем transform на margin-bottom для эффекта приподнимания */
      #workspaces button:hover,
      #custom-nixos:hover,
      #clock:hover,
      #pulseaudio:hover,
      #custom-swaync:hover,
      #custom-power:hover {
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.2) 0%, rgba(255, 255, 255, 0.08) 100%);
        border-color: rgba(255, 140, 0, 0.4);
        margin-bottom: 5px;
        margin-top: 3px;
      }

      #workspaces button.active {
        background: linear-gradient(135deg, rgba(255, 140, 0, 0.3) 0%, rgba(255, 69, 0, 0.2) 100%);
        border-color: rgba(255, 215, 0, 0.5);
        padding: 0 20px;
      }

      #workspaces button.urgent {
        background-color: #eb4d4b;
      }

      #cpu, #memory, #custom-gpu, #backlight, #battery, #temperature {
        padding: 0 8px;
        margin: 4px 0;
        color: rgba(255, 255, 255, 0.9);
      }

      tooltip {
        background: rgba(15, 15, 15, 0.9);
        border: 1px solid rgba(255, 140, 0, 0.3);
        border-radius: 12px;
      }
    '';
  };
}

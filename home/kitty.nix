{ ... }:
{
  programs.kitty = {
    enable = true;

    environment = {
      "LS_COLORS" = "1";
    };

    font = {
      name = "JetbrainsMono Nerd Font";
      size = 9;
    };

    settings = {
      # Window
      hide_window_decorations = "yew";
      dynamic_background_opacity = "yes";

      # Tabs
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_bar_style = "separator";
      tab_separator = " | ";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

      # colors
      active_tab_foreground = "#FFFFFF";
      active_tab_background = "#FC0B5A";
      inactive_tab_foreground = "#EE5396";
      inactive_tab_background = "#1A1C31";
      tab_bar_background = "#0F0F1C";

      foreground = "#FFFFFF";
      background = "#161616";
      selection_foreground = "#000000";
      selection_background = "#DDE1E6";
      url_color = "#FC0B5A";
      cursor = "#6F6F6F";

      color0 = "#262626";
      color1 = "#EE5396";
      color2 = "#42BE65";
      color3 = "#FFE97B";
      color4 = "#33B1FF";
      color5 = "#FF7EB6";
      color6 = "#3DDBD9";
      color7 = "#DDE1E6";
      color8 = "#393939";
      color9 = "#EE5396";
      color10 = "#42BE65";
      color11 = "#FFE97B";
      color12 = "#33B1FF";
      color13 = "#FF7EB6";
      color14 = "#3DDBD9";
      color15 = "#FFFFFF";

      # Other
      initial_window_width = 820;
      initial_window_height = 460;
      remember_window_size = "no";

      window_padding_width = 5;

      # Aaaaaaaaaaaaaaaah the bell
      enable_audio_bell = false;
    };
  };
}

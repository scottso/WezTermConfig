local wezterm = require("wezterm")

local function use_dark()
  return wezterm.gui.get_appearance():match("Dark.*")
end

return {
  default_prog = { "/opt/homebrew/bin/fish", "-l" },
  font = wezterm.font_with_fallback({ "MonoLisa Fancy", "Symbols Nerd Font Mono" }),
  font_size = 13.0,
  color_scheme_dirs = { "~/.config/wezterm/colors" },
  -- First theme after the function is the dark theme
  color_scheme = use_dark() and "melange_dark" or "melange_light",
  freetype_load_target = "Light",
  adjust_window_size_when_changing_font_size = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  audible_bell = "Disabled",
}

local wezterm = require("wezterm")

-- Function to switch wetween light and dark theme
-- following macOS light and dark mode
local function use_dark()
  return wezterm.gui.get_appearance():match("Dark.*")
end

return {
  -- Font configuration with fallback font that contains icons etc.
  font = wezterm.font_with_fallback({ "MonoLisa Fancy", "Symbols Nerd Font Mono" }),
  font_size = 13.0,
  --
  -- Adding some themes that are not part of the built in themes of wezterm
  color_scheme_dirs = { "~/.config/wezterm/colors" },
  -- First theme after the function is the dark theme
  color_scheme = use_dark() and "melange_dark" or "melange_light",
  --
  -- Hinting algorithm of freetype rasterizer
  freetype_load_target = "Light", -- Light is good for macOS, default is 'Normal'
  --
  -- Window decoration
  window_decorations = "RESIZE", -- "NONE", "TITLE", "RESIZE", "TITLE | RESIZE"
  --
  -- Dont resize window when resizing font
  adjust_window_size_when_changing_font_size = false,
  --
  -- Tab bar settings
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  --
  -- Setting up TERM
  -- set_environment_variables = {
  --   TERMINFO_DIRS = "~/.terminfo",
  --   WSLENV = "TERMINFO_DIRS",
  -- },
  -- term = "wezterm",
  --
}

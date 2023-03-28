local wezterm = require("wezterm")

-- Function to switch wetween light and dark theme
-- following macOS light and dark mode
local function use_dark()
  return wezterm.gui.get_appearance():match("Dark.*")
end

return {
  font = wezterm.font_with_fallback({ "MonoLisa Fancy", "Symbols Nerd Font Mono" }),
  font_size = 14.0,
  -- Adding some themes that are not part of the built in themes of wezterm
  color_scheme_dirs = { "~/.config/wezterm/colors" },
  -- First theme after the function is the dark theme
  color_scheme = use_dark() and "melange_dark" or "melange_light",
  -- Tab bar settings
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
}

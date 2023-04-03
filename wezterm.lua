local wezterm = require("wezterm")

-- https://wezfurlong.org/wezterm/colorschemes/index.html
local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "nightfox"
  else
    return "dayfox"
  end
end

return {
  font = wezterm.font_with_fallback({ "MonoLisa Fancy", "Symbols Nerd Font Mono" }),
  font_size = 13.0,
  color_scheme_dirs = { "~/.config/wezterm/colors" },
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  freetype_load_target = "Light",
  adjust_window_size_when_changing_font_size = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  audible_bell = "Disabled",
}

local wezterm = require("wezterm")

-- https://wezfurlong.org/wezterm/colorschemes/index.html
local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    -- Dark theme
    return "nightfox"
  else
    -- Light theme
    return "dayfox"
  end
end

return {
  front_end = "WebGpu", -- Render with Metal on macOS
  freetype_load_target = "Light",
  color_scheme_dirs = { "~/.config/wezterm/colors" },
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  font = wezterm.font_with_fallback({
    { family = "MonoLisa Fancy" },
    { family = "Symbols Nerd Font Mono", scale = 0.8 },
  }),
  font_size = 13.0,
  initial_rows = 40,
  initial_cols = 110,
  scrollback_lines = 5000,
  adjust_window_size_when_changing_font_size = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  audible_bell = "Disabled",
  -- Tab bar configuration
  window_frame = {
    font = wezterm.font({ family = "MonoLisa Fancy", weight = "Light" }),
    font_size = 11.0,
  },
}

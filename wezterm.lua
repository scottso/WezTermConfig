local wezterm = require("wezterm")

-- https://wezfurlong.org/wezterm/colorschemes/index.html
local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    -- Dark theme
    return "melange_dark"
  else
    -- Light theme
    return "melange_light"
  end
end

return {
  front_end = "WebGpu", -- Render with Metal on macOS
  freetype_load_target = "Light",
  color_scheme_dirs = { "~/.config/wezterm/colors" },
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  font = wezterm.font_with_fallback({
    "MonoLisa Fancy",
    "Symbols Nerd Font Mono",
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
    font = wezterm.font({ family = "MonoLisa Fancy", weight = "Medium" }),
    font_size = 10.0,
  },
}

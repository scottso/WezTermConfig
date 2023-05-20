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
  harfbuzz_features = {
    "cv01=0", -- a variations
    "cv02=1", -- g variations
    "zero=1", -- 0 variations
    "cv14=1", -- 3 varioations
    "onum=0", -- 1234567890 raised thousand separators
    "ss05=0", -- @ variations
    "ss04=1", -- $ variations
    "cv18=1", -- % variations
    "ss03=1", -- & variations
    "cv31=1", -- () variations
    "cv29=0", -- {} variations
    "ss08=0", -- != ===
    "cv24=0", -- /=
    "ss09=1", -- >>=
    "cv25=1", -- .-
    "cv26=1", -- :-
    "cv32=1", -- .=
    "cv27=1", -- []
    "cv28=1", -- {. .}
    "ss07=1", -- =~ !~
  },
  font = wezterm.font_with_fallback({
    {
      family = "Fira Code",
      weight = "Regular",
    },
    {
      -- Fallback font with all the Netd Font Symbols
      family = "Symbols Nerd Font Mono",
      scale = 0.9,
    },
  }),
  font_size = 14.0,
  initial_rows = 32,
  initial_cols = 88,
  scrollback_lines = 5000,
  adjust_window_size_when_changing_font_size = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  audible_bell = "Disabled",
  -- Tab bar configuration
  window_frame = {
    font = wezterm.font({ family = "Fira Code", weight = "Light" }),
    font_size = 12.0,
  },
}

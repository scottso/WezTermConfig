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
    "calt=1", -- https://docs.microsoft.com/en-us/typography/opentype/spec/features_ae#tag-calt
    "clig=1", -- https://docs.microsoft.com/en-us/typography/opentype/spec/features_ae#tag-clig
    "liga=1", -- Ligatures
    "zero=0", -- 0 with slash or dot
    "ss01=0", -- * Asterisk normal or raised
    "ss02=0", -- Script variant of font
    "ss06=0", -- @ variants
    "ss07=1", -- {} variations
    "ss08=1", -- () variations
    "ss09=1", -- >= 2 sharacters wide or not
    "ss10=0", -- >= Alternate appearance for 1 char width
    "ss11=1", -- 0xF Alternate hex appearance
    "ss12=0", -- \\ Thin backslash (ruins ASCII art)
  },
  font = wezterm.font_with_fallback({
    {
      family = "MonoLisa",
      weight = "Medium",
    },
    {
      -- Fallback font with all the Netd Font Symbols
      family = "Symbols Nerd Font Mono",
      scale = 0.8,
    },
  }),
  font_size = 13.0,
  initial_rows = 32,
  initial_cols = 88,
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

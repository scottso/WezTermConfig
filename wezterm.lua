local wezterm = require("wezterm")

-- https://wezfurlong.org/wezterm/colorschemes/index.html
local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    -- Dark theme
    return "OneDark (base16)"
  else
    -- Light theme
    return "One Light (base16)"
  end
end

local function tab_bar_style_for_appearance(appearance)
  if appearance:find("Dark") then
    -- Dark theme settings
    return {
      window_frame = {
        font = wezterm.font { family = 'MonoLisa Variable', weight = 'Thin' },
        font_size = 10.0,
        inactive_titlebar_bg = '#353535',
        active_titlebar_bg = '#2b2042',
        inactive_titlebar_fg = '#cccccc',
        active_titlebar_fg = '#ffffff',
        inactive_titlebar_border_bottom = '#2b2042',
        active_titlebar_border_bottom = '#2b2042',
        button_fg = '#cccccc',
        button_bg = '#2b2042',
        button_hover_fg = '#ffffff',
        button_hover_bg = '#3b3052',
      },
      colors = {
        tab_bar = {
          inactive_tab_edge = '#2986cc', -- Example dark theme inactive tab edge color
        },
      },
    }
  else
    -- Light theme settings
    return {
      window_frame = {
        font = wezterm.font { family = 'MonoLisa Variable', weight = 'Thin' },
        font_size = 10.0,
        inactive_titlebar_bg = '#E0E0E0',            -- Adjust these for light theme
        active_titlebar_bg = '#FFFFFF',              -- Adjust these for light theme
        inactive_titlebar_fg = '#000000',            -- Adjust these for light theme
        active_titlebar_fg = '#000000',              -- Adjust these for light theme
        inactive_titlebar_border_bottom = '#D0D0D0', -- Adjust these for light theme
        active_titlebar_border_bottom = '#D0D0D0',   -- Adjust these for light theme
        button_fg = '#000000',                       -- Adjust these for light theme
        button_bg = '#F0F0F0',                       -- Adjust these for light theme
        button_hover_fg = '#000000',                 -- Adjust these for light theme
        button_hover_bg = '#C0C0C0',                 -- Adjust these for light theme
      },
      colors = {
        tab_bar = {
          inactive_tab_edge = '#A0A0A0', -- Example light theme inactive tab edge color
        },
      },
    }
  end
end



local tab_bar_config = tab_bar_style_for_appearance(wezterm.gui.get_appearance())

return {
  front_end = "WebGpu", -- Render with Metal on macOS
  freetype_load_target = "Light",
  color_scheme_dirs = { "~/.config/wezterm/colors" },
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  -- All of the MonoLisa features are documented on the download page of https://www.monolisa.dev
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
    "ss11=1", -- 0xF Alternate hex appearance
  },
  font = wezterm.font_with_fallback({
    {
      family = "MonoLisa Variable",
      weight = "Regular",
    },
    {
      -- Fallback font with all the Netd Font Symbols
      family = "Symbols Nerd Font Mono",
      scale = 0.9,
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
    font = wezterm.font({ family = "MonoLisa", weight = "Light" }),
    font_size = 11.0,
  },
}

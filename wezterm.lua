local wezterm = require("wezterm")
local config = {}
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
    -- OneDark (base16) theme tab bar style
    return {
      active_titlebar_bg = '#282C34', -- Darker background
      inactive_titlebar_bg = '#282C34',
      inactive_tab_edge = '#ABB2BF',  -- Greyish color
      active_tab = {
        bg_color = '#61AFEF',         -- Blue color for active tab background
        fg_color = '#282C34',         -- Dark text for active tab
      },
      inactive_tab = {
        bg_color = '#3E4451', -- Dark grey for inactive tab background
        fg_color = '#ABB2BF', -- Lighter grey text for inactive tab
      },
    }
  else
    -- One Light (base16) theme tab bar style
    return {
      active_titlebar_bg = '#FAFAFA', -- Light background
      inactive_titlebar_bg = '#FAFAFA',
      inactive_tab_edge = '#D3D3D3',  -- Light grey
      active_tab = {
        bg_color = '#E06C75',         -- Red color for active tab background
        fg_color = '#FAFAFA',         -- White text for active tab
      },
      inactive_tab = {
        bg_color = '#E5E5E6', -- Very light grey for inactive tab background
        fg_color = '#383A42', -- Dark grey text for inactive tab
      },
    }
  end
end

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.front_end = "WebGpu" -- Render with Metal on macOS
config.freetype_load_target = "Light"
config.color_scheme_dirs = { "~/.config/wezterm/colors" }

local appearance = wezterm.gui.get_appearance()
config.color_scheme = scheme_for_appearance(appearance)
local tab_style = tab_bar_style_for_appearance(appearance)

config.window_frame = {
  font = wezterm.font { family = 'MonoLisa Variable', weight = 'Thin' },
  font_size = 11.0,
  active_titlebar_bg = tab_style.active_titlebar_bg,
  inactive_titlebar_bg = tab_style.inactive_titlebar_bg,
}

config.colors = {
  tab_bar = {
    inactive_tab_edge = tab_style.inactive_tab_edge,
  },
}

-- All of the MonoLisa features are documented on the download page of https://www.monolisa.dev
config.harfbuzz_features = {
  "calt=1", -- https://docs.microsoft.com/en-us/typography/opentype/spec/features_ae#tag-calt
  "clig=1", -- https://docs.microsoft.com/en-us/typography/opentype/spec/features_ae#tag-clig
  "liga=1", -- Ligatures
  "zero=0", -- 0 with slash or dot
  "ss01=0", -- Asterisk normal or raised
  "ss02=0", -- Script variant of font
  "ss06=0", -- @ variants
  "ss07=1", -- {} variations
  "ss08=1", -- () variations
  "ss09=1", -- >= 2 sharacters wide or not
  "ss11=1", -- 0xF Alternate hex appearance
}

config.font = wezterm.font_with_fallback({
  { family = "MonoLisa Variable",      scale = 1.0, weight = "Regular" },
  { family = "Symbols Nerd Font Mono", scale = 0.9, weight = "Regular" },
})

config.font_size = 13.0
config.initial_rows = 32
config.initial_cols = 88
config.scrollback_lines = 5000
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.audible_bell = "Disabled"
config.window_close_confirmation = "AlwaysPrompt"
config.window_background_opacity = 1 -- Range is 0.0 - 1
config.window_decorations = "RESIZE" -- TITLE | RESIZE

return config

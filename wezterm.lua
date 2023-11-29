-- Importing the wezterm module
local wezterm = require("wezterm")

-- Function to set the color scheme based on the appearance (dark or light)
local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    -- Returns OneDark (base16) theme for dark appearance
    return "OneDark (base16)"
  else
    -- Returns One Light (base16) theme for light appearance
    return "One Light (base16)"
  end
end

-- Function to set the tab bar style based on the appearance (dark or light)
local function tab_bar_style_for_appearance(appearance)
  if appearance:find("Dark") then
    -- Tab bar style for OneDark (base16) theme
    return {
      -- Tab bar colors and styles for dark theme
      active_titlebar_bg = '#282C34',
      inactive_titlebar_bg = '#282C34',
      inactive_tab_edge = '#ABB2BF',
      active_tab = {
        bg_color = '#61AFEF',
        fg_color = '#282C34',
      },
      inactive_tab = {
        bg_color = '#3E4451',
        fg_color = '#ABB2BF',
      },
    }
  else
    -- Tab bar style for One Light (base16) theme
    return {
      -- Tab bar colors and styles for light theme
      active_titlebar_bg = '#FAFAFA',
      inactive_titlebar_bg = '#FAFAFA',
      inactive_tab_edge = '#D3D3D3',
      active_tab = {
        bg_color = '#E06C75',
        fg_color = '#FAFAFA',
      },
      inactive_tab = {
        bg_color = '#E5E5E6',
        fg_color = '#383A42',
      },
    }
  end
end

local config = {}

-- Conditional config builder
if wezterm.config_builder then
  config = wezterm.config_builder()
end


-- Front-end renderer configuration
config.front_end = "WebGpu" -- Use WebGpu for rendering
config.freetype_load_target = "Light"
config.color_scheme_dirs = { "~/.config/wezterm/colors" }

-- Detect current appearance and apply the corresponding color scheme and tab style
local appearance = wezterm.gui.get_appearance()
config.color_scheme = scheme_for_appearance(appearance)
local tab_style = tab_bar_style_for_appearance(appearance)

-- Window frame configuration
config.window_frame = {
  font = wezterm.font { family = 'MonoLisa Variable', weight = 'Thin' },
  font_size = 11.0,
  active_titlebar_bg = tab_style.active_titlebar_bg,
  inactive_titlebar_bg = tab_style.inactive_titlebar_bg,
}

-- Tab bar color configuration
config.colors = {
  tab_bar = {
    inactive_tab_edge = tab_style.inactive_tab_edge,
    active_tab = {
      bg_color = tab_style.active_tab.bg_color,
      fg_color = tab_style.active_tab.fg_color
    },
    inactive_tab = {
      fg_color = tab_style.inactive_tab.fg_color,
      bg_color = tab_style.inactive_tab.bg_color
    },
  },
}

-- Font features configuration
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

-- Main font configuration with fallback
config.font = wezterm.font_with_fallback({
  { family = "MonoLisa Variable",      scale = 1.0, weight = "Regular" },
  { family = "Symbols Nerd Font Mono", scale = 0.9, weight = "Regular" },
})

-- General configuration settings
config.font_size = 13.0
config.initial_rows = 32
config.initial_cols = 88
config.scrollback_lines = 5000
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.audible_bell = "Disabled"
config.window_close_confirmation = "AlwaysPrompt"
config.window_background_opacity = 1 -- Full opacity
config.window_decorations = "RESIZE" -- Enable window resizing
config.use_fancy_tab_bar = true

-- Return the final configuration
return config

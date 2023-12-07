-- Importing the wezterm module
local wezterm = require("wezterm")

-- Function to set the color scheme based on the appearance (dark or light)
local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    -- Dark theme
    return "nightfox"
  else
    -- Light theme
    return "dayfox"
  end
end

-- Function to set the tab bar style based on the appearance (dark or light)
local function tab_bar_style_for_appearance(appearance)
  if appearance:find("Dark") then
    -- Tab bar style for dark theme
    return {
      active_titlebar_bg = "#131a24",
      inactive_titlebar_bg = "#131a24",
      inactive_tab_edge = "#131a24",
      active_tab = {
        bg_color = "#71839b",
        fg_color = "#192330",
      },
      inactive_tab = {
        bg_color = "#212e3f",
        fg_color = "#aeafb0",
      },
      inactive_tab_hover = {
        bg_color = "#29394f",
        fg_color = "#cdcecf",
      },
      new_tab = {
        bg_color = "#192330",
        fg_color = "#aeafb0",
      },
      new_tab_hover = {
        bg_color = "#29394f",
        fg_color = "#cdcecf",
      },
    }
  else
    -- Tab bar style for light theme
    return {
      active_titlebar_bg = "#e4dcd4",
      inactive_titlebar_bg = "#e4dcd4",
      inactive_tab_edge = "#e4dcd4",
      active_tab = {
        bg_color = "#824d5b",
        fg_color = "#f6f2ee",
      },
      inactive_tab = {
        bg_color = "#dbd1dd",
        fg_color = "#643f61",
      },
      inactive_tab_hover = {
        bg_color = "#d3c7bb",
        fg_color = "#3d2b5a",
      },
      new_tab = {
        bg_color = "#f6f2ee",
        fg_color = "#643f61",
      },
      new_tab_hover = {
        bg_color = "#d3c7bb",
        fg_color = "#3d2b5a",
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
  font = wezterm.font({ family = "MonoLisa Variable", weight = "Black" }),
  font_size = 10.0,
  active_titlebar_bg = tab_style.active_titlebar_bg,
  inactive_titlebar_bg = tab_style.inactive_titlebar_bg,
}

-- Tab bar color configuration
config.colors = {
  tab_bar = {
    inactive_tab_edge = tab_style.inactive_tab_edge,
    active_tab = {
      bg_color = tab_style.active_tab.bg_color,
      fg_color = tab_style.active_tab.fg_color,
    },
    inactive_tab = {
      fg_color = tab_style.inactive_tab.fg_color,
      bg_color = tab_style.inactive_tab.bg_color,
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
  { family = "MonoLisa Variable", scale = 1.0, weight = "Regular" },
  { family = "Symbols Nerd Font Mono", scale = 0.9, weight = "Regular" },
})

-- General configuration settings
config.font_size = 14.0
config.initial_rows = 42
config.initial_cols = 100
config.scrollback_lines = 5000
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.audible_bell = "Disabled"
config.window_close_confirmation = "AlwaysPrompt"
config.window_background_opacity = 1 -- Full opacity
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = true
config.term = "wezterm"

-- Moving tabs
config.keys = {}
for i = 1, 8 do
  -- CTRL+ALT + number to move to that position
  table.insert(config.keys, {
    key = tostring(i),
    mods = "CTRL|ALT",
    action = wezterm.action.MoveTab(i - 1),
  })
end

-- Return the final configuration
return config

-- Importing the wezterm module
local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("links").setup(config)

-- Function to set the color scheme based on the appearance (dark or light)
local function scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        -- Dark theme
        return "tokyonight_moon"
    else
        -- Light theme
        return "tokyonight-day"
    end
end

-- Function to set the tab bar style based on the appearance (dark or light)
local function tab_bar_style_for_appearance(appearance)
    if appearance:find("Dark") then
        -- Tab bar style for tokyonight_moon (dark theme)
        return {
            active_titlebar_bg = "#222436",   -- Dark scheme background
            inactive_titlebar_bg = "#222436", -- Same as active for consistency
            inactive_tab_edge = "#1e2030",    -- Dark scheme inactive_tab_edge
            active_tab = {
                bg_color = "#82aaff",         -- Dark scheme active_tab bg_color
                fg_color = "#1e2030",         -- Dark scheme active_tab fg_color
            },
            inactive_tab = {
                bg_color = "#2f334d", -- Dark scheme inactive_tab bg_color
                fg_color = "#545c7e", -- Dark scheme inactive_tab fg_color
            },
        }
    else
        -- Tab bar style for tokyonight_day (light theme)
        return {
            active_titlebar_bg = "#e1e2e7",   -- Light scheme background
            inactive_titlebar_bg = "#e1e2e7", -- Same as active for consistency
            inactive_tab_edge = "#e9e9ec",    -- Light scheme inactive_tab_edge
            active_tab = {
                bg_color = "#2e7de9",         -- Light scheme active_tab bg_color
                fg_color = "#e9e9ec",         -- Light scheme active_tab fg_color
            },
            inactive_tab = {
                bg_color = "#c4c8da", -- Light scheme inactive_tab bg_color
                fg_color = "#8990b3", -- Light scheme inactive_tab fg_color
            },
        }
    end
end

-- Front-end renderer configuration
config.front_end = "WebGpu" -- Use WebGpu for rendering
config.webgpu_power_preference = "HighPerformance"
config.freetype_load_target = "Light"

-- Detect current appearance and apply the corresponding color scheme and tab style
config.color_scheme_dirs = { "~/git/tokyonight.nvim/extras/wezterm" }
local appearance = wezterm.gui.get_appearance()
config.color_scheme = scheme_for_appearance(appearance)
local tab_style = tab_bar_style_for_appearance(appearance)

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
-- Window frame configuration
config.window_frame = {
    font = wezterm.font({ family = "MonoLisa Variable", weight = "Regular" }),
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

-- Use different font for cursive lettering
config.font_rules = {
    {
        intensity = 'Bold',
        italic = true,
        font = wezterm.font {
            family = 'Monaspace Radon Var',
            weight = 'Bold',
            style = 'Italic',
        },
    },
    {
        italic = true,
        intensity = 'Half',
        font = wezterm.font {
            family = 'Monaspace Radon Var',
            weight = 'DemiBold',
            style = 'Italic',
        },
    },
    {
        italic = true,
        intensity = 'Normal',
        font = wezterm.font {
            family = 'Monaspace Radon Var',
            style = 'Italic',
        },
    },
}

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
config.underline_thickness = 2
config.underline_position = -6
config.bold_brightens_ansi_colors = true
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = false
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_thickness = 3
config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }

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

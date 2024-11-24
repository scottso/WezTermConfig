-- Importing the wezterm module
local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("fullscreen")

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup()
tabline.apply_to_config(config)

require("links").setup(config)

config.font = wezterm.font_with_fallback({
    {
        family = "MonoLisa Uncursive",
        weight = "Regular",
        harfbuzz_features = {
            "calt",
            "clig",
            -- "ss02", -- cursive for italics
            "ss03",
            "ss11",
            "ss17",
            "zero",
        },
    },
    {
        family = "Berkeley Mono Variable",
        weight = "Regular",
        harfbuzz_features = {
            "calt",
            "clig",
            -- "ss01", -- normal zero
            -- "ss02", -- dotted zero
            "ss03", -- slashed zero
            -- "ss04", -- broken slashed zero
            -- "ss05", -- normal seven
            -- "ss06", -- crossed sevens
            -- "ss07",
            "ss08",
        },
    },
    {
        family = "JetBrains Mono",
        weight = "Regular",
        -- https://github.com/JetBrains/JetBrainsMono/wiki/OpenType-features
        harfbuzz_features = {
            "calt",
            "clig",
            "liga",
            "zero",
            "ss20",
            "cv02",
            "cv03",
            "cv04",
            "cv05",
            "cv06",
            "cv07",
            "cv11",
            "cv14",
            "cv15",
            "cv16",
            "cv17",
        },
    },
    { family = "Noto Color Emoji", weight = "Regular" },
    { family = "Symbols Nerd Font", weight = "Regular" },
})

-- Function to set the color scheme based on the appearance (dark or light)
local function scheme_for_appearance(appearance)
    local light_font = "Papercolor Light (Gogh)"
    local dark_font = "Papercolor Dark (Gogh)"

    if appearance:find("Dark") then
        return dark_font
    end

    return light_font
end

-- Detect current appearance and apply the corresponding color scheme and tab style
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
-- config.color_scheme = "Catppuccin Mocha"

config.font_size = 16
config.bold_brightens_ansi_colors = true

-- Cursor config
config.default_cursor_style = "BlinkingBlock"
config.force_reverse_video_cursor = false
-- config.cursor_thickness = 3

-- General configuration settings
config.initial_rows = 45
config.initial_cols = 132
config.scrollback_lines = 4200
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.audible_bell = "Disabled"
config.window_close_confirmation = "AlwaysPrompt"
config.window_background_opacity = 1 -- Full opacity
config.window_decorations = "TITLE|RESIZE"
config.use_fancy_tab_bar = true
config.use_cap_height_to_scale_fallback_fonts = true
-- config.term = "wezterm"
config.underline_thickness = 1
config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

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

-- Importing the wezterm module
local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("links").setup(config)

-- Function to set the color scheme based on the appearance (dark or light)
local function light_or_dark(appearance)
    if appearance:find("Dark") then
        -- Dark theme
        return "Catppuccin Macchiato"
    else
        -- Light theme
        return "Catppuccin Latte"
    end
end

-- [[ PragmataPro ]] --
--  https://fsd.it/pragmatapro/Handbook.png
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
    { family = "Symbols Nerd Font", weight = "Regular" },
    { family = "Noto Color Emoji", weight = "Regular" },
})

local function scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "Catppuccin Mocha"
    else
        return "Catppuccin Latte"
    end
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
config.use_fancy_tab_bar = false
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

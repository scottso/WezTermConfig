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

-- Detect current appearance and apply the corresponding color scheme and tab style
config.color_scheme_dirs = { "~/git/catppuccin-wezterm/dist" }
local appearance = wezterm.gui.get_appearance()
config.color_scheme = light_or_dark(appearance)

-- [[[ MonoLisa ]]] --
--config.font = wezterm.font_with_fallback({
--    {
--        family = "MonoLisa Variable",
--        weight = 450, -- 450 is between Regular and Medium
--        harfbuzz_features = {
--            "calt=1",
--            "liga=1",
--            "zero=0", -- 0
--            "ss01=0", -- * (raised asterisk)
--            "ss02=0", -- Script
--            "ss07=1", -- {} {  }
--            "ss08=1", -- () (  )
--            "ss09=1", -- <= >= (double width ligatures)
--            "ss11=1", -- 0xF (formatting for hex codes)
--        },
--    },
--    { family = "Symbols Nerd Font Mono", weight = "Regular" },
--    { family = "Noto Color Emoji",       weight = "Regular" },
--})

-- [[[ MonaSpace ]]] --
-- https://github.com/githubnext/monaspace
-- Variants are: Neon, Argon, Xenon, Radon, Krypton
config.font = wezterm.font_with_fallback({
    {
        family = "Monaspace Xenon",
        weight = 450, -- 450 is between Regular and Medium
        harfbuzz_features = {
            "ss01=1", -- ===
            "ss02=1", -- >= <=
            "ss03=1", -- -> --> <~>
            "ss04=1", -- </ /> /\ </>
            "ss05=1", -- |> <|
            "ss06=1", -- ## ###
            "ss07=1", -- ***
            "ss08=1", -- .=
        },
    },
    { family = "Symbols Nerd Font Mono", weight = "Regular" },
    { family = "Noto Color Emoji",       weight = "Regular" },
})

config.font_rules = {
    {
        intensity = "Bold",
        italic = true,
        font = wezterm.font({
            family = "Monaspace Radon",
            weight = "Bold",
            style = "Italic",
        }),
    },
    {
        italic = true,
        intensity = "Half",
        font = wezterm.font({
            family = "Monaspace Radon",
            weight = "DemiBold",
            style = "Italic",
        }),
    },
    {
        italic = true,
        intensity = "Normal",
        font = wezterm.font({
            family = "Monaspace Radon",
            style = "Italic",
        }),
    },
}

-- [[[ Fira Code]]] --
-- https://github.com/tonsky/FiraCode
-- config.font = wezterm.font_with_fallback({
--     {
--         family = "Fira Code",
--         weight = 450, -- 450 is between Regular and Medium
--         harfbuzz_features = {
--             "liga=1", -- === ->
--             "zero=1", -- 0
--             "cv14=1", -- 3
--             "ss05=1", -- @
--             "ss04=1", -- $
--             "ss03=1", -- &
--         },
--     },
--     { family = "Symbols Nerd Font Mono", weight = "Regular" },
--     { family = "Noto Color Emoji",       weight = "Regular" },
-- })

config.font_size = 13.0
config.bold_brightens_ansi_colors = false

-- Cursor config
config.default_cursor_style = "SteadyBar"
config.force_reverse_video_cursor = false
config.cursor_thickness = 3

-- General configuration settings
config.initial_rows = 45
config.initial_cols = 100
config.scrollback_lines = 4200
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.audible_bell = "Disabled"
config.window_close_confirmation = "AlwaysPrompt"
config.window_background_opacity = 1 -- Full opacity
config.window_decorations = "TITLE|RESIZE"
config.use_fancy_tab_bar = false
config.term = "wezterm"
-- config.underline_thickness = 2
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

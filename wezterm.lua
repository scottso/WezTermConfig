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

-- Front-end renderer configuration
config.front_end = "WebGpu" -- Use WebGpu for rendering
config.webgpu_power_preference = "HighPerformance"

-- Detect current appearance and apply the corresponding color scheme and tab style
config.color_scheme_dirs = { "~/git/catppuccin-wezterm/dist" }
local appearance = wezterm.gui.get_appearance()
config.color_scheme = light_or_dark(appearance)

-- Main font configuration with fallback
config.font = wezterm.font_with_fallback({
    {
        family = "Fira Code",
        weight = "Regular",
        harfbuzz_features = {
            "zero=1", -- 0
            "cv14=1", -- 3
            "ss05=1", -- @
            "ss04=1", -- $
            "cv18=0", -- %
            "ss03=1", -- &
            "cv16=0", -- *** * (more arms on the asterisk)
            "cv31=1", -- () (   )
            "cv29=0", -- {} {   }
            "ss08=0", -- = == === != !==
            "ss09=1", -- >>= <<= ||= |=
            "cv25=1", -- .-
            "cv26=1", -- :-
            "cv32=1", -- .=
            "cv28=1", -- {. .}
            "ss07=1", -- =~ !~
        },
    },
    { family = "Symbols Nerd Font Mono", weight = "Regular" },
    { family = "Noto Color Emoji", weight = "Bold" },
})
config.font_size = 14.0
config.bold_brightens_ansi_colors = true

-- General configuration settings
config.initial_rows = 42
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
config.underline_thickness = 2
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

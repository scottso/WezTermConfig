local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():toggle_fullscreen()
end)

return {
    -- Uncomment this to use native macos_fullscreen_mode
    -- native_macos_fullscreen_mode = true,
}

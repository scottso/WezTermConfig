local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():toggle_fullscreen()
end)

wezterm.on("open-uri", function(window, pane, uri)
    local mods, _ = window:keyboard_modifiers()
    if string.find(mods, "SUPER") then
        return true
    else
        window:copy_to_clipboard(uri)
    end
    -- prevent the default action from opening in a browser
    return false
end)

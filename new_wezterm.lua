-- Video: https://youtu.be/I3ipo8NxsjY?si=8w2QLoHznlZHglvJ
-- Source: https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbWlsUWk1YU5UdGU3b0o4MWllM2ZYdEtTOWJJZ3xBQ3Jtc0tuNzBtM1M4ZnVCX2hKU0FNTjRjSFNNd2ZsZ1FDQWJVNEJuSkl4d0lYMlZsVm5XdWtjUjZJX1RWZk9VdGduVVJLV0N1NWdFUmM1UUpNcFZpeFVDM0N5aTl5dTBsVjFncWR4eUEwTkkyLXFXUXpNVUs2Zw&q=https%3A%2F%2Fgithub.com%2Ftheopn%2Fdotfiles%2Fblob%2F25b85936ef3e7195a0f029525f854fdb915b9f90%2Fwezterm%2Fwezterm.lua&v=I3ipo8NxsjY

local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end

-- Settings
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
    { family = "CaskaydiaCove Nerd Font",  scale = 1.2 },
    { family = "FantasqueSansM Nerd Font", scale = 1.2 },
})
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "home"

-- Dim inactive panes
config.inactive_pane_hsb = {
    saturation = 0.24,
    brightness = 0.5
}

-- Keys
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    -- Send C-a when pressing C-a twice
    { key = "a", mods = "LEADER",       action = act.SendKey { key = "a", mods = "CTRL" } },
    { key = "c", mods = "LEADER",       action = act.ActivateCopyMode },

    -- Pane keybindings
    { key = "-", mods = "LEADER",       action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    -- SHIFT is for when caps lock is on
    { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "h", mods = "LEADER",       action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER",       action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER",       action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER",       action = act.ActivatePaneDirection("Right") },
    { key = "x", mods = "LEADER",       action = act.CloseCurrentPane { confirm = true } },
    { key = "z", mods = "LEADER",       action = act.TogglePaneZoomState },
    { key = "s", mods = "LEADER",       action = act.RotatePanes "Clockwise" },
    -- We can make separate keybindings for resizing panes
    -- But Wezterm offers custom "mode" in the name of "KeyTable"
    { key = "r", mods = "LEADER",       action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

    -- Tab keybindings
    { key = "n", mods = "LEADER",       action = act.SpawnTab("CurrentPaneDomain") },
    { key = "[", mods = "LEADER",       action = act.ActivateTabRelative(-1) },
    { key = "]", mods = "LEADER",       action = act.ActivateTabRelative(1) },
    { key = "t", mods = "LEADER",       action = act.ShowTabNavigator },
    -- Key table for moving tabs around
    { key = "m", mods = "LEADER",       action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },


    -- Lastly, workspace
    { key = "w", mods = "LEADER",       action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },

}
-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = act.ActivateTab(i - 1)
    })
end

config.key_tables = {
    resize_pane = {
        { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
        { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
        { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
        { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
        { key = "Escape", action = "PopKeyTable" },
        { key = "Enter",  action = "PopKeyTable" },
    },
    move_tab = {
        { key = "h",      action = act.MoveTabRelative(-1) },
        { key = "j",      action = act.MoveTabRelative(-1) },
        { key = "k",      action = act.MoveTabRelative(1) },
        { key = "l",      action = act.MoveTabRelative(1) },
        { key = "Escape", action = "PopKeyTable" },
        { key = "Enter",  action = "PopKeyTable" },
    }
}

-- Tab bar
-- I don't like the look of "fancy" tab bar
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
wezterm.on("update-right-status", function(window, pane)
    -- Workspace name
    local stat = window:active_workspace()
    -- It's a little silly to have workspace name all the time
    -- Utilize this to display LDR or current key table name
    if window:active_key_table() then stat = window:active_key_table() end
    if window:leader_is_active() then stat = "LDR" end

    -- Current working directory
    local basename = function(s)
        -- Nothign a little regex can't fix
        return string.gsub(s, "(.*[/\\])(.*)", "%2")
    end
    local cwd = basename(pane:get_current_working_dir())
    -- Current command
    local cmd = basename(pane:get_foreground_process_name())

    -- Time
    local time = wezterm.strftime("%H:%M")

    -- Let's add color to one of the components
    window:set_right_status(wezterm.format({
        -- Wezterm has a built-in nerd fonts
        { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
        { Text = " | " },
        { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
        { Text = " | " },
        { Foreground = { Color = "FFB86C" } },
        { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
        "ResetAttributes",
        { Text = " | " },
        { Text = wezterm.nerdfonts.md_clock .. "  " .. time },
        { Text = " |" },
    }))
end)

return config

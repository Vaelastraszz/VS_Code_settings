-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Enable input forwarding to macOS
config.send_composed_key_when_left_alt_is_pressed = true
config.use_ime = true

-- Set the initial terminal size (rows x columns)
config.initial_cols = 134  -- Number of columns (width)
config.initial_rows = 38   -- Number of rows (height)

-- my coolnight colorscheme
config.colors = {
    foreground = "#d6deeb", -- Light blueish-gray for text
    background = "#011627", -- Deep blue for the background
    cursor_bg = "#80a4c2", -- Soft blue for the cursor background
    cursor_border = "#80a4c2", -- Same as cursor background
    cursor_fg = "#011627", -- Background color for the cursor foreground
    selection_bg = "#1d3b53", -- Muted blue for selection background
    selection_fg = "#d6deeb", -- Text color for selected text
    ansi = {
        "#7e57c2", -- Purple
        "#ef5350", -- Red
        "#22da6e", -- Green
        "#addb67", -- Yellow
        "#82aaff", -- Blue
        "#c792ea", -- Magenta
        "#21c7a8", -- Cyan
        "#d6deeb", -- Light blueish-gray
    },
    brights = {
        "#7e57c2", -- Bright purple
        "#ef5350", -- Bright red
        "#22da6e", -- Bright green
        "#addb67", -- Bright yellow
        "#82aaff", -- Bright blue
        "#c792ea", -- Bright magenta
        "#21c7a8", -- Bright cyan
        "#ffffff", -- White
    },
}

config.font = wezterm.font("CaskaydiaMono Nerd Font Mono", {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 19

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.75
config.macos_window_background_blur = 10

-- and finally, return the configuration to wezterm
return config
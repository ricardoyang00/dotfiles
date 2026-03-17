local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.status_update_interval = 1000

config.color_scheme = 'Materia (base16)'

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 17

config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true

local function get_cwd(pane)
  local cwd = pane.current_working_dir
  if cwd then
    local path = cwd.file_path
    -- Replace home directory with ~
    local home = wezterm.home_dir
    if path:sub(1, #home) == home then
      path = "~" .. path:sub(#home + 1)
    end
    return path:gsub("(.*[/\\])(.*)", "%2")
  end
  return ""
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local dir = get_cwd(pane)
  return {{ Text = "  " .. dir .. "  " },}
end)


config.window_decorations = "RESIZE"
config.window_background_opacity = 1.0
config.macos_window_background_blur = 10

return config

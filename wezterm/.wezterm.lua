-- https://wezfurlong.org/wezterm/config/files.html

local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Opções de configuração - https://wezfurlong.org/wezterm/config/lua/config/index.html

config.color_scheme = 'GitHub Dark' -- https://wezfurlong.org/wezterm/colorschemes/index.html

config.font = wezterm.font 'JetBrainsMonoNL Nerd Font'

config.font_size = 14.0

config.window_decorations = "RESIZE"

config.hide_tab_bar_if_only_one_tab = true

config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}
config.colors = {
  visual_bell = '#202020',
}

config.check_for_updates = false

config.tab_bar_at_bottom = true

config.adjust_window_size_when_changing_font_size = false

config.initial_cols = 122

config.initial_rows = 26

config.xcursor_theme = "Adwaita"

config.hide_mouse_cursor_when_typing = false

for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
  if gpu.backend == 'Vulkan' and gpu.device_type == 'DiscreteGpu' then
    config.webgpu_preferred_adapter = gpu
    config.front_end = 'WebGpu'
    break
  end
end

return config

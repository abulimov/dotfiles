local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- colors
config.color_scheme = 'Catppuccin Mocha'
-- disable ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
-- save space with tab bar
config.hide_tab_bar_if_only_one_tab = true

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- wsl domain
  config.default_domain = 'WSL:Ubuntu-24.04'
end

return config

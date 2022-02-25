--      _    _ _     _             _ 
--     / \  | | |   | | __ ___   _(_)
--    / _ \ | | |_  | |/ _` \ \ / / |
--   / ___ \| | | |_| | (_| |\ V /| |
--  /_/   \_\_|_|\___/ \__,_| \_/ |_|
--
--  github: @AllJavi
--
--  Default system apps

local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. 'utilities/'

return {
 -- default applications for awesome
 default = {
  -- Terminal emulator
  terminal = "kitty",
  -- Web browser
  web_browser = "firefox",
  -- Music Player
  music_player = "spotify",
  -- Text editor
  text_editor = "code",
  -- File manager
  file_manager = "thunar",
  -- Network manager
  network_manager = "nm-connection-editor",
  network_manager_2 = "sh /home/alljavi/.config/rofi/rofi-network-manager/rofi-network-manager.sh",
  -- Blutooth_manager
  bluetooth_manager = "blueman-manager",
  -- Volume manager
  volume_manager = "pavucontrol",
  -- Quake terminal
  quake = 'kitty --name QuakeTerminal',
  -- Rofi AppMenu
  rofi_appmenu = "sh /home/alljavi/.config/rofi/launchers/colorful/launcher.sh",
  -- Rofi powermenu
  rofi_powermenu = "sh /home/alljavi/.config/rofi/applets/menu/powermenu.sh",
  -- Discord
  discord = "discord"
 },
 -- list of apps to start on start-up
 run_on_start_up = {
  -- Manage Screens
  -- "autorandr --load laptop",
  "autorandr --change",
  -- Compositor
  "picom --config $HOME/.config/picom/picom.conf",
  -- WallPaper
  -- "nitrogen --restore",
  -- Load X colors
  "xrdb $HOME/.Xresources",
  -- keyboard layouts
  "setxkbmap -layout 'us,es'"
 },

 -- List of binaries/shell scripts that will execute for a certain task
 utils = {
  -- Fullscreen screenshot
  full_screenshot = utils_dir .. 'snap full',
  -- Area screenshot
  area_screenshot = utils_dir .. 'snap area',
  -- Update profile picture
  update_profile = utils_dir .. 'profile-image'
 }
}

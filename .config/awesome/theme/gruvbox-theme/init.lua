local filesystem = require('gears.filesystem')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'

local theme = {}

theme.icons = theme_dir .. '/icons/'
theme.font = 'JetBrains Mono Medium Nerd Font Complete 10'
theme.font_bold = 'JetBrains Mono Bold Nerd Font Complete 10'

-- Colorscheme
theme.system_black_dark = '#32302f'
theme.system_black_light = '#32302f'

theme.system_red_dark = '#ea6962'
theme.system_red_light = '#ea6962'

theme.system_green_dark = '#a9b665'
theme.system_green_light = '#a9b665'

theme.system_yellow_dark = '#e78a4e'
theme.system_yellow_light = '#e78a4e'

theme.system_blue_dark = '#7daea3' 
theme.system_blue_light = '#7daea3'

theme.system_magenta_dark = '#d3869b'
theme.system_magenta_light = '#d3869b'

theme.system_cyan_dark = '#89b482'
theme.system_cyan_light = '#89b482'

theme.system_white_dark = '#d4be98'
theme.system_white_light = '#d4be98'

-- Accent color
theme.accent = theme.system_blue_dark

-- Background color
theme.background = '#282828'

-- Transparent
theme.transparent = '#28282899'

-- Awesome icon
-- theme.awesome_icon = theme.icons .. 'awesome.svg'

local awesome_overrides = function(theme) end

return {
	theme = theme,
 	awesome_overrides = awesome_overrides
}

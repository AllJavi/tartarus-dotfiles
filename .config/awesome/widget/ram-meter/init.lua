--      _    _ _     _             _ 
--     / \  | | |   | | __ ___   _(_)
--    / _ \ | | |_  | |/ _` \ \ / / |
--   / ___ \| | | |_| | (_| |\ V /| |
--  /_/   \_\_|_|\___/ \__,_| \_/ |_|
--
--  github: @AllJavi
--
--  RAM usage indicator widget (only for nvidia)

local awful = require('awful')
local wibox = require('wibox')

local RamMeter = function(color)
	local ram_widget = wibox.widget { 
		{
			{
				id = "icon",
				markup = "<span color='".. color .. "'></span>",
				font = 'JetBrains Mono Medium Nerd Font Complete 22',
				align = 'center',
				valign = 'center',
				widget = wibox.widget.textbox,

			},
			awful.widget.watch('bash -c "free | grep Mem | awk \'{print int($3/$2 * 100.0)}\'"' ,30, function(widget, stdout)
				for line in stdout:gmatch("[^\r\n]+") do
					line = string.format("%02d", tonumber(line))
					widget.font = ('JetBrains Mono Medium Nerd Font Complete 10')
					widget.markup = ('<span color=\'' .. color .. '\'> ' .. line .. '%</span>')
					widget.align = 'center'
					widget.valign = 'center'
					return
				end
			end),
			layout = wibox.layout.align.horizontal,
		},
		right = 20,
		widget = wibox.container.margin
	}

	return ram_widget
end

return RamMeter

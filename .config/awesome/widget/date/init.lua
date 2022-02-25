--      _    _ _     _             _ 
--     / \  | | |   | | __ ___   _(_)
--    / _ \ | | |_  | |/ _` \ \ / / |
--   / ___ \| | | |_| | (_| |\ V /| |
--  /_/   \_\_|_|\___/ \__,_| \_/ |_|
--
--  github: @AllJavi
--
--  simple date widget

local awful = require('awful')
local wibox = require('wibox')

local date = function(color)
	local date_widget = wibox.widget { 
		{
			{
				id = "icon",
				markup = "<span color='".. color .. "'></span>",
				font = 'JetBrains Mono Medium Nerd Font Complete 10',
				align = 'center',
				valign = 'center',
				widget = wibox.widget.textbox,

			},
			awful.widget.watch('bash -c "date \'+%d/%m\'"' ,10, function(widget, stdout)
				for line in stdout:gmatch("[^\r\n]+") do
					-- line = string.format("%02d", tonumber(line))
					widget.font = ('JetBrains Mono Medium Nerd Font Complete 10')
					widget.markup = ('<span color=\'' .. color .. '\'> ' .. line .. '</span>')
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

	return date_widget
end

return date

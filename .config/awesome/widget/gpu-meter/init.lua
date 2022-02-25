--      _    _ _     _             _ 
--     / \  | | |   | | __ ___   _(_)
--    / _ \ | | |_  | |/ _` \ \ / / |
--   / ___ \| | | |_| | (_| |\ V /| |
--  /_/   \_\_|_|\___/ \__,_| \_/ |_|
--
--  github: @AllJavi
--
--  GPU usage indicator widget (only for nvidia)

local awful = require('awful')
local wibox = require('wibox')

local GpuMeter = function(color)
	local gpu = wibox.widget{
		{
			id = "icon",
			markup = "<span color='".. color .. "' font='10'></span>",
			font = 'JetBrains Mono Medium Nerd Font Complete 20',
			align = 'center',
			valign = 'vcenter',
			widget = wibox.widget.textbox,

		},
		awful.widget.watch('bash -c "nvidia-smi --query-gpu=utilization.gpu --format=csv,nounits,noheader"' ,30, function(widget, stdout)
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
	}

	local gpu_widget = wibox.widget {
		gpu,
		right = 20,
		widget = wibox.container.margin
	}

	return gpu_widget
end

return GpuMeter

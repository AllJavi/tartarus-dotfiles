local awful = require('awful')
local wibox = require('wibox')
local naughty = require('naughty')

local BatteryMeter = function(color)
	local full_battery = "<span color='".. color .. "' font='12'></span>" 
	local semi_full_battery = "<span color='".. color .. "' font='12'></span>" 
	local half_battery = "<span color='".. color .. "' font='12'></span>" 
	local semi_half_battery = "<span color='".. color .. "' font='12'></span>" 
	local low_battery = "<span color='".. color .. "' font='12'></span>" 
	local extreme_low_battery = "<span color='".. color .. "' font='12'></span>" 

	local battery_icon = {
		id = "icon",
		font = 'JetBrains Mono Medium Nerd Font Complete 14',
		widget = wibox.widget.textbox,
	}

	local battery_percentage = awful.widget.watch('bash -c "upower -i $(upower -e | grep BAT) | grep percentage | sed \'s/%//\' | awk \'{print $2}\'"' ,30, function(widget, stdout)
		for line in stdout:gmatch("[^\r\n]+") do
			local battery_percentage = tonumber(line)
			local markup_battery = full_battery
			if battery_percentage < 10 then
				markup_battery = extreme_low_battery
			elseif battery_percentage < 20 then
				markup_battery = low_battery
			elseif battery_percentage < 40 then
				markup_battery = semi_half_battery
			elseif battery_percentage < 60 then
				markup_battery = half_battery
			elseif battery_percentage < 90 then
				markup_battery = semi_full_battery
			end
			widget.font = ('JetBrains Mono Medium Nerd Font Complete 10')
			widget.markup = (markup_battery .. '<span color=\'' .. color .. '\'> ' .. line .. '%</span>')
			return
		end
	end)

	-- battery_icon.markup = semi_full_battery

	local battery_widget = wibox.widget { 
		{
			battery_percentage,
			layout = wibox.layout.align.horizontal,
		},
		right = 15,
		widget = wibox.container.margin
	}

	return battery_widget
end

return BatteryMeter

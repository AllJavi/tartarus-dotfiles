--      _    _ _     _             _ 
--     / \  | | |   | | __ ___   _(_)
--    / _ \ | | |_  | |/ _` \ \ / / |
--   / ___ \| | | |_| | (_| |\ V /| |
--  /_/   \_\_|_|\___/ \__,_| \_/ |_|
--
--  github: @AllJavi
--
--  CPU usage widget

local awful = require('awful')
local wibox = require('wibox')

local total_prev = 0
local idle_prev = 0

local RamMeter = function(color)
	local ram_widget = wibox.widget { 
		{
			{
				id = "icon",
				markup = "<span color='".. color .. "'></span>",
				font = 'JetBrains Mono Medium Nerd Font Complete 13',
				align = 'center',
				valign = 'center',
				widget = wibox.widget.textbox,

			},
			awful.widget.watch('bash -c "cat /proc/stat | grep \'^cpu \'"' ,10, function(widget, stdout)
				local user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice = stdout:match('(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s')
				local total = user + nice + system + idle + iowait + irq + softirq + steal

				local diff_idle = idle - idle_prev
				local diff_total = total - total_prev
				local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10
				total_prev = total
				idle_prev = idle
				collectgarbage('collect')

				line = string.format("%02d", math.floor(diff_usage))
				widget.font = ('JetBrains Mono Medium Nerd Font Complete 10')
				widget.markup = ('<span color="' .. color .. '"> ' .. line .. '%</span>')
				widget.align = 'center'
				widget.valign = 'center'
				return
			end),
			layout = wibox.layout.align.horizontal,
		},
		right = 20,
		widget = wibox.container.margin
	}

	return ram_widget
end

return RamMeter

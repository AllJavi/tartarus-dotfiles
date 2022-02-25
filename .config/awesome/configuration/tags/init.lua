local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local icons = require('theme.icons')
local sharedtags = require('sharedtags')

local tags = {
	{
		icon = icons.ball_1,
	},
	{
		icon = icons.ball_2,
	},
	{
		icon = icons.ball_3,
	},
	{
		icon = icons.ball_4,
	},
	{
		icon = icons.ball_5,
	},
	{
		icon = icons.ball_6,
	},
	{
		icon = icons.ball_7,
	}
}

-- Set tags layout
tag.connect_signal(
	'request::default_layouts',
	function()
	    awful.layout.append_default_layouts({
			awful.layout.suit.tile,
			awful.layout.suit.spiral.dwindle,
			awful.layout.suit.floating,
			awful.layout.suit.max
	    })
	end
)

-- Create tags for each screen
screen.connect_signal(
	'request::desktop_decoration',
	function(s)
		for i, tag in pairs(tags) do
			awful.tag.add(
				i,
				{
					icon = tag.icon,
					icon_only = true,
					layout = tag.layout or awful.layout.suit.spiral.dwindle,
					gap_single_client = true,
					gap = beautiful.useless_gap,
					screen = s,
					selected = i == 1
				}
			)
		end
	end 
)

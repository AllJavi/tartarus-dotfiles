--      _    _ _     _             _ 
--     / \  | | |   | | __ ___   _(_)
--    / _ \ | | |_  | |/ _` \ \ / / |
--   / ___ \| | | |_| | (_| |\ V /| |
--  /_/   \_\_|_|\___/ \__,_| \_/ |_|
--
--  github: @AllJavi
--
-- Client ShortCuts configuration

local awful = require('awful')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
require('awful.autofocus')
local modkey = require('configuration.keys.mod').mod_key
local altkey = require('configuration.keys.mod').alt_key

local client_keys = awful.util.table.join(
	-- Kill any client {{{
	awful.key(
		{ modkey , "Shift" },
		'c',
		function(c)
			c:kill()
		end,
		{description = '- close', group = 'client'}
	),
	-- }}}
	
	-- Jump to the urgent client {{{
	awful.key(
		{ modkey }, 
		'u', 
		awful.client.urgent.jumpto, 
		{description = '- jump to urgent client', group = 'client'}
	),
	-- }}}
	
	-- Move between clients by direction {{{
	awful.key(
		{ modkey },
		'd',
		function()
			awful.client.focus.bydirection("right")
			if client.focus then client.focus:raise() end
		end,
		-- {description = 'focus right client', group = 'client'}
		{description = '- focus direction', group = 'client'}
	),
	awful.key(
		{ modkey },
		'a',
		function()
			awful.client.focus.bydirection("left")
			if client.focus then client.focus:raise() end
		end,
		-- {description = 'focus left client', group = 'client'}
		{description = '- focus direction', group = 'client'}
	),
	awful.key(
		{ modkey },
		'w',
		function()
			awful.client.focus.bydirection("up")
			if client.focus then client.focus:raise() end
		end,
		-- {description = 'focus up client', group = 'client'}
		{description = '- focus direction', group = 'client'}
	),
	awful.key(
		{ modkey },
		's',
		function()
			awful.client.focus.bydirection("down")
			if client.focus then client.focus:raise() end
		end,
		-- {description = 'focus down client', group = 'client'}
		{description = '- focus direction', group = 'client'}
	),
	-- }}}

	-- Swap clients by direction {{{
	awful.key(
		{ modkey, 'Shift' },
		'd',
		function ()
			awful.client.swap.bydirection("right")
		end,
		-- {description = 'swap with right client', group = 'client'}
		{description = '- swap direction', group = 'client'}
	),
	awful.key(
		{ modkey, 'Shift' },
		'a',
		function ()
			awful.client.swap.bydirection("left")
		end,
		-- {description = 'swap with left client', group = 'client'}
		{description = '- swap direction', group = 'client'}
	),
	awful.key(
		{ modkey, 'Shift' },
		'w',
		function ()
			awful.client.swap.bydirection("up")
		end,
		-- {description = 'swap with up client', group = 'client'}
		{description = '- swap direction', group = 'client'}
	),
	awful.key(
		{ modkey, 'Shift' },
		's',
		function ()
			awful.client.swap.bydirection("down")
		end,
		-- {description = 'swap with down client', group = 'client'}
		{description = '- swap direction', group = 'client'}
	),
	-- }}}
	
	-- Change client width
	awful.key(
		{ modkey, 'Control' },
		'd',
		function ()
			awful.tag.incmwfact(0.05)
		end,
		{description = '- inc/dec master width', group = 'client'}
	),
        awful.key(
		{ modkey, "Control" },
		'a',
		function(c)
			awful.tag.incmwfact(-0.05)
		end,
		{description = '- inc/dec master width', group = 'client'}
        ),
	-- }}}
	
	-- (un)Maximize clients {{{
	awful.key(
		{ modkey, "Control" },
		'w',
		function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{description = '- toggle fullscreen', group = 'client'}
	),
	-- }}}
	
	-- (un)Floaing clients {{{
        awful.key(
		{ modkey, "Control" },
		's',
		function(c)
			c.floating = not c.floating
			c:raise()
		end,
		{description = '- toggle floating', group = 'client'}
        ),
	-- }}}
	
	awful.key(
		{ modkey },
		'Tab',
		function()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = '- last Client', group = 'client'}
	)
)

return client_keys


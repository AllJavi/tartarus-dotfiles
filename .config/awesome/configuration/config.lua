--      _    _ _     _             _ 
--     / \  | | |   | | __ ___   _(_)
--    / _ \ | | |_  | |/ _` \ \ / / |
--   / ___ \| | | |_| | (_| |\ V /| |
--  /_/   \_\_|_|\___/ \__,_| \_/ |_|
--
--  github: @AllJavi
--
--  Custom configuration for some modules

return {
	widget = {
		network = {
			-- Wired interface
			wired_interface = 'enp3s0',
			-- Wireless interface
			wireless_interface = 'wlan0'
		}
	},

	module = {
		auto_start = {
			-- Will create notification if true
			debug_mode = false
		}
	}
}

--      _    _ _     _             _ 
--     / \  | | |   | | __ ___   _(_)
--    / _ \ | | |_  | |/ _` \ \ / / |
--   / ___ \| | | |_| | (_| |\ V /| |
--  /_/   \_\_|_|\___/ \__,_| \_/ |_|
--
--  github: @AllJavi
--

local awful = require('awful')
local tasklist_panel = require('layout.tasklist-panel')
local top_panel = require('layout.top-panel')
local top_secundary_panel = require('layout.top-secundary-panel')
local dashboard = require('layout.dashboard')

awful.screen.connect_for_each_screen(function(s)
	s.tasklist_panel = tasklist_panel(s, true)
 	s.top_panel = top_panel(s)
	s.top_secundary_panel = top_secundary_panel(s, true)
	s.dashboard_panel = dashboard(s)
end)

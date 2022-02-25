local awful = require('awful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local capi = {button = _G.button}
local gears = require('gears')
local clickable_container = require('widget.clickable-container')
local tasklist_mode = 'text' -- anything else = text

local function list_update(w, buttons, label, data, objects)
    -- update the widgets, creating them if needed
    w:reset()
    for i, o in ipairs(objects) do
        local cache = data[o]
	cache = false
        local tb, bgb, tbm, l, ll
        if cache then
            tb = cache.tb
            bgb = cache.bgb
            tbm = cache.tbm
        else
            tb = wibox.widget.textbox()
	    tb.align = 'center'

            bgb = wibox.container.background()
            -- tbm = wibox.container.margin(tb, dpi(4), dpi(4))
	    tbm = {
	 	layout = wibox.container.scroll.horizontal,
		-- max_size = 100,
		step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
		speed = 100,
		tb
	    }
            l = wibox.layout.fixed.horizontal()
            ll = wibox.layout.fixed.horizontal()

            -- All of this is added in a fixed widget
            l:fill_space(true)
            l:add(tbm)
            ll:add(l)

            -- And all of this gets a background
	    bgb:set_widget(ll)

            data[o] = {
                tb = tb,
                bgb = bgb,
                tbm = tbm,
            }
        end

        local text, bg, bg_image, icon, args = label(o, tb)
        args = args or {}

        -- The text might be invalid, so use pcall.
        if tasklist_mode == 'icon' then text = nil end
        if text == nil or text == '' then
            tbm:set_margins(0)
        else
            -- truncate when title is too long
            local textOnly = text:match('>(.-)<')
            if (textOnly:len() > 300) then
                text = text:gsub('>(.-)<', '>' .. textOnly:sub(1, 21) .. '...<')
            end
            if not tb:set_markup_silently(text) then
                tb:set_markup('<i>&lt;Invalid text&gt;</i>')
            end
        end
	
        bgb.shape = args.shape
        bgb.shape_border_width = args.shape_border_width
        bgb.shape_border_color = args.shape_border_color

        w:add(bgb)
    end
end

local TaskList = function(s)
    return awful.widget.tasklist{
	    screen = s, 
	    filter = awful.widget.tasklist.filter.focused,
	    buttons = {}, 
	    update_function = list_update,
	    layout = wibox.layout.fixed.horizontal()
    }
end

return TaskList

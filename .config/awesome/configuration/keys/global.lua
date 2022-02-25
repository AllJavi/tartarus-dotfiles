--      _    _ _     _             _ 
--     / \  | | |   | | __ ___   _(_)
--    / _ \ | | |_  | |/ _` \ \ / / |
--   / ___ \| | | |_| | (_| |\ V /| |
--  /_/   \_\_|_|\___/ \__,_| \_/ |_|
--
--  github: @AllJavi
--
--  Global shortcuts

local awful = require('awful')
local beautiful = require('beautiful')

require('awful.autofocus')

local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('configuration.keys.mod').mod_key
local altkey = require('configuration.keys.mod').alt_key
local apps = require('configuration.apps')
local n = require("naughty")
-- local dashboard = require('module.dashboard')

-- Key bindings
local global_keys = awful.util.table.join(

-- basic awesome commands {{{
awful.key(
{ modkey },
    'h',
    hotkeys_popup.show_help,
    { description = '- show help', group = 'awesome' }
),
    awful.key({ modkey, 'Control' },
        'r',
        awesome.restart,
        { description = '- reload awesome', group = 'awesome' }
    ),

    awful.key({ modkey, 'Control' },
        'q',
        awesome.quit,
        { description = '- quit awesome', group = 'awesome' }
    ),
    -- }}}

    -- change layout {{{
    awful.key(
    { modkey },
        'l',
        function()
            awful.layout.inc(1)
        end,
        { description = '- select next/prev layout', group = 'layout' }
    ),
    awful.key(
    { modkey, 'Shift' },
        'l',
        function()
            awful.layout.inc(-1)
        end,
        { description = '- select next/prev layout', group = 'layout' }
    ),
    -- }}}

    -- change useless gap size {{{
    awful.key(
    { modkey },
        'g',
        function()
            awful.tag.incgap(1)
        end,
        { description = 'inc/dec useless gap', group = 'layout' }
    ),
    awful.key(
    { modkey, 'Shift' },
        'g',
        function()
            awful.tag.incgap(-1)
        end,
        { description = 'inc/dec useless gap', group = 'layout' }
    ),
    -- }}}

    -- move to non-empty tag {{{
    awful.key(
    { "Shift", altkey },
        'a',
        function()
            local focused = awful.screen.focused()
            for i = 1, #focused.tags do
                awful.tag.viewidx(-1, focused)
                if #focused.clients > 0 then
                    return
                end
            end
        end,
        { description = 'view previus/next non-empty tag', group = 'tag' }
    ),
    awful.key(
    { "Shift", altkey },
        'd',
        function(c)
            local focused = awful.screen.focused()
            for i = 1, #focused.tags do
                awful.tag.viewidx(1, focused)
                if #focused.clients > 0 then
                    return
                end
            end
        end,
        { description = 'view previus/next non-empty tag', group = 'tag' }
    ),
    -- }}}

    -- move to last tag {{{
    awful.key(
    { modkey, "Shift" },
        'Tab',
        awful.tag.history.restore,
        { description = 'alternate between current and previous tag', group = 'tag' }
    ),
    -- }}}


    -- Go next or Previus Screen {{{
    awful.key(
    { "Shift", altkey },
        'w',
        function(c)
            awful.screen.focus_relative(1)
        end,
        { description = 'Focus next/previus screen', group = 'screen' }
    ),
    awful.key(
    { "Shift", altkey },
        's',
        function(c)
            awful.screen.focus_relative(-1)
        end,
        { description = 'Focus next/previus screen', group = 'screen' }
    ),
    -- }}}

    -- Volume options with alsa {{{
    awful.key(
    {},
        'XF86AudioRaiseVolume',
        function()
            awful.spawn('amixer -D pulse sset Master 5%+', false)
            awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show', true)
        end,
        { description = 'inc/dec volume', group = 'hotkeys' }
    ),
    awful.key(
    {},
        'XF86AudioLowerVolume',
        function()
            awful.spawn('amixer -D pulse sset Master 5%-', false)
            awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show', true)
        end,
        { description = 'inc/dec volume', group = 'hotkeys' }
    ),
    awful.key(
    {},
        'XF86AudioMute',
        function()
            awful.spawn('amixer -D pulse set Master 1+ toggle', false)
        end,
        { description = 'toggle mute', group = 'hotkeys' }
    ),
    -- }}}

    -- music controls with sp {{{
    awful.key(
    {},
        'XF86AudioNext',
        function()
            awful.spawn('sp next', false)
        end,
        { description = 'next/prev spotify song', group = 'hotkeys' }
    ),
    awful.key(
    {},
        'XF86AudioPrev',
        function()
            awful.spawn('sp prev', false)
        end,
        { description = 'next/prev spotify song', group = 'hotkeys' }
    ),
    awful.key(
    {},
        'XF86AudioPlay',
        function()
            awful.spawn('sp play', false)
        end,
        { description = 'play/pause spotify song', group = 'hotkeys' }

    ),
    -- }}}

    -- microphone toggle {{{
    awful.key(
    {},
        'XF86AudioMicMute',
        function()
            awful.spawn('amixer set Capture toggle', false)
        end,
        { description = 'toggle microphone', group = 'hotkeys' }
    ),
    -- }}}

    -- extra hotkeys {{{
    awful.key(
    {},
        'XF86PowerDown',
        function()
            --
        end,
        { description = 'shutdown skynet', group = 'hotkeys' }
    ),
    awful.key(
    {},
        'XF86PowerOff',
        function()
            awesome.emit_signal('module::exit_screen:show')
        end,
        { description = 'toggle exit screen', group = 'hotkeys' }
    ),
    awful.key(
    {},
        'XF86Display',
        function()
            awful.spawn.single_instance('arandr', false)
        end,
        { description = 'arandr', group = 'hotkeys' }
    ),
    awful.key(
    { modkey, 'Shift' },
        'q',
        function()
            awesome.emit_signal('module::exit_screen:show')
        end,
        { description = 'toggle exit screen', group = 'hotkeys' }
    ),
    -- }}}

    -- screentshot utility {{{
    awful.key(
    {},
        'Print',
        function()
            awful.spawn.easy_async_with_shell(apps.utils.full_screenshot, function() end)
        end,
        { description = 'fullscreen screenshot', group = 'Utility' }
    ),
    awful.key(
    { 'Shift' },
        'Print',
        function()
            awful.spawn.easy_async_with_shell(apps.utils.area_screenshot, function() end)
        end,
        { description = 'area/selected screenshot', group = 'Utility' }
    ),
    -- }}}

    -- launch programs {{{
    awful.key(
    { modkey },
        'Return',
        function()
            awful.spawn(apps.default.terminal)
        end,
        { description = 'open default terminal', group = 'launcher' }
    ),
    awful.key(
    { modkey, 'Shift' },
        'o',
        function()
            awful.spawn(apps.default.file_manager)
        end,
        { description = 'open default file manager', group = 'launcher' }
    ),
    awful.key(
    { modkey, 'Shift' },
        'p',
        function()
            awful.spawn(apps.default.text_editor)
        end,
        { description = 'open default code editor', group = 'launcher' }
    ),
    awful.key(
    { modkey, 'Shift' },
        'n',
        function()
            awful.spawn(apps.default.web_browser)
        end,
        { description = 'open default web browser', group = 'launcher' }
    ),
    awful.key(
    { modkey, 'Shift' },
        'l',
        function()
            awful.spawn(apps.default.discord)
        end,
        { description = 'open discord', group = 'launcher' }
    ),
    awful.key(
    { modkey, 'Shift' },
        'm',
        function()
            awful.spawn(apps.default.music_player)
        end,
        { description = 'launch spotify', group = 'launcher' }
    ),
    awful.key(
    { 'Control', 'Shift' },
        'Escape',
        function()
            awful.spawn(apps.default.terminal .. ' ' .. 'htop')
        end,
        { description = 'open system monitor', group = 'launcher' }
    ),
    -- }}}

    -- change layout keyboard layout {{{
    awful.key(
    { modkey },
        'space',
        function()
            awful.spawn("xkb-switch -n", false)
        end,
        { description = 'change keyboard layout', group = 'keyboard' }
    ),
    -- }}}

    -- show dashBoard {{{
    awful.key(
    { modkey },
        'q',
        function()
            local focused = awful.screen.focused()

            local dashboard = focused.dashboard_panel
            dashboard.toggle()
        end,
        { description = 'change keyboard layout', group = 'keyboard' }
    ),
    -- }}}

    -- launch rofi {{{
    awful.key(
    { modkey },
        '\\',
        function()
            local focused = awful.screen.focused()
            awful.spawn(apps.default.rofi_appmenu, false)
        end,
        { description = 'open application drawer', group = 'launcher' }
    ),
    awful.key(
    { modkey, "Shift" },
        '\\',
        function()
            local focused = awful.screen.focused()
            awful.spawn(apps.default.rofi_powermenu, false)
        end,
        { description = 'open application drawer', group = 'launcher' }
    )
-- }}}

)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = { description = 'view tag n', group = 'tag' }
        descr_toggle = { description = 'toggle tag n', group = 'tag' }
        descr_move = { description = 'move focused client to tag n', group = 'tag' }
        descr_toggle_focus = { description = 'toggle focused client on tag n', group = 'tag' }
    end
    global_keys = awful.util.table.join(
    global_keys,
        -- View tag only.
        awful.key(
        { modkey },
            '#' .. i + 9,
            function()
                local focused = awful.screen.focused()
                local tag = focused.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            descr_view
        ),
        -- Toggle tag display.
        awful.key(
        { modkey, 'Control' },
            '#' .. i + 9,
            function()
                local focused = awful.screen.focused()
                local tag = focused.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            descr_toggle
        ),
        -- Move client to tag.
        awful.key(
        { modkey, 'Shift' },
            '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            descr_move
        ),
        -- Toggle tag on focused client.
        awful.key(
        { modkey, 'Control', 'Shift' },
            '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            descr_toggle_focus
        )
    )
end

return global_keys

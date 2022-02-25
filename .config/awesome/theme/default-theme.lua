local gears = require('gears')
local beautiful = require('beautiful')

local filesystem = gears.filesystem
local dpi = beautiful.xresources.apply_dpi
local gtk_variable = beautiful.gtk.get_theme_variables

local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local titlebar_icon_path = theme_dir .. '/icons/titlebar/'
local tip = titlebar_icon_path

-- Create theme table
local theme = {}

-- Font
theme.font = 'JetBrains Mono Medium Nerd Font Complete 10'
theme.font_bold = 'JetBrains Mono Bold Nerd Font Complete 10'

-- Menu icon theme
theme.icon_theme = 'Gruvbox-Material-Dark'

local awesome_overrides = function(theme)

    theme.dir = theme_dir
    theme.icons = theme_dir .. '/icons/'

    -- Default font
    theme.font = 'JetBrains Mono Medium Nerd Font Complete 10'

    -- Foreground
    theme.fg_normal = '#d4be98de'
    theme.fg_focus = '#d4be98'
    theme.fg_urgent = '#ea6962'

    theme.bg_normal = theme.background
    theme.bg_focus = theme.background
    theme.bg_urgent = theme.background

    -- System tray
    theme.bg_systray = theme.background
    theme.systray_icon_spacing = dpi(16)

    -- Titlebar
    theme.titlebar_size = dpi(34)
    theme.titlebar_bg_focus = '#32302f'
    theme.titlebar_bg_normal = '#32302f' -- ee'
    theme.titlebar_fg_focus = '#d4be98' -- de'
    theme.titlebar_fg_normal = '#d4be98'

    -- Close Button
    theme.titlebar_close_button_normal = tip .. 'close_normal.svg'
    theme.titlebar_close_button_focus = tip .. 'close_focus.svg'

    -- Minimize Button
    theme.titlebar_minimize_button_normal = tip .. 'minimize_normal.svg'
    theme.titlebar_minimize_button_focus = tip .. 'minimize_focus.svg'

    -- Ontop Button
    theme.titlebar_ontop_button_normal_inactive = tip .. 'ontop_normal_inactive.svg'
    theme.titlebar_ontop_button_focus_inactive = tip .. 'ontop_focus_inactive.svg'
    theme.titlebar_ontop_button_normal_active = tip .. 'ontop_normal_active.svg'
    theme.titlebar_ontop_button_focus_active = tip .. 'ontop_focus_active.svg'

    -- Sticky Button
    theme.titlebar_sticky_button_normal_inactive = tip .. 'sticky_normal_inactive.svg'
    theme.titlebar_sticky_button_focus_inactive = tip .. 'sticky_focus_inactive.svg'
    theme.titlebar_sticky_button_normal_active = tip .. 'sticky_normal_active.svg'
    theme.titlebar_sticky_button_focus_active = tip .. 'sticky_focus_active.svg'

    -- Floating Button
    theme.titlebar_floating_button_normal_inactive = tip .. 'floating_normal_inactive.svg'
    theme.titlebar_floating_button_focus_inactive = tip .. 'floating_focus_inactive.svg'
    theme.titlebar_floating_button_normal_active = tip .. 'floating_normal_active.svg'
    theme.titlebar_floating_button_focus_active = tip .. 'floating_focus_active.svg'

    -- Maximized Button
    theme.titlebar_maximized_button_normal_inactive = tip .. 'maximized_normal_inactive.svg'
    theme.titlebar_maximized_button_focus_inactive = tip .. 'maximized_focus_inactive.svg'
    theme.titlebar_maximized_button_normal_active = tip .. 'maximized_normal_active.svg'
    theme.titlebar_maximized_button_focus_active = tip .. 'maximized_focus_active.svg'

    -- Hovered Close Button
    theme.titlebar_close_button_normal_hover = tip .. 'close_normal_hover.svg'
    theme.titlebar_close_button_focus_hover = tip .. 'close_focus_hover.svg'

    -- Hovered Minimize Buttin
    theme.titlebar_minimize_button_normal_hover = tip .. 'minimize_normal_hover.svg'
    theme.titlebar_minimize_button_focus_hover = tip .. 'minimize_focus_hover.svg'

    -- Hovered Ontop Button
    theme.titlebar_ontop_button_normal_inactive_hover = tip .. 'ontop_normal_inactive_hover.svg'
    theme.titlebar_ontop_button_focus_inactive_hover = tip .. 'ontop_focus_inactive_hover.svg'
    theme.titlebar_ontop_button_normal_active_hover = tip .. 'ontop_normal_active_hover.svg'
    theme.titlebar_ontop_button_focus_active_hover = tip .. 'ontop_focus_active_hover.svg'

    -- Hovered Sticky Button
    theme.titlebar_sticky_button_normal_inactive_hover = tip .. 'sticky_normal_inactive_hover.svg'
    theme.titlebar_sticky_button_focus_inactive_hover = tip .. 'sticky_focus_inactive_hover.svg'
    theme.titlebar_sticky_button_normal_active_hover = tip .. 'sticky_normal_active_hover.svg'
    theme.titlebar_sticky_button_focus_active_hover = tip .. 'sticky_focus_active_hover.svg'

    -- Hovered Floating Button
    theme.titlebar_floating_button_normal_inactive_hover = tip .. 'floating_normal_inactive_hover.svg'
    theme.titlebar_floating_button_focus_inactive_hover = tip .. 'floating_focus_inactive_hover.svg'
    theme.titlebar_floating_button_normal_active_hover = tip .. 'floating_normal_active_hover.svg'
    theme.titlebar_floating_button_focus_active_hover = tip .. 'floating_focus_active_hover.svg'

    -- Hovered Maximized Button
    theme.titlebar_maximized_button_normal_inactive_hover = tip .. 'maximized_normal_inactive_hover.svg'
    theme.titlebar_maximized_button_focus_inactive_hover = tip .. 'maximized_focus_inactive_hover.svg'
    theme.titlebar_maximized_button_normal_active_hover = tip .. 'maximized_normal_active_hover.svg'
    theme.titlebar_maximized_button_focus_active_hover = tip .. 'maximized_focus_active_hover.svg'

    -- User profile
    theme.user_picture = '~/../alljavi-shared/pictures/profile/zero two/397f9ee1b1f00af85c22f82eb651d1e5.jpg'

    -- folder icons
    theme.code_folder = '/home/alljavi-shared/design/themes/Guweiz/icons/system/code-folder/256.png'
    theme.design_folder = '/home/alljavi-shared/design/themes/Guweiz/icons/system/design-folder/256.png'
    theme.teleco_folder = '/home/alljavi-shared/design/themes/Guweiz/icons/system/teleco-folder/256.png'
    theme.download_folder = '/home/alljavi-shared/design/themes/Guweiz/icons/system/download-folder/256.png'
    theme.design3d_folder = '/home/alljavi-shared/design/themes/Guweiz/icons/system/3d-design-folder/256.png'
    theme.shared_folder = '/home/alljavi-shared/design/themes/Guweiz/icons/system/basic-folder/folder-oomox.png'

    -- apps icons
    theme.code_icon = theme.icons .. "code.svg"
    theme.discord_icon = theme.icons .. "discord.svg"
    theme.spotify_icon = theme.icons .. "spotify.svg"


    -- UI Groups
    theme.groups_title_bg = '#d4be98' .. '15'
    theme.groups_bg = '#d4be98' .. '10'
    theme.groups_radius = dpi(9)

    -- UI events
    theme.leave_event = theme.transparent
    theme.enter_event = '#d4be98' .. '10'
    theme.press_event = '#d4be98' .. '15'
    theme.release_event = '#d4be98' .. '10'

    -- Client Decorations

    -- Borders
    theme.border_focus = "#b26a3c" -- 33"
    theme.border_normal = "#282828" -- 33"
    theme.border_marked = '#577970' -- 33'
    theme.border_width = dpi(3)
    theme.border_radius = dpi(0)

    -- Decorations
    theme.useless_gap = dpi(7)
    theme.client_shape_rectangle = gears.shape.rectangle
    theme.client_shape_rounded = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, dpi(9))
    end

    -- Menu
    -- theme.menu_font = 'Inter Regular 11'
    -- theme.menu_submenu = '' -- ➤

    -- theme.menu_height = dpi(34)
    -- theme.menu_width = dpi(200)
    -- theme.menu_border_width = dpi(20)
    -- theme.menu_bg_focus = theme.accent .. 'CC'

    -- theme.menu_bg_normal =  theme.background:sub(1,7) .. '33'
    -- theme.menu_fg_normal = '#ffffff'
    -- theme.menu_fg_focus = '#ffffff'
    -- theme.menu_border_color = theme.background:sub(1,7) .. '5C'

    -- Tooltips

    theme.tooltip_bg = theme.background
    theme.tooltip_border_color = theme.transparent
    theme.tooltip_border_width = 0
    theme.tooltip_gaps = dpi(5)
    theme.tooltip_shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, dpi(6))
    end

    -- Separators
    theme.separator_color = '#d4be9844'

    -- Layoutbox icons
    theme.layout_max = theme.icons .. 'layouts/max.svg'
    theme.layout_tile = theme.icons .. 'layouts/tile.svg'
    theme.layout_dwindle = theme.icons .. 'layouts/dwindle.svg'
    theme.layout_floating = theme.icons .. 'layouts/floating.svg'

    -- Taglist
    theme.taglist_bg_empty = theme.background -- .. '99'
    -- theme.taglist_bg_occupied =  theme.system_cyan_dark .. '6A'
    theme.taglist_bg_occupied = theme.background
    theme.taglist_bg_urgent = theme.system_red_dark .. '6A'
    theme.taglist_bg_focus = theme.system_yellow_dark .. '6A'
    theme.taglist_spacing = dpi(4)

    -- Tasklist
    theme.tasklist_font = 'JetBrains Mono Regular Nerd Font Complete 10'
    theme.tasklist_bg_normal = "ffffff00"
    -- theme.tasklist_bg_focus = theme.background
    -- theme.tasklist_bg_focus = "#d4be98" .. '20'
    theme.tasklist_bg_focus = "#7daea3"
    -- theme.tasklist_bg_urgent = '#32302f' .. '99'
    theme.tasklist_bg_urgent = '#ea6962'
    theme.tasklist_fg_focus = '#d4be98'
    theme.tasklist_fg_urgent = '#ea6952'
    theme.tasklist_fg_normal = '#d4be98'

    -- Notification
    theme.notification_position = 'bottom_right'
    theme.notification_bg = theme.transparent
    theme.notification_margin = dpi(7)
    theme.notification_border_width = dpi(4)
    theme.notification_border_color = theme.system_green_dark
    theme.notification_spacing = dpi(14)
    theme.notification_icon_resize_strategy = 'center'
    theme.notification_icon_size = dpi(32)

    -- Client Snap Theme
    theme.snap_bg = theme.background
    theme.snap_shape = gears.shape.rectangle
    theme.snap_border_width = dpi(15)

    -- Hotkey popup
    theme.hotkeys_font = 'JetBrains Mono Bold Nerd Font Complete'
    theme.hotkeys_description_font = 'JetBrains Mono Regular Nerd Font Complete'
    theme.hotkeys_bg = theme.background .. "ee"
    theme.hotkeys_group_margin = dpi(20)
end

return {
 theme = theme,
 awesome_overrides = awesome_overrides
}

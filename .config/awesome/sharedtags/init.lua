--- Provides functionality to share tags across all screens in awesome WM.
-- @module sharedtags
-- @author Albert Diserholt
-- @copyright 2016 Albert Diserholt
-- @license MIT

-- Grab environment we need
local awful = require("awful")
local capi = {
    screen = screen
}

local sharedtags = {
    _VERSION = "sharedtags v1.0.0 for v4.0",
    _DESCRIPTION = "Share tags for awesome window manager v4.0",
    _URL = "https://github.com/Drauthius/awesome-sharedtags",
    _LICENSE = [[
        MIT LICENSE

        Copyright (c) 2017 Albert Diserholt

        Permission is hereby granted, free of charge, to any person obtaining a
        copy of this software and associated documentation files (the "Software"),
        to deal in the Software without restriction, including without limitation
        the rights to use, copy, modify, merge, publish, distribute, sublicense,
        and/or sell copies of the Software, and to permit persons to whom the
        Software is furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in
        all copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
        FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
        IN THE SOFTWARE.
    ]]
}

--- Attempts to salvage a tag when a screen is removed.
-- @param tag The tag to salvage.
local function salvage(tag)
    -- The screen to move the orphaned tag to.
    local newscreen = capi.screen.primary

    -- Make sure the tag isn't selected when moved to the new screen.
    tag.selected = false

    sharedtags.movetag(tag, newscreen)

    capi.screen[newscreen]:emit_signal("tag::history::update")
end

--- Create one new tag with sharedtags metadata.
-- This is mostly useful for setups with dynamic tag adding.
-- @tparam number i The tag (global/shared) index
-- @tparam table t The tag definition table for awful.tag.add
-- @treturn table The created tag.
function sharedtags.add(i, t)
   t = awful.util.table.clone(t, false) -- shallow copy for modification
   t.screen = (t.screen and t.screen <= capi.screen.count()) and t.screen or capi.screen.primary
   t.sharedtagindex = i
   t.mainsharedtag = true
   local tag = awful.tag.add(t.name or i, t)

   -- If no tag is selected for this screen, then select this one.
   if not tag.screen.selected_tag then
      tag:view_only() -- Updates the history as well.
   end

   -- Make sure to salvage the tag in case the screen disappears.
   tag:connect_signal("request::screen", salvage)

   return tag
end

--- Create duplicated tag to show it in the new screen.
-- This tag is not gona be ussed never
-- @tparam number i The tag (global/shared) index
-- @tparam table t The tag definition table for awful.tag.add
function sharedtags.addDuplicated(i, t, s)
   t = awful.util.table.clone(t, false) -- shallow copy for modification
   t.screen = s
   t.sharedtagindex = i
   t.mainsharedtag = false
   awful.tag.add(i, t)
end

--- Create new tag objects.
-- The first tag defined for each screen will be automatically selected.
-- @tparam table def A list of tables with the optional keys `name`, `layout`
-- and `screen`. The `name` value is used to name the tag and defaults to the
-- list index. The `layout` value sets the starting layout for the tag and
-- defaults to the first layout. The `screen` value sets the starting screen
-- for the tag and defaults to the first screen. The tags will be sorted in this
-- order in the default taglist.
-- @treturn table A list of all created tags. Tags are assigned numeric values
-- corresponding to the input list, and all tags with non-numerical names are
-- also assigned to a key with the same name.
function sharedtags.new(def)
    local tags = {}

    for i,t in ipairs(def) do
        tags[i] = sharedtags.add(i, t)

        -- Create an alias between the index and the name.
        if t.name and type(t.name) ~= "number" then
            tags[t.name] = tags[i]
        end
    end

    return tags
end

--- Create duplicated tags objects to show in the new screen.
-- @tparam table def A list of tables with the optional keys `name`, `layout`
-- and `screen`. The `name` value is used to name the tag and defaults to the
-- list index. The `layout` value sets the starting layout for the tag and
-- defaults to the first layout. The `screen` value sets the starting screen
-- for the tag and defaults to the first screen. The tags will be sorted in this
-- order in the default taglist.
-- @tparam screen screen is the new screen connected
function sharedtags.newscreen(def, screen)
    for i, t in ipairs(def) do
        if screen.id ~= 0 then
            sharedtags.addDuplicated(i, t, screen)
        end
    end
end

function sharedtags.searchDuplicated(original, tags)
    duplicatedtag = nil
    for i, tested_tag in ipairs(tags) do
         if tested_tag.sharedtagindex == original.sharedtagindex then
             duplicatedtag = tested_tag
             break
         end
    end
    return duplicatedtag
end

--- Move the specified tag to a new screen, if necessary.
-- @param tag The tag to move.
-- @tparam[opt=awful.screen.focused()] number screen The screen to move the tag to.
-- @treturn bool Whether the tag was moved.
function sharedtags.movetag(tag, screen)
    screen = screen or awful.screen.focused()
    local oldscreen = tag.screen
    local previusSelection = screen.selected_tag

    -- If the specified tag is allocated to another screen, we need to move it,
    -- or if the tag no longer belongs to a screen.
    if oldscreen ~= screen or not oldscreen then
        -- Try to find a new tag to show on the previous screen if the currently
        -- selected tag is the one that was moved away.
        if oldscreen then
            local oldsel = oldscreen.selected_tag
            tag.screen = screen
            duplicatedtag = sharedtags.searchDuplicated(tag, screen.tags)

            if not duplicatedtag.mainsharedtag then
                duplicatedtag.screen = oldscreen
            end


            if oldsel == tag then
                -- The tag has been moved away. In most cases the tag history
                -- function will find the best match, but if we really want we can
                -- try to find a fallback tag as well.
                --
                if not oldscreen.selected_tag then
                    -- local newtag = awful.tag.find_fallback(oldscreen)
                    previusSelection.screen = oldscreen -- xmonad change
                    previusSelection:view_only()

                    duplicatedtag = sharedtags.searchDuplicated(previusSelection, oldscreen.tags)

                    if not duplicatedtag.mainsharedtag then
                        duplicatedtag.screen = screen
                    end
                end
            end
        end

        -- Also sort the tag in the taglist, by reapplying the index. This is just a nicety.
        local unpack = unpack or table.unpack
        for _,s in ipairs({ screen, oldscreen or { tags = {} } }) do
            local tags = { unpack(s.tags) } -- Copy
            table.sort(tags, function(a, b) return a.sharedtagindex < b.sharedtagindex end)
            for i,t in ipairs(tags) do
                t.index = i
            end
        end

        return true
    end

    return false
end

--- View the specified tag on the specified screen.
-- @param tag The only tag to view.
-- @tparam[opt=awful.screen.focused()] number screen The screen to view the tag on.
function sharedtags.viewonly(tag, screen)
    sharedtags.movetag(tag, screen)
    tag:view_only()
end

return setmetatable(sharedtags, { __call = function(...) return sharedtags.new(select(2, ...)) end })

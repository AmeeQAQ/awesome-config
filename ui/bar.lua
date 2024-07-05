-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")

-- Custom function to give rounded borders to the containers
function rounded_borders(cr, width, height) gears.shape.rounded_rect(cr, width, height, 5) end

-- Custom border color for each wibar widget group
local group_border_color = "#03f4fc"

-- {{{ Taglist
-- Buttons to use inside the taglist
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )
-- }}}

-- Small separator between widgets
local separator = wibox.widget.textbox()
separator.markup = "<span foreground='#ffffff'>  |  </span>"

-- Tilted separator
local tilted_separator = wibox.widget.textbox()
tilted_separator.markup = "<span foreground='#ffffff'>  /  </span>"


-- Spacer
local spacer = wibox.widget.textbox()
spacer.text = "  "
  


local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)


-- {{{ Taglist
	-- Names for each available workspace
    local names = { "󰅶 General", " Browser", " Terminal", " Games"}
    local l = awful.layout.suit -- alias
    awful.tag(names, s, awful.layout.layouts[1])
	
	-- Taglist widget
	s.mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.all,
		layout   = {
			spacing = 12,
			spacing_widget = {
				markup = "<span foreground='#ffffff'> / </span>",
				widget = wibox.widget.textbox,
			},
			layout  = wibox.layout.fixed.horizontal
		},
		buttons = taglist_buttons
	}

	-- Taglist container to set some options like shape
	workspaces = wibox.widget({
		s.mytaglist,
		shape = rounded_borders,
		bg = beautiful.bg_normal,
		border_width = 2.5,
		border_color = group_border_color,
		border_strategy = "inner",
		widget = wibox.container.background
	})
-- }}}
	
-- {{{ Tasklist
	-- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
		layout = {
			spacing = 17,
			spacing_widget = {
				widget = tilted_separator
			},
			layout = wibox.layout.flex.horizontal
		},
		style = {
			shape = rounded_borders,
		},
    }

	-- Tasklist container to set its shape
active_windows = wibox.widget ({
	s.mytasklist,
	shape = rounded_borders,
	bg = beautiful.bg_normal,
	border_width = 2.5,
	border_color = group_border_color,
	border_strategy = "inner",
	widget = wibox.container.background
})
-- }}}

-- Create a promptbox for each screen
s.mypromptbox = awful.widget.prompt()
-- Create an imagebox widget which will contain an icon indicating which layout we're using.
-- We need one layoutbox per screen.
s.mylayoutbox = awful.widget.layoutbox(s)
s.mylayoutbox:buttons(gears.table.join(
					   awful.button({ }, 1, function () awful.layout.inc( 1) end),
					   awful.button({ }, 3, function () awful.layout.inc(-1) end),
					   awful.button({ }, 4, function () awful.layout.inc( 1) end),
					   awful.button({ }, 5, function () awful.layout.inc(-1) end)))

s.mylayoutbox = wibox.container.margin(s.mylayoutbox, 2, 2, 2, 2)

--[[ Little greeting widget UNUSED
hellowidget = wibox.widget.textbox()
hellowidget.markup = "󰣇 Hello <b>" .. os.getenv("USER") .. "</b>!"
--]]	

-- Menu with power and log-in options
local ext_power = require("widgets.menu")

-- Script to return net status
local netstatus = require("widgets.netstatus")

-- Script to return memory usage (%)
local mem_usage = require("widgets.mem-usage")

-- Script to return CPU usage (%)
local cpu_usage = require("widgets.cpu-usage")

-- Script to return disk usage (%)
local disk_usage = require("widgets.disk-usage")

-- Date and clock widget
local date = require("widgets.date")

-- RPi health checker
local rpi_watcher = require("widgets.rpi-watcher")

-- Layout to hold all the right widgets
right_layout = wibox.widget({
	spacer,
	netstatus,
	tilted_separator,
	rpi_watcher,
	tilted_separator,
	mem_usage,
	tilted_separator,
	cpu_usage,
	tilted_separator,
	disk_usage,
	tilted_separator,
	date,
	tilted_separator,
	wibox.widget.systray(),
	tilted_separator,
	s.mylayoutbox,
	spacer,
	layout = wibox.layout.fixed.horizontal,
})

-- Container to hold all the right widgets
right_group = wibox.widget({
	right_layout,
	shape = rounded_borders,
	bg = beautiful.bg_normal,
	border_width = 2.5,
	border_color = group_border_color,
	border_strategy = "inner",
	widget = wibox.container.background
})

-- Create the wibox
s.mywibox = awful.wibar({ 	position = "top", 
							screen = s , 
							margins = {
								top = 6,
								left = 8,
								right = 8,
							},
							bg = "#00000000"
						})

-- Add widgets to the wibox
s.mywibox:setup {
	layout = wibox.layout.align.horizontal,
	{ -- Left widgets
		layout = wibox.layout.fixed.horizontal,
		workspaces,
		separator
		-- s.mypromptbox,
	},
	active_windows, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
			separator,
			right_group,
        },
    }
end)
-- }}}


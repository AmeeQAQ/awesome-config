local home = require("widgets.home-dir")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
-- Widget and layout library
local wibox = require("wibox")

-- {{{ Custom menu
-- This is a custom menu for power options
powermenu = awful.menu({items = {
				    {"   power off", "poweroff"},
				    {"   reboot", "reboot"},
				    {"   logout", function() awesome.quit() end},
				    {"󰒲   suspend", "systemctl suspend"}
				}
			})

powerbutton = awful.widget.launcher({ image = gears.surface.load_uncached(home .. "/.config/awesome/resources/power-button.png"),
				      menu  = powermenu})

return powerbutton
-- }}}

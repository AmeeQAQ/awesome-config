local home = require("widgets.home-dir")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Call netstatus.sh script in ~/Scripts
date = awful.widget.watch('bash ' .. home ..'"/Scripts/date.sh"', 1, function(widget, stdout)
	widget:set_markup(stdout)
end)

return date

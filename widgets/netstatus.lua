local home = require("widgets.home-dir")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Call netstatus.sh script in ~/Scripts
netstatus = awful.widget.watch('bash ' .. home ..'"/Scripts/netstatus.sh"', 10, function(widget, stdout)
	widget:set_markup(stdout)
end)

return netstatus

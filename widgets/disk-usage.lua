local home = require("widgets.home-dir")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Call netstatus.sh script in ~/Scripts
disk_usage = awful.widget.watch('bash ' .. home ..'"/Scripts/disk-usage.sh"', 30, function(widget, stdout)
	widget:set_markup(stdout)
end)

return disk_usage

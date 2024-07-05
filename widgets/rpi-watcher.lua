local home = require("widgets.home-dir")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Call netstatus.sh script in ~/Scripts
rpi_watcher = awful.widget.watch('bash ' .. home ..'"/Scripts/seraph_watcher.sh"', 60, function(widget, stdout)
	widget:set_markup(stdout)
end)

return rpi_watcher

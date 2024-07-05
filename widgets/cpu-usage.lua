-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Call netstatus.sh script in ~/Scripts
cpu_usage = awful.widget.watch('bash "/home/ame/Scripts/cpu-usage.sh"', 3, function(widget, stdout)
	widget:set_markup(stdout)
end)

return cpu_usage

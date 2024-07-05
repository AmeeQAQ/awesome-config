-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Call netstatus.sh script in ~/Scripts
mem_usage = awful.widget.watch('bash "/home/ame/Scripts/mem-usage.sh"', 3, function(widget, stdout)
	widget:set_markup(stdout)
end)

return mem_usage

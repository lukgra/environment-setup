-- init.lua
SBAR = require("sketchybar")
COLORS = require("COLORS")

SBAR.begin_config()

require("bar")
require("default")
require("items")

SBAR.end_config()

SBAR.event_loop()

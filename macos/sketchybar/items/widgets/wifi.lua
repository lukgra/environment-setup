local icons = require("icons")
local settings = require("settings")

local wifi = SBAR.add("item", "widgets.wifi", {
  position = "right",
  icon = {
    string = icons.wifi.disconnected,
    font = {
      style = settings.font.style_map["Bold"],
      size = 14.0,
    },
    color = COLORS.grey,
    padding_left = 8,
    padding_right = 4,
  },
  label = { drawing = false },
  updates = true,
})

local function update()
  SBAR.exec("ifconfig en0 2>/dev/null | awk '/status:/ {print $2}'", function(status)
    local connected = status:find("active") ~= nil
    wifi:set({
      icon = {
        string = connected and icons.wifi.connected or icons.wifi.disconnected,
        color = connected and COLORS.rose or COLORS.grey,
      },
    })
  end)
end

wifi:subscribe({ "wifi_change", "system_woke", "forced", "routine" }, update)
update()

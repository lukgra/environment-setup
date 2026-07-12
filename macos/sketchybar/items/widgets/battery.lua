local icons = require("icons")
local settings = require("settings")

local battery = SBAR.add("item", "widgets.battery", {
  position = "right",
  icon = {
    font = {
      family = settings.font.icons,
      style = settings.font.style_map["Bold"],
      size = 14.0,
    },
    padding_left = 8,
    padding_right = 4,
  },
  label = {
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 12.0,
    },
    color = COLORS.white,
    padding_right = 10,
  },
  update_freq = 30,
})

local remaining_time = SBAR.add("item", {
  position = "popup." .. battery.name,
  icon = {
    string = "Time remaining:",
    width = 110,
    align = "left",
    padding_left = 15,
  },
  label = {
    string = "??:??h",
    width = 110,
    align = "right",
    padding_right = 15,
  },
})

battery:subscribe({ "routine", "power_source_change", "system_woke", "brightness_change" }, function()
  SBAR.exec("pmset -g batt", function(batt_info)
    local icon = "!"
    local label = "?"

    local found, _, charge = batt_info:find("(%d+)%%")
    if found then
      charge = tonumber(charge)
      label = charge .. "%"
    end

    local charging = batt_info:find("AC Power")

    local color
    if charging then
      icon = icons.battery.charging
      color = COLORS.accent
    elseif found and charge > 60 then
      icon = icons.battery._100
      color = COLORS.accent
    elseif found and charge > 40 then
      icon = icons.battery._75
      color = COLORS.gold
    elseif found and charge > 20 then
      icon = icons.battery._50
      color = COLORS.orange
    elseif found and charge > 10 then
      icon = icons.battery._25
      color = COLORS.orange
    else
      icon = icons.battery._0
      color = COLORS.love
    end

    local lead = (found and charge < 10) and "0" or ""

    battery:set({
      icon = { string = icon, color = color },
      label = { string = lead .. label },
    })
  end)
end)

battery:subscribe("mouse.clicked", function(env)
  local drawing = battery:query().popup.drawing
  battery:set({ popup = { drawing = "toggle" } })

  if drawing == "off" then
    SBAR.exec("pmset -g batt", function(batt_info)
      local found, _, remaining = batt_info:find(" (%d+:%d+) remaining")
      local label = found and remaining .. "h" or "No estimate"
      remaining_time:set({ label = label })
    end)
  end
end)

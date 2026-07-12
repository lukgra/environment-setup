-- deafult.lua
local settings = require("settings")

SBAR.default({
  updates = "when_shown",
  icon = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Bold"],
      size = 13.0,
    },
    color = COLORS.white,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Bold"],
      size = 12.0,
    },
    color = COLORS.white,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  background = {
    height = 28,
    corner_radius = 14,
    border_color = COLORS.transparent,
    border_width = 0,
    color = COLORS.transparent,
  },
  popup = {
    background = {
      border_width = 1,
      corner_radius = 12,
      border_color = COLORS.popup.border,
      color = COLORS.popup.bg,
      shadow = { drawing = true },
    },
    blur_radius = 50,
  },
  padding_left = 4,
  padding_right = 4,
  scroll_texts = true,
})

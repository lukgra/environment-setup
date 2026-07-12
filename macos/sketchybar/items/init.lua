-- items/init.lua
require("items.apple")
require("items.spaces")

-- ──────────────── CENTER — LEFT of notch ──────────────────────
require("items.calendar")

SBAR.add("item", "center.notch", {
  position = "center",
  width = 250,
  icon = { drawing = false },
  label = { drawing = false },
  background = { color = COLORS.transparent },
})

-- ──────────────── CENTER — RIGHT of notch ─────────────────────
require("items.weather")

-- ─────────────────────────── RIGHT ────────────────────────────
require("items.widgets.battery")
require("items.widgets.wifi")
require("items.widgets.bluetooth")
require("items.widgets.volume")
-- -- require("items.widgets.cpu")
--
-- -- ══════════════════════════════════════════════════════════════
-- -- BRACKETS — drawn after all items are created
-- -- ══════════════════════════════════════════════════════════════
--
-- CORNER_RADIUS = 16
--
-- -- Left pill: Apple logo + Aerospace workspaces
-- sbar.add("bracket", "bracket.left", { "apple.logo", "/space\\..*/", "spaces.right_pad" }, {
--   background = {
--     color = colors.bg1,
--     corner_radius = CORNER_RADIUS,
--     height = 28,
--     border_width = 0,
--   },
-- })
--
-- -- Center notch pill: media — [notch] — time + date
-- -- The pill background spans both halves; the notch hardware creates the visual gap.
-- sbar.add("bracket", "bracket.media", {
--   "/^center\\.media.*/",
--   "center.notch",
--   "center.weather",
--   "center.time",
--   "center.date",
-- }, {
--   background = {
--     color = colors.bg3,
--     corner_radius = 4,
--     height = 24,
--     border_width = 0,
--   },
-- })
--
-- -- Right pill: WiFi + Bluetooth + Volume + Battery
-- sbar.add("bracket", "bracket.right", {
--   "widgets.wifi",
--   "widgets.bluetooth",
--   -- "widgets.cpu",
--   -- "widgets.cpu.percent",
--   -- "widgets.cpu.caption",
--   "widgets.volume",
--   "widgets.battery",
-- }, {
--   background = {
--     color = colors.bg1,
--     corner_radius = CORNER_RADIUS,
--     height = 28,
--     border_width = 0,
--   },
-- })

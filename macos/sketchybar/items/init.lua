-- items/init.lua
require("items.apple")
require("items.spaces")

-- ──────────────── CENTER — LEFT of notch ──────────────────────
require("items.media")

-- ──────────────── NOTCH ────────────────

SBAR.add("item", "center.notch", {
  position = "center",
  width = 210,
  icon = { drawing = false },
  label = { drawing = false },
  background = { color = COLORS.transparent },
})

-- ──────────────── CENTER — RIGHT of notch ─────────────────────
require("items.calendar")
require("items.weather")

-- ─────────────────────────── RIGHT ────────────────────────────
require("items.widgets.battery")
require("items.widgets.wifi")
require("items.widgets.bluetooth")
require("items.widgets.volume")

-- ══════════════════════════════════════════════════════════════
-- BRACKETS — drawn after all items are created
-- ══════════════════════════════════════════════════════════════

CORNER_RADIUS = 16

-- Left pill: Apple logo + Aerospace workspaces
SBAR.add("bracket", "bracket.left", { "apple.logo", "/space\\..*/" }, {
  background = {
    color = COLORS.bg1,
    corner_radius = CORNER_RADIUS,
    height = 28,
    border_width = 0,
  },
})

-- Center notch pill: media — [notch] — time + date
-- The pill background spans both halves; the notch hardware creates the visual gap.
SBAR.add("bracket", "bracket.media", {
  "center.time",
  "center.date",
  "center.notch",
  "center.weather",
}, {
  background = {
    color = COLORS.bg3,
    corner_radius = 4,
    height = 24,
    border_width = 0,
  },
})

-- Right pill: WiFi + Bluetooth + Volume + Battery
SBAR.add("bracket", "bracket.right", {
  "widgets.wifi",
  "widgets.bluetooth",
  "widgets.volume",
  "widgets.battery",
}, {
  background = {
    color = COLORS.bg1,
    corner_radius = CORNER_RADIUS,
    height = 28,
    border_width = 0,
  },
})

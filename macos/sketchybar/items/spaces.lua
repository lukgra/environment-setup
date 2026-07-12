local settings = require("settings")

-- Window manager backend. Swap to spaces_aerospace / spaces_omniwm and restart
-- sketchybar to switch. All modules expose: events, list_workspaces_cmd(),
-- fetch_state_cmd(), click_cmd(id), display_label(id).
local backend = require("items.spaces_omniwm")

-- Horizontal padding (in px) on each side of a space pill.
local pill_padding = {
  inactive = 14,
  active = 18,
}

local function exec_to_table(cmd)
  local handle = io.popen(cmd)
  if not handle then
    return {}
  end
  local result = handle:read("*a")
  handle:close()
  local lines = {}
  for line in result:gmatch("[^\n]+") do
    lines[#lines + 1] = line
  end
  return lines
end

local space_items = {}
local space_names = {}
local space_state = {}

local update_in_flight_at = 0
local update_dirty = false
local LOCK_TIMEOUT_S = 3

-- Simplified: always shows the workspace number/label as plain text.
-- No app-icon lookup, no sketchybar-app-font dependency.
local function build_space_set(selected, ws_label)
  local pad = selected and pill_padding.active or pill_padding.inactive

  return {
    drawing = true, -- always show every workspace pill, not just active/occupied
    label = { drawing = false },
    icon = {
      string = ws_label or "",
      color = selected and COLORS.base or COLORS.white,
      drawing = true,
      padding_left = pad,
      padding_right = pad,
    },
    background = {
      color = selected and COLORS.iris or COLORS.bg2,
    },
  }
end

local function update_all_spaces()
  local now = os.time()
  if update_in_flight_at ~= 0 and (now - update_in_flight_at) < LOCK_TIMEOUT_S then
    update_dirty = true
    return
  end
  update_in_flight_at = now

  SBAR.exec(backend.fetch_state_cmd(), function(output)
    update_in_flight_at = 0

    local focused = ""
    local parsing_windows = true

    -- We only need the focused workspace now; window/app lines are ignored.
    for line in output:gmatch("[^\n]+") do
      if line == "---" then
        parsing_windows = false
      elseif not parsing_windows then
        focused = line:gsub("%s+", "")
      end
    end

    local changed = {}
    for ws, space in pairs(space_items) do
      local selected = ws == focused
      local key = selected and "1" or "0"
      if space_state[ws] ~= key then
        space_state[ws] = key
        changed[#changed + 1] = {
          space = space,
          selected = selected,
          label = backend.display_label(ws),
        }
      end
    end

    for _, c in ipairs(changed) do
      c.space:set(build_space_set(c.selected, c.label))
    end

    if update_dirty then
      update_dirty = false
      update_all_spaces()
    end
  end)
end

local workspaces = exec_to_table(backend.list_workspaces_cmd())

for i, workspace in ipairs(workspaces) do
  local space = SBAR.add("item", "space." .. workspace:gsub("%s+", "_"), {
    icon = {
      font = { family = settings.font.text, style = settings.font.style_map["Bold"], size = 12 },
      string = workspace,
      color = COLORS.white,
      padding_left = pill_padding.inactive,
      padding_right = pill_padding.inactive,
      y_offset = 0,
      drawing = true,
    },
    label = { drawing = false },
    background = {
      color = COLORS.bg2,
      corner_radius = 16,
      height = 19,
    },
    padding_left = 6,
    padding_right = 0,
    drawing = true,
    click_script = backend.click_cmd(workspace),
  })

  space_items[workspace] = space
  space_names[i] = space.name
end

local observer = SBAR.add("item", {
  drawing = false,
  updates = true,
  update_freq = 5,
})

local subscribed_events = { "routine" }
for _, ev in ipairs(backend.events) do
  subscribed_events[#subscribed_events + 1] = ev
end
observer:subscribe(subscribed_events, function(env)
  update_all_spaces()
end)

update_all_spaces()

return space_names

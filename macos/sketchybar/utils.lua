function menubar_section(items)
  local _ = SBAR.add("bracket", items, {
    background = {
      color = COLORS.bar.bg,
      corner_radius = 16,
      height = 28,
      border_width = 1,
      border_color = COLORS.bar.border,
    },
  })
end

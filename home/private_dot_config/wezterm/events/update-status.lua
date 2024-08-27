local umath = require("utils.math")
local Cells = require("utils.cells")

return function(_config, wezterm)
  local nf = wezterm.nerdfonts

  local GLYPH_SEMI_CIRCLE_LEFT = nf.ple_left_half_circle_thick --[[ '' ]]
  local GLYPH_SEMI_CIRCLE_RIGHT = nf.ple_right_half_circle_thick --[[ '' ]]
  local GLYPH_KEY_TABLE = nf.md_table_key --[[ '󱏅' ]]
  local GLYPH_KEY = nf.md_key --[[ '󰌆' ]]

  local colors = {
    date = { fg = "#fab387", bg = "rgba(0, 0, 0, 0.4)" },
    battery = { fg = "#f9e2af", bg = "rgba(0, 0, 0, 0.4)" },
    glyph_semi_circle = { bg = "rgba(0, 0, 0, 0.4)", fg = "#fab387" },
    left_text = { bg = "#fab387", fg = "#1c1b19" },
  }

  local SEPARATOR = {
    char = nf.oct_dash .. " ",
    fg = "#74c7ec",
    bg = "rgba(0, 0, 0, 0.4)",
  }

  local SEPARATOR_CHAR = nf.oct_dash .. " "

  local left = Cells:new()
  local right = Cells:new()

  local discharging_icons = {
    nf.md_battery_10,
    nf.md_battery_20,
    nf.md_battery_30,
    nf.md_battery_40,
    nf.md_battery_50,
    nf.md_battery_60,
    nf.md_battery_70,
    nf.md_battery_80,
    nf.md_battery_90,
    nf.md_battery,
  }
  local charging_icons = {
    nf.md_battery_charging_10,
    nf.md_battery_charging_20,
    nf.md_battery_charging_30,
    nf.md_battery_charging_40,
    nf.md_battery_charging_50,
    nf.md_battery_charging_60,
    nf.md_battery_charging_70,
    nf.md_battery_charging_80,
    nf.md_battery_charging_90,
    nf.md_battery_charging,
  }

  local _set_date = function(cells)
    local date = wezterm.strftime(" %a %H:%M:%S")
    cells:push({
      {
        date,
        icon = nf.fa_calendar,
        fg = colors.date.fg,
        bg = colors.date.bg,
        separator = SEPARATOR,
      },
    })
  end

  local _set_battery = function(cells)
    -- ref: https://wezfurlong.org/wezterm/config/lua/wezterm/battery_info.html

    local charge = ""
    local icon = ""

    for _, b in ipairs(wezterm.battery_info()) do
      local idx = umath.clamp(umath.round(b.state_of_charge * 10), 1, 10)
      charge = string.format("%.0f%%", b.state_of_charge * 100)

      if b.state == "Charging" then
        icon = charging_icons[idx]
      else
        icon = discharging_icons[idx]
      end
    end

    cells:push({
      {
        charge,
        icon = icon,
        fg = colors.battery.fg,
        bg = colors.battery.bg,
      },
    })
  end

  wezterm.on("update-status", function(window, _pane)
    left:clear()
    right:clear()

    _set_date(right)
    _set_battery(right)

    local key_table = window:active_key_table()

    if key_table then
      left:push({
        {
          GLYPH_SEMI_CIRCLE_LEFT,
          fg = colors.glyph_semi_circle.fg,
          bg = colors.glyph_semi_circle.bg,
        },
        {
          GLYPH_KEY_TABLE .. " " .. string.upper(key_table),
          fg = colors.left_text.fg,
          bg = colors.left_text.bg,
        },
        {
          GLYPH_SEMI_CIRCLE_RIGHT,
          fg = colors.glyph_semi_circle.fg,
          bg = colors.glyph_semi_circle.bg,
        },
      })
    end

    if window:leader_is_active() then
      left:push({
        {
          GLYPH_SEMI_CIRCLE_LEFT,
          fg = colors.glyph_semi_circle.fg,
          bg = colors.glyph_semi_circle.bg,
        },
        { " " .. GLYPH_KEY .. " ", fg = colors.left_text.fg, bg = colors.left_text.bg },
        {
          GLYPH_SEMI_CIRCLE_RIGHT,
          fg = colors.glyph_semi_circle.fg,
          bg = colors.glyph_semi_circle.bg,
        },
      })
    end

    window:set_left_status(wezterm.format(left:entries()))
    window:set_right_status(wezterm.format(right:entries()))
  end)
end

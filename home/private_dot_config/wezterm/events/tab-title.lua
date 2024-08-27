local Cells = require("utils.cells")

-- Inspired by https://github.com/wez/wezterm/discussions/628#discussioncomment-1874614
return function(_config, wezterm)
  local nf = wezterm.nerdfonts

  local GLYPH_SEMI_CIRCLE_LEFT = nf.ple_left_half_circle_thick --[[ '' ]]
  local GLYPH_SEMI_CIRCLE_RIGHT = nf.ple_right_half_circle_thick --[[ '' ]]
  local GLYPH_CIRCLE = nf.fa_circle --[[ '' ]]
  local GLYPH_ADMIN = nf.md_shield_half_full --[[ '󰞀' ]]

  local tab_format = Cells:new()

  local colors = {
    default = { bg = "#45475a", fg = "#1c1b19" },
    is_active = { bg = "#7FB4CA", fg = "#11111b" },
    hover = { bg = "#587d8c", fg = "#1c1b19" },
  }

  local _set_process_name = function(s)
    local a = string.gsub(s, "(.*[/\\])(.*)", "%2")
    return a:gsub("%.exe$", "")
  end

  local _set_title = function(process_name, base_title, max_width, inset)
    local title
    inset = inset or 6

    if #process_name > 0 and #base_title > 0 then
      title = process_name .. " | " .. base_title
    elseif #process_name > 0 then
      title = process_name
    elseif #base_title > 0 then
      title = base_title
    else
      title = "unknown"
    end

    if #title > max_width - inset then
      local diff = #title - max_width + inset
      title = wezterm.truncate_right(title, #title - diff)
    end

    return title
  end

  local _check_if_admin = function(p)
    if p:match("^Administrator: ") then
      return true
    end
    return false
  end

  wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, hover, max_width)
    tab_format:clear()

    local bg
    local fg
    local process_name = _set_process_name(tab.active_pane.foreground_process_name)
    local is_admin = _check_if_admin(tab.active_pane.title)
    local title =
      _set_title(process_name, tab.active_pane.title, max_width, (is_admin and 8))

    if tab.is_active then
      bg = colors.is_active.bg
      fg = colors.is_active.fg
    elseif hover then
      bg = colors.hover.bg
      fg = colors.hover.fg
    else
      bg = colors.default.bg
      fg = colors.default.fg
    end

    local has_unseen_output = false
    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        has_unseen_output = true
        break
      end
    end

    -- Left semi-circle
    tab_format:push({ { GLYPH_SEMI_CIRCLE_LEFT, bg = "rgba(0, 0, 0, 0.4)", fg = bg } })

    -- Admin Icon
    if is_admin then
      tab_format:push({ { " " .. GLYPH_ADMIN, fg = fg, bg = bg } })
    end

    -- Title
    tab_format:push({ { " " .. title, fg = fg, bg = bg } })

    -- Unseen output alert
    if has_unseen_output then
      tab_format:push({ { " " .. GLYPH_CIRCLE, bg = bg, fg = "#FFA066" } })
    end

    tab_format:push({
      -- Right padding
      { " ", fg = fg, bg = bg },
      -- Right semi-circle
      { GLYPH_SEMI_CIRCLE_RIGHT, bg = "rgba(0, 0, 0, 0.4)", fg = bg },
    })

    return tab_format:entries()
  end)
end

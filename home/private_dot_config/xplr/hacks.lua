xplr.config.modes.builtin.default.key_bindings.on_key["ctrl-n"] = {
  help = "new session",
  messages = {
    {
      BashExecSilently = [===[
        osascript <<EOF
        tell application "iTerm2"
          tell current window
            create tab with default profile
            tell current session to write text "xplr"
          end tell
        end tell
      ]===],
    },
  },
}

xplr.config.modes.builtin.default.key_bindings.on_key.m = {
  help = "bookmark",
  messages = {
    {
      BashExecSilently0 = [===[
        PTH="${XPLR_FOCUS_PATH:?}"
        PTH_ESC=$(printf %q "$PTH")
        if echo "${PTH:?}" >> "${XPLR_SESSION_PATH:?}/bookmarks"; then
          "$XPLR" -m 'LogSuccess: %q' "$PTH_ESC added to bookmarks"
        else
          "$XPLR" -m 'LogError: %q' "Failed to bookmark $PTH_ESC"
        fi
      ]===],
    },
  },
}

xplr.config.modes.builtin.default.key_bindings.on_key["`"] = {
  help = "go to bookmark",
  messages = {
    {
      BashExec0 = [===[
        PTH=$(cat "${XPLR_SESSION_PATH:?}/bookmarks" | fzf --no-sort)
        PTH_ESC=$(printf %q "$PTH")
        if [ "$PTH" ]; then
          "$XPLR" -m 'FocusPath: %q' "$PTH"
        fi
      ]===],
    },
  },
}

-- With `export XPLR_BOOKMARK_FILE="$HOME/bookmarks"`
-- Bookmark: mode binding
xplr.config.modes.builtin.default.key_bindings.on_key["b"] = {
  help = "bookmark mode",
  messages = {
    { SwitchModeCustom = "bookmark" },
  },
}
xplr.config.modes.custom.bookmark = {
  name = "bookmark",
  key_bindings = {
    on_key = {
      m = {
        help = "bookmark dir",
        messages = {
          {
            BashExecSilently0 = [[
              PTH="${XPLR_FOCUS_PATH:?}"
              if [ -d "${PTH}" ]; then
                PTH="${PTH}"
              elif [ -f "${PTH}" ]; then
                PTH=$(dirname "${PTH}")
              fi
              PTH_ESC=$(printf %q "$PTH")
              if echo "${PTH:?}" >> "${XPLR_BOOKMARK_FILE:?}"; then
                "$XPLR" -m 'LogSuccess: %q' "$PTH_ESC added to bookmarks"
              else
                "$XPLR" -m 'LogError: %q' "Failed to bookmark $PTH_ESC"
              fi
            ]],
          },
          "PopMode",
        },
      },
      g = {
        help = "go to bookmark",
        messages = {
          {
            BashExec0 = [===[
              PTH=$(cat "${XPLR_BOOKMARK_FILE:?}" | fzf --no-sort)
              if [ "$PTH" ]; then
                "$XPLR" -m 'FocusPath: %q' "$PTH"
              fi
            ]===],
          },
          "PopMode",
        },
      },
      d = {
        help = "delete bookmark",
        messages = {
          {
            BashExec0 = [[
              PTH=$(cat "${XPLR_BOOKMARK_FILE:?}" | fzf --no-sort)
              sd "$PTH\n" "" "${XPLR_BOOKMARK_FILE:?}"
            ]],
          },
          "PopMode",
        },
      },
      esc = {
        help = "cancel",
        messages = {
          "PopMode",
        },
      },
    },
  },
}

-- xplr.config.modes.builtin.go_to.key_bindings.on_key.b = {
--   help = "bookmark jump",
--   messages = {
--     "PopMode",
--     { BashExec0 = [===[
--         field='\(\S\+\s*\)'
--         esc=$(printf '\033')
--         N="${esc}[0m"
--         R="${esc}[31m"
--         G="${esc}[32m"
--         Y="${esc}[33m"
--         B="${esc}[34m"
--         pattern="s#^${field}${field}${field}${field}#$Y\1$R\2$N\3$B\4$N#"
--         PTH=$(sed 's#: # -> #' "$PATHMARKS_FILE"| nl| column -t \
--         | gsed "${pattern}" \
--         | fzf --ansi \
--             --height '40%' \
--             --preview="echo {}|sed 's#.*->  ##'| xargs exa --color=always" \
--             --preview-window="right:50%" \
--         | sed 's#.*->  ##')
--         if [ "$PTH" ]; then
--           "$XPLR" -m 'ChangeDirectory: %q' "$PTH"
--         fi
--       ]===]
--     },
--   }
-- }

xplr.config.modes.builtin.go_to.key_bindings.on_key.h = {
  help = "history",
  messages = {
    "PopMode",
    {
      BashExec0 = [===[
        PTH=$(cat "${XPLR_PIPE_HISTORY_OUT:?}" | sort -z -u | fzf --read0)
        if [ "$PTH" ]; then
          "$XPLR" -m 'ChangeDirectory: %q' "$PTH"
        fi
      ]===],
    },
  },
}

xplr.config.modes.builtin.default.key_bindings.on_key.R = {
  help = "batch rename",
  messages = {
    {
      BashExec = [===[
       SELECTION=$(cat "${XPLR_PIPE_SELECTION_OUT:?}")
       NODES=${SELECTION:-$(cat "${XPLR_PIPE_DIRECTORY_NODES_OUT:?}")}
       if [ "$NODES" ]; then
         echo -e "$NODES" | renamer
         "$XPLR" -m ExplorePwdAsync
       fi
     ]===],
    },
  },
}

xplr.config.modes.builtin.default.key_bindings.on_key.S = {
  help = "serve $PWD",
  messages = {
    {
      BashExec0 = [===[
        IP=$(ip addr | grep -w inet | cut -d/ -f1 | grep -Eo '[0-9]{1,3}\.[0-9]{      1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | fzf --prompt 'Select IP > ')
        echo "IP: ${IP:?}"
        read -p "Port (default 5000): " PORT
        echo
        sfz --all --cors --no-ignore --bind ${IP:?} --port ${PORT:-5000} . &
        sleep 1 && read -p '[press enter to exit]'
        kill -9 %1
      ]===],
    },
  },
}

local function stat(node)
  return node.mime_essence
end

local function read(path, height)
  local p = io.open(path)

  if p == nil then
    return nil
  end

  local i = 0
  local res = ""
  for line in p:lines() do
    if line:match("[^ -~\n\t]") then
      p:close()
      return
    end

    res = res .. line .. "\n"
    if i == height then
      break
    end
    i = i + 1
  end
  p:close()

  return res
end

xplr.config.layouts.builtin.default = {
  Horizontal = {
    config = {
      constraints = {
        { Percentage = 60 },
        { Percentage = 40 },
      },
    },
    splits = {
      "Table",
      {
        CustomContent = {
          title = "preview",
          body = { DynamicParagraph = { render = "custom.preview_pane.render" } },
        },
      },
    },
  },
}

xplr.fn.custom.preview_pane = {}
xplr.fn.custom.preview_pane.render = function(ctx)
  local n = ctx.app.focused_node

  if n and n.canonical then
    n = n.canonical
  end

  if n then
    if n.is_file then
      return read(n.absolute_path, ctx.layout_size.height)
    else
      return stat(n)
    end
  else
    return ""
  end
end

xplr.config.modes.builtin.default.key_bindings.on_key.T = {
  help = "tere nav",
  messages = {
    { BashExec0 = [[xplr -m 'ChangeDirectory: %q' "$(command tere)"]] },
  },
}

-- local c = {}

-- table.insert(xplr.config.general.table.header.cols, 1, { format = "visits" })

-- table.insert(
--   xplr.config.general.table.row.cols,
--   1,
--   { format = "custom.fmt_directory_visits" }
-- )

-- table.insert(xplr.config.general.table.col_widths, 1, { Length = 3 })

-- xplr.fn.custom.on_directory_change = function(app)
--   c[app.pwd] = (c[app.pwd] or 0) + 1
--   return {
--     "Refresh",
--   }
-- end

-- xplr.fn.custom.fmt_directory_visits = function(m)
--   return tostring(c[m.absolute_path] or 0)
-- end

-- return {
--   on_directory_change = {
--     { CallLuaSilently = "custom.on_directory_change" },
--   },
-- }

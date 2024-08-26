local platform = require("utils.platform")

return function(config, wezterm)
  local op_auth = string.format("%s/.1password/agent.auth", wezterm.home_dir)

  if platform.is_mac then
    op_auth = string.format(
      "%s/Library/Group Containers/*.com.1password/t/agent.auth",
      wezterm.home_dir
    )
  end

  if #wezterm.glob(op_auth) == 1 then
    op_auth = wezterm.glob(op_auth)[1]

    if os.getenv("SSH_AUTH_SOCK") ~= op_auth then
      config.default_ssh_auth_sock = op_auth
    end
  end
end

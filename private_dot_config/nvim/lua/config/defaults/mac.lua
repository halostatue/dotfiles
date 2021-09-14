if not vim.fn['hz#is']('mac') then
  return
end

-- Apply basic Unix configurations first.
require('config.defaults.unix')

local status_line = function(plugin, options)
  options = options or {}

  if plugin == 'galaxyline' then
    return { -- https://github.com/glepnir/galaxyline.nvim
      'glepnir/galaxyline.nvim',
      branch = 'main',
      event = { 'VeryLazy' },
      config = function() require(options.name).setup() end,
    }
  elseif plugin == 'feline' then
    return { -- https://github.com/feline-nvim/feline.nvim
      'feline-nvim/feline.nvim',
      event = { 'VeryLazy' },
      config = function()
        local feline = require('feline')
        feline.setup()
        feline.winbar.setup()
      end,
    }
  elseif plugin == 'lualine' then
    return { -- https://github.com/nvim-lualine/lualine.nvim
      'nvim-lualine/lualine.nvim',
      config = {
        options = {
          icons_enabled = false,
          component_separators = { left = '▷', right = '◁' },
          section_separators = { left = '▶', right = '◀0' },
        },
      },
    }
  end
end

return {
  status_line(),
}

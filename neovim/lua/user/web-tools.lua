--[[local status_ok, web_tools = pcall(require, "web-tools")
if not status_ok then
	return
end
require ("web-tools").setup()

local create_cmd = function(cmd, func, opt)
  opt = vim.tbl_extend('force', { desc = 'web-tools ' .. cmd }, opt or {})
  vim.api.nvim_create_user_command(cmd, func, opt)
end
create_cmd( 'BrowserSync', function(opts) require"web-tools".run(opts.args) end, { nargs = '*' })
create_cmd( 'BrowserPreview', function(opts)
  require"web-tools".preview(opts.fargs) end, { nargs = '*' })
create_cmd( 'BrowserRestart', function(opts) require"web-tools".restart(opts.fargs) end, { nargs = '*' })
create_cmd( 'BrowserStop', function() require"web-tools".stop() end)
create_cmd( 'BrowserOpen', function(opts)
  require"web-tools".open(opts.fargs) end, { nargs = '*' })
create_cmd( 'TagRename', function(opts) require"web-tools".rename(opts) end, { nargs = '*' })
--]]

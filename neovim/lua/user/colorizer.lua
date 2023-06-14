local cmp_status_ok, cmp = pcall(require, "clorizer")
if not cmp_status_ok then
  return
end
require 'colorizer'.setup()


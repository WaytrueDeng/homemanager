local cmp_status_ok, cmp = pcall(require, "leap")
if not cmp_status_ok then
  return
end

require('leap').add_default_mappings()

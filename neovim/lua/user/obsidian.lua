local status_ok, obsidian = pcall(require, "obsidian")
if not status_ok then
	return
end

require("obsidian").setup({
  dir = "~/Documents/roam/obsidian/",
  use_advanced_uri = true,
  completion = {
    nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
  },
  notes_subdir = "notes",
  note_frontmatter_func = function(note)
    local out = { title = note.title, tags = note.tags }
    -- `note.metadata` contains any manually added fields in the frontmatter.
    -- So here we just make sure those fields are kept in the frontmatter.
    if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end
    return out
  end,
  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    local suffix = ""
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title
    else
        suffix = title
    end
    return  suffix
  end
})

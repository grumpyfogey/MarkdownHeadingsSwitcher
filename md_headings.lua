-- Create a local list of md-headings


-- Text-assembly

-- Translate heading level to spaces
local shifts_before_heading = { ["#"] = "",  ["##"] = "  ",  ["###"] = "    ",  
  ["####"] = "      ", ["#####"] = "        ", ["######"] = "          "}

-- Join spaces + headings
local formated_heading = function (str)
_, _ , level, heading = string.find(str, "^%s*(#+)%s+(.*)%s*$")

return shifts_before_heading[level]..heading
end


local function qfHeadingsFormat(info)
-- info of the entires of the loc list (loc list isn't the actual buffer, therefore getting the info from winid
  local items = vim.fn.getloclist(info.winid)

local l = {}

  for idx = info.start_idx, info.end_idx do
    table.insert(l, string.format("%3d", items[idx].lnum)..": ".. formated_heading(items[idx].text))
  end

  return l
end

local function loc_list_md_headings()
-- I wasn't able to use the regex-pattern as a attribute in vim.cmd, therefore [[  ]]
  vim.cmd([[lvimgrep/^\s*#\{1,6}\s/ %]])

  local qfWinId = vim.fn.getloclist(0, {winid = 0}).winid

  vim.fn.setloclist(0, {}, 'r',
    { title = "MdHeadings", winid = qfWinId, quickfixtextfunc = qfHeadingsFormat })

end

vim.api.nvim_create_user_command("MdHeadings", loc_list_md_headings, {})


-- Create a local list of md-headings

-- Text-Zusammenbau
-- Heading level in Leerzeichen übersetzen
local shifts_before_heading = { ["#"] = "",  ["##"] = "  ",  ["###"] = "    ",  
  ["####"] = "      ", ["#####"] = "        ", ["######"] = "          "}

-- Leerzeichen + Überschrift zusammenfügen
local formated_heading = function (str)
_, _ , level, heading = string.find(str, "^%s*(#+)%s+(.*)%s*$")

return shifts_before_heading[level]..heading
end


local function qfHeadingsFormat(info)
-- Infos der Einträge der loc list (loc list ist nicht aktueller buffer, daher über winid sich die Infos besorgen
  local items = vim.fn.getloclist(info.winid)

local l = {}

  for idx = info.start_idx, info.end_idx do
    table.insert(l, string.format("%3d", items[idx].lnum)..": ".. formated_heading(items[idx].text))
  end

  return l
end

local function loc_list_md_headings()
-- Ich war nicht in der Lage das regex-Pattern als Attribut in vim.cmd zu übergeben, daher [[  ]]
  vim.cmd([[lvimgrep/^\s*#\{1,6}\s/ %]])

  local qfWinId = vim.fn.getloclist(0, {winid = 0}).winid

  vim.fn.setloclist(0, {}, 'r',
    { title = "MdHeadings", winid = qfWinId, quickfixtextfunc = qfHeadingsFormat })

end

vim.api.nvim_create_user_command("MdHeadings", loc_list_md_headings, {})


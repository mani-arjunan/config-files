local output = {}

local function split_lines(text)
  local lines = {}
  for line in (text .. "\n"):gmatch("(.-)\n") do
    table.insert(lines, line)
  end
  return lines
end

function output.insert_text_inside_function(context, lines)
  if not context or not context.end_row then
    vim.notify("AI Helper:: Invalid context", vim.log.levels.ERROR)
    return
  end

  local insert_row = context.end_row - 1
  vim.api.nvim_buf_set_lines(0, insert_row, insert_row, false, lines)
  vim.notify("[ai-helper] Inserted AI-generated function body")
end

function output.insert_text(text)
  local lines = split_lines(text)
  vim.api.nvim_put(lines, "l", true, true)
end

return output

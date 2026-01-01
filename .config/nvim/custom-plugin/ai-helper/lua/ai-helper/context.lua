local context = {}

local function get_root(bufnr)
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok or not parser then return nil end
  local tree = parser:parse()[1]
  return tree and tree:root() or nil
end

local function get_function_node(bufnr, row, col)
  local root = get_root(bufnr)
  if not root then return nil end
  local lang = vim.bo.filetype

  local fn_nodes = {
    javascript = { "function_declaration", "arrow_function", "method_definition" },
    typescript = { "function_declaration", "arrow_function", "method_definition" },
    lua = { "function_declaration" },
    go = { "function_declaration", "method_declaration" },
    rust = { "function_item" },
    python = { "function_definition" },
  }

  local wanted = fn_nodes[lang] or {}
  local function is_function_node(node)
    for _, t in ipairs(wanted) do
      if node:type() == t then return true end
    end
    return false
  end

  local node = root:named_descendant_for_range(row, col, row, col)
  while node do
    if is_function_node(node) then return node end
    node = node:parent()
  end
  return nil
end

function context.get_context_for_completion()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]
  local filetype = vim.bo.filetype

  local full_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local full_code = table.concat(full_lines, "\n")

  local fn_node = get_function_node(bufnr, row, col)
  if not fn_node then
    vim.notify("AI Helper:: No function found under cursor", vim.log.levels.WARN)
    return nil
  end

  local start_row, _, end_row, _ = fn_node:range()
  local fn_lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row, false)
  local fn_code = table.concat(fn_lines, "\n")

  return {
    filetype = filetype,
    full_code = full_code,
    fn_code = fn_code,
    start_row = start_row,
    end_row = end_row,
  }
end

return context

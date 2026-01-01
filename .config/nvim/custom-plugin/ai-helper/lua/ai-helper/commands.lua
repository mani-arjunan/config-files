local command = {}

function command.setup()
  vim.api.nvim_create_user_command("AICompleteV2", function()
    local context = require("ai-helper.context").get_context_for_completion()
    if not context then return end

    local row = vim.api.nvim_win_get_cursor(0)[1] - 1
    local loader_line = "AI is working rn..."

    local current_line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

    if current_line == "" or current_line == nil then
      vim.api.nvim_buf_set_lines(0, row, row + 1, false, { loader_line })
    else
      local new_line = current_line .. " " .. loader_line
      vim.api.nvim_buf_set_lines(0, row, row + 1, false, { new_line })
    end

    vim.cmd("redraw")
    vim.cmd("echo '(please wait)'")

    context.chat_history = {
      {
        role = "system",
        content = "You are a helpful expert coding assistant that writes clean, idiomatic code, No comments Please",
      },
      {
        role = "user",
        content = string.format(
          [[
            You are an expert %s developer.
            Here is the full source file for context:

            %s

            Your task:
            - Update ONLY the body of the following function: %s
            - You may define small helper or sub-functions if you think it improves readability or design.
            - Do not modify unrelated parts of the file.
            - Return the entire updated source file, preserving original formatting and style.
            - Do NOT wrap the output in code fences.
          ]],
          context.filetype,
          context.full_code,
          context.fn_code
        ),
      },
    }

    local response = require("ai-helper.api").call(context.chat_history)

    vim.api.nvim_buf_set_lines(0, row, row + 1, false, {})

    if not response or response == "" then
      vim.notify("[ai-helper] Empty response from LLM", vim.log.levels.WARN)
      return
    end

    response = response:gsub("^```[a-zA-Z]*", "")
    response = response:gsub("```$", "")
    response = vim.trim(response)

    require("ai-helper.ui").show_output(context, response)
  end, {})
end

return command

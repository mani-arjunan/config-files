local regen = {}

function regen.regenerate(ctx, previous_output)
  ctx.chat_history = ctx.chat_history or {}

  table.insert(ctx.chat_history, {
    role = "user",
    content = string.format(
      "This output was not satisfactory:\n```%s```\nPlease generate a better one.",
      previous_output
    ),
  })

  local response = require("ai-helper.api").call(ctx.chat_history)
  response = vim.trim((response:gsub("^```[a-zA-Z]*", ""):gsub("```$", "")))

  require("ai-helper.ui").show_output(ctx, response)
end

return regen

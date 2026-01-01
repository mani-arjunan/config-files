local config = require("ai-helper").get_config()
local curl = require("plenary.curl")
local llm_client = {}

function llm_client.call(messages)
  if not config.api_key then
    vim.notify("AI Helper:: Missing API Key", vim.log.levels.ERROR)
    return ""
  end

  if type(messages) == "string" then
    messages = {
      { role = "system", content = "You are a helpful coding assistant, Please" },
      { role = "user", content = messages },
    }
  end

  local res = curl.post(config.llm_url .. "/v1/chat/completions" or "https://api.openai.com/v1/chat/completions", {
    headers = {
      ["Authorization"] = "Bearer " .. config.api_key,
      ["Content-Type"] = "application/json",
    },
    body = vim.json.encode({
      model = config.model or "gpt-4o-mini",
      messages = messages,
    }),
    timeout = (config.timeout or 30000),
  })

  if not res or not res.body then
    vim.notify("AI Helper:: No response from API", vim.log.levels.ERROR)
    return ""
  end

  local ok, decoded = pcall(vim.fn.json_decode, res.body)

  if not ok or not decoded.choices or not decoded.choices[1] then
    vim.notify("AI Helper:: Invalid response", vim.log.levels.ERROR)
    return ""
  end

  return decoded.choices[1].message.content
end

return llm_client

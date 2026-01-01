local ai_helper = {}

ai_helper.config = {}

function ai_helper.get_config()
  return ai_helper.config
end

function ai_helper.setup(opts)
  local defaults = {
    provider = "openai",
    llm_url   = "",
    model     = "gpt-4o-mini",
    api_key   = os.getenv("OPENAI_API_KEY"),
    timeout   = 120000,
    context_radius = 10,
  }

  ai_helper.config = vim.tbl_deep_extend("force", defaults, opts or {})

  require("ai-helper.commands").setup()
end

return ai_helper

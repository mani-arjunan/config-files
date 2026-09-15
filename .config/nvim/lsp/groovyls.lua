---@brief
---
--- https://github.com/prominic/groovy-language-server.git
---
--- requirements:
---  - linux/macos (for now)
---  - java 11+
---
--- `groovyls` can be installed by following the instructions [here](https://github.com/prominic/groovy-language-server.git#build).
---
--- if you have installed groovy language server, you can set the `cmd` custom path as follow:
---
--- ```lua
--- vim.lsp.config('groovyls', {
---     -- unix
---     cmd = { "java", "-jar", "path/to/groovyls/groovy-language-server-all.jar" },
---     ...
--- })
--- ```

---@type vim.lsp.config
return {
  -- when installed via mason
  cmd = { 'groovy-language-server' },
  -- if installed/built locally, please provide the correct filepath to java.
  -- cmd = {
  --   'java',
  --   '-jar',
  --   'groovy-language-server-all.jar',
  -- },
  filetypes = { 'groovy' },
  root_markers = { 'jenkinsfile', '.git' },
  vim.filetype.add({
    pattern = {
      [".*%.Jenkinsfile"] = "groovy",
    },
  })
}

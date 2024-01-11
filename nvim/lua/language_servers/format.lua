-- disable all format, use conform with mason
local format = {
  formatting_options = nil,
  timeout_ms = nil,
}
require("lspconfig.util").default_config.format = format

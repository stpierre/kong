local typedefs = require "kong.db.schema.typedefs"

local severity = {
  type = "string",
  default = "info",
  one_of = { "debug", "info", "notice", "warning", "err", "crit", "alert", "emerg" },
}

return {
  name = "loggly",
  fields = {
    { protocols = typedefs.protocols },
    { config = {
        type = "record",
        fields = {
          { host = typedefs.host({ default = "logs-01.loggly.com" }), },
          { port = typedefs.port({ default = 514 }), },
          { key = { type = "string", required = true, encrypted = true }, }, -- encrypted = true is a Kong Enterprise Exclusive feature, it does nothing in Kong CE
          { tags = {
              type = "set",
              default = { "kong" },
              elements = { type = "string" },
          }, },
          { log_level = severity },
          { successful_severity = severity },
          { client_errors_severity = severity },
          { server_errors_severity = severity },
          { timeout = { type = "number", default = 10000 }, },
          { custom_fields_by_lua = typedefs.lua_code },
        },
      },
    },
  },
}

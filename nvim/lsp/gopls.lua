return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      vulncheck = "Imports",
      hints = {
        assignVariableTypes = true,
        -- compositeLiteralFields = true,
        -- compositeLiteralTypes = true,
        -- constantValues = true,
        -- functionTypeParameters = true,
        -- parameterNames = true,
        -- rangeVariableTypes = true
      }
    },
  }
}

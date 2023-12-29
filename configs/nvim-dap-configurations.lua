dap = require "dap"

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return require("xmake.project_config").info.target.exec_path
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

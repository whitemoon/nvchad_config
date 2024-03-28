local M = {}

M.dapui = function(_, opts)
  -- setup dap config by VsCode launch.json file
  -- require("dap.ext.vscode").load_launchjs()
  local dap = require "dap"
  local dapui = require "dapui"
  dapui.setup(opts)
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open {}
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close {}
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close {}
  end
end

M.dap = function()
  vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
  local dap = require "dap"

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
end

return M

local dap = require('dap')

dap.listeners.before.event_terminated["terminal_close"] = function()
  vim.cmd('FloatermKill debug')
end

dap.adapters.go = function(callback, config)
  local port = 38697
  -- name: floaterm name
  vim.cmd('FloatermNew! --name=debug --silent dlv dap -l 127.0.0.1:38697 --log --log-dest /dev/null')

  ----should we wait for delve to start???
  vim.defer_fn(
  function()
    callback({type = "server", host = "127.0.0.1", port = port})
  end,
  3000)

  -- callback({type = "server", host = "127.0.0.1", port = port})
end

 -- dap.configurations.go = {
 --    {
 --      type = "go",
 --      name = "Debug test", -- configuration for debugging test files
 --      request = "launch",
 --      mode = "test",
 --      program = "${workspaceFolder}/pkg/scheduler/test"
 --    }
-- }

-- azure
dap.configurations.go = {
  {
    type = "go";
    name = "Debug";
    request = "launch";
    program = "${workspaceFolder}/cmd/notify/main.go";
    args = {"--config", "/etc/yunion/notify.conf"}
  }
    -- args = {"--config", "/etc/yunion/notify.conf"}
}

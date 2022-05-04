require('cmake').setup({
  dap_configuration = {
    type = 'codelldb',
    request = 'launch',
    stopOnEntry = false,
    runInTerminal = false,
  }
})

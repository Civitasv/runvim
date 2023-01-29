local gtest = {}

gtest.run_test = function()
  vim.ui.input({ prompt = "Please input test name which you want to execute: " }, function(input)
    vim.cmd("term " .. "--gtest-filter=" .. input)
  end)
end

return gtest

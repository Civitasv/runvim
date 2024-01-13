return {
  "CRAG666/code_runner.nvim",
  config = function()
    local code_runner = require("code_runner")

    code_runner.setup({
      mode = "term",
      startinsert = true,
      filetype = {
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        python = "python3 -u",
        typescript = "deno run",
        rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
        c = "cd $dir && mkdir -p bin && cd bin && gcc ../$fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
        cpp = "cd $dir && mkdir -p bin && cd bin && g++ ../$fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
        haskell = "ghc $fileName && ./$fileNameWithoutExt"
      },
      project = {}
    })
  end
}

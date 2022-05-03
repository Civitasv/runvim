local code_runner_status_ok, code_runner = pcall(require, "code_runner")

if not code_runner_status_ok then
  return
end

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
  },
  project = {}
})

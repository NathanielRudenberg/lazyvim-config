return {
  {
    "lervag/vimtex",
    init = function()
      local project_root = vim.fn.getcwd()
      local outdir = project_root .. "/output"

      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        out_dir = outdir,
        options = {
          "-synctex=1",
          "-interaction=nonstopmode",
          "-file-line-error",
          -- "-xelatex",
          -- "-norc",
          -- "-outdir=" .. outdir,
        },
      }
    end,
  },
}

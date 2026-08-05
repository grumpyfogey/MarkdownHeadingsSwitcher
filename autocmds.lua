
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank({ timeout = 500 })
  end,
})


-- Terminal
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Keine Zeilennummern im Terminal",
  group = vim.api.nvim_create_augroup( "termLinenumbers",
  { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})


-- für Treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'lua', },
  callback = function()
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()

    -- folds, provided by Neovim
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'

    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})


-- Keymaps für spezielle FileTypes
-- [[...]] String ohne interpretierte esc sequenzen ("\\" anstatt "\" )
vim.api.nvim_create_autocmd("FileType",{
  pattern = { "markdown", "quarto", "rmd", },
  group = vim.api.nvim_create_augroup('Markdown-stuff', { clear = true }),
  callback = function()
    -- vim.keymap.set("i", "<SPACE><SPACE>", "<ESC>/<++><ENTER>\"_c4l",
    --   { buffer = true, desc = "Jump to next mark in markdown file",}
    -- )
    -- vim.keymap.set("i", ",mm", [[$\,\text{<++>} <++>$<ESC>F$a]],
    --   { buffer = true, desc = "Inline math for markdown",}
    -- )
    vim.keymap.set("i", ",mm", [[$\,\text{}$<ESC>F$a]],
      { buffer = true, desc = "Inline math quantities for markdown",}
    )
    -- vim.keymap.set("i", ",mi", "![\"\"](<++>){#fig-<++>}<++><ESC>F\"i",
    --   { buffer = true, desc = "Images for markdown",}
    -- )
    vim.keymap.set("i", ",mi", "![\"\"](){#fig:}<ESC>F\"i",
      { buffer = true, desc = "Images for markdown",}
    )
    
    -- Markdown Headings in LocList
    require("gerald.md_headings")

    -- close quickfix menu after selecting choice
    vim.api.nvim_create_autocmd(
      "FileType", {
      pattern={"qf"},
      callback = function()
        vim.keymap.set ("n", "<CR>", "<CR> <Cmd>lclose<CR>",
        {buffer = true, desc = "Close Loc-List in Markdown" })
      end
    })
-- command=[[nnoremap <buffer> <CR> <CR>:lclose<CR>]]})

    vim.keymap.set ("n", "<Leader>mh", "<Cmd>MdHeadings<CR> | <Cmd>lopen<CR>",
      {buffer = true, desc = "Markdown-Headings in Loc-List" })

  end,
  desc = "Markdown Stuff",
})


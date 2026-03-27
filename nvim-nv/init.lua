vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },

  -- Add your overrides right here:
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = function(_, opts)
  --     -- Disable automatic popup
  --     opts.completion = {
  --       autocomplete = false,
  --     }
  --
  --     -- Keep LSP, buffer, lua, and path, but remove "luasnip"
  --     opts.sources = {
  --       { name = "nvim_lsp" },
  --       { name = "buffer" },
  --       { name = "nvim_lua" },
  --       { name = "path" },
  --     }
  --
  --     opts.snippet = {
  --       expand = function(args)
  --         vim.api.nvim_buf_set_text(0, args.line - 1, args.character, args.line - 1, args.character, { args.body })
  --       end,
  --     }
  --
  --     return opts
  --   end,
  -- },

  -- {
  --   "L3MON4D3/LuaSnip",
  --   enabled = false,
  -- },

  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },

}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)






vim.keymap.set({ "n", "v" }, "<C-q>", function()
  local mode = vim.fn.mode()
  local start_line, end_line, text

  if mode == "v" or mode == "V" or mode == "\22" then
    -- Visual mode: use visual marks
    start_line = vim.fn.line("'<")
    end_line   = vim.fn.line("'>")
    if start_line > end_line then start_line, end_line = end_line, start_line end

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    text = table.concat(lines, "\n")
  else
    -- Normal mode fallback: use word under cursor and operate on whole file
    start_line = 1
    end_line = vim.api.nvim_buf_line_count(0)
    text = vim.fn.expand("<cword>")
    if text == "" then
      print("No word under cursor to replace")
      return
    end
  end

  -- If text contains newlines, warn (simple s/// won't match newlines)
  if text:find("\n", 1, true) then
    print("Multi-line selection: this mapping doesn't support replacing multi-line blocks as a single pattern.")
    return
  end

  -- Escape the text for the search pattern and escape replacement for & and backslashes
  local search_esc = vim.fn.escape(text, "/\\")
  local replacement = vim.fn.input("Replace '" .. text .. "' with: ")
  local repl_esc = vim.fn.escape(replacement, "\\&/")

  -- Build and run the substitute command
  if start_line == 1 and end_line == vim.api.nvim_buf_line_count(0) then
    -- whole-file
    vim.cmd("silent %s/" .. search_esc .. "/" .. repl_esc .. "/g | update")
  else
    vim.cmd(string.format("silent %d,%ds/%s/%s/g | update", start_line, end_line, search_esc, repl_esc))
  end
end, opts)




--   key bindings

local opts ={ noremap = true, silent = true }


-- alt + up / down
-- Normal mode
vim.api.nvim_set_keymap("n", "<A-Up>", ":m .-2<CR>==", opts)
vim.api.nvim_set_keymap("n", "<A-Down>", ":m .+1<CR>==", opts)

-- Visual mode
vim.api.nvim_set_keymap("x", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
vim.api.nvim_set_keymap("x", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

-- Insert mode: Move current line up
vim.api.nvim_set_keymap("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
-- Insert mode: Move current line down
vim.api.nvim_set_keymap("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)



-- saving the file
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>i", opts)
vim.keymap.set("n", "<C-s>", ":w<CR>", opts)



-- SAVE: Ctrl + S
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>i", { noremap = true, silent = true })
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>gv", { noremap = true, silent = true })


-- vim.keymap.set("i", "<C-S-x>", [[<Esc>:wq]], opts)
vim.keymap.set("i", "<C-x>", "<Esc><cmd>wq<cr>", opts)
vim.keymap.set("n", "<C-x>", "<cmd>wq<cr>", opts)
vim.keymap.set("v", "<C-x>", "<Esc><cmd>wq<cr>", opts)





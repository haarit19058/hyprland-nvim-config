local opts = { noremap = true, silent = true }




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






-- Install this using lua to enable the comment shortcut
-- {
--  'numToStr/Comment.nvim',
--  config = function()
--    require('Comment').setup()
--  end
-- }



-- Toggle comment with Ctrl+/
vim.keymap.set('n', '<C-_>', function() require('Comment.api').toggle.linewise.current() end, opts)

vim.keymap.set('v', '<C-_>', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

vim.keymap.set('i', '<C-_>', '<Esc><cmd>lua require("Comment.api").toggle.linewise.current()<CR>gi', opts)










-- Search for word under cursor (like Ctrl+F)
vim.keymap.set("n", "<C-f>", [[/\<<C-r><C-w>\><CR>]], opts)

-- normal mode: Extend selection
vim.keymap.set("n", "<S-Left>", "v<Left>", opts)
vim.keymap.set("n", "<S-Right>", "v<Right>", opts)
vim.keymap.set("n", "<S-Up>", "v<Up>", opts)
vim.keymap.set("n", "<S-Down>", "v<Down>", opts)

-- VISUAL mode: Extend selection
vim.keymap.set("v", "<S-Left>", "<Left>", opts)
vim.keymap.set("v", "<S-Right>", "<Right>", opts)
vim.keymap.set("v", "<S-Up>", "<Up>", opts)
vim.keymap.set("v", "<S-Down>", "<Down>", opts)

-- INSERT mode: Exit insert, enter visual, move, and return to insert
vim.keymap.set("i", "<S-Left>", "<Esc>v<Left>gi", opts)
vim.keymap.set("i", "<S-Right>", "<Esc>v<Right>gi", opts)
vim.keymap.set("i", "<S-Up>", "<Esc>v<Up>gi", opts)
vim.keymap.set("i", "<S-Down>", "<Esc>v<Down>gi", opts)





-- Insert mode: Exit insert, do the same, then return to insert mode
vim.keymap.set("i", "<C-l>", [[<Esc>:%s/\<<C-r><C-w>\>//g<Left><Left>]], opts)

vim.keymap.set("v", "<C-l>", function(start_line, end_line)
  -- If no explicit lines given, get visual selection range
  start_line = start_line or vim.fn.line("v")
  end_line = end_line or vim.fn.line(".")

  -- Ensure correct order
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  -- Yank the visual selection
  vim.cmd('normal! "vy')
  local text = vim.fn.getreg("v"):gsub("/", "\\/")

  -- Prompt for replacement text
  local replacement = vim.fn.input("Replace '" .. text .. "' with: ")

  -- If lines are equal and no visual mode (fallback case), use whole file
  if start_line == end_line and vim.fn.mode() ~= 'v' and vim.fn.mode() ~= 'V' then
    vim.cmd(":%s/" .. text .. "/" .. replacement .. "/g")
  else
    vim.cmd(start_line .. "," .. end_line .. "s/" .. text .. "/" .. replacement .. "/g")
  end
end, opts)





vim.keymap.set("v", "<C-f>", function()
  -- Yank selected text into register v
  vim.cmd('normal! "vy')
  local text = vim.fn.getreg("v")

  -- Escape special characters for search
  text = vim.fn.escape(text, [[\/.*$^~[]])

  -- Set the search register and jump to first match
  vim.fn.setreg("/", text)
  vim.cmd("normal! n")  -- jump to next match

  -- You’re now in normal mode, free to scroll
end, opts)

-- Clear search highlight on <leader><space>
vim.keymap.set("n", "<leader><space>", "<Cmd>nohlsearch<CR>", opts)





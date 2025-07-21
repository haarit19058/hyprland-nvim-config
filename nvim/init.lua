require("config.lazy")

vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")

vim.cmd[[colorscheme vscode]]



local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' }) -- space + ff open telecope file finder
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' }) -- sapce + fg live grep for finding words inf files
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' }) -- space + fb list buffers (open files)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' }) -- space +fh seach nevim help





require('Comment').setup({
  -- Defaults are fine
})

vim.keymap.set('n', '<C-_>', function()
  require('Comment.api').toggle.linewise.current()
end, {noremap=true, silent=true})

vim.keymap.set('v', '<C-_>', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")


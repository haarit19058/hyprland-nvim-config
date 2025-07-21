return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true, -- Enable Treesitter integration
    })

    -- Optional: Integration with nvim-cmp (autocomplete)
	-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	-- local cmp_ok, cmp = pcall(require, "cmp")
    -- if cmp_ok then
      -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    -- end
  end,
}


-- ~/.config/nvim/lua/plugins/cmp.lua (or wherever you configure plugins)
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- LSP completion
    "hrsh7th/cmp-buffer",       -- Buffer words
    "hrsh7th/cmp-path",         -- Filesystem paths
    "hrsh7th/cmp-cmdline",      -- Command line completion
    "L3MON4D3/LuaSnip",         -- Snippet engine
    "saadparwaiz1/cmp_luasnip", -- Snippet completion
    "rafamadriz/friendly-snippets", -- Predefined snippets
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

   cmp.setup({
	  completion = {
		autocomplete = false,  -- 🔴 disable automatic popup
	  },
	  snippet = {
		expand = function(args)
		  luasnip.lsp_expand(args.body)
		end,
	  },
	  mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
		  if cmp.visible() then
			cmp.select_next_item()
		  else
			cmp.complete()  -- 🔁 manually trigger completion
		  end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
		  if cmp.visible() then
			cmp.select_prev_item()
		  else
			fallback()
		  end
		end, { "i", "s" }),

		["<CR>"] = cmp.mapping(function(fallback)
		  if cmp.visible() and cmp.get_selected_entry() then
			cmp.confirm({ select = true })
		  else
			fallback()
		  end
		end, { "i", "s" }),

		["<C-Space>"] = cmp.mapping.complete(), -- Optional manual trigger
	  },
	  sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	  }),
	})
  end
}


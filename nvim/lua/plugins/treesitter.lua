 return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile", "VeryLazy" },
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = { "bash","c","cpp","lua","python","javascript","html","css","json","vim","query","c_sharp","fsharp" },
    incremental_selection = { enable = true, keymaps = { init_selection="<C-space>", node_incremental="<C-space>", node_decremental="<bs>" } },
    textobjects = { move = { enable = true, goto_next_start = { ["]f"]="@function.outer" }, goto_previous_start = { ["[f"]="@function.outer" } } },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}



return {
  -- Bufferline configuration
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },

  -- Ensure the necessary language servers are enabled
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {}, -- For Python
        lua_ls = {}, -- For Lua
        -- Add more language servers as needed
      },
    },
  },

  -- Configure formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black" },
        lua = { "stylua" },
        -- Add more filetypes and formatters as needed
      },
    },
  },

  -- Updated Neo-tree configuration
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- This will show hidden files by default
        },
      },
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<cr>"] = "open",
          ["o"] = "open",
          ["<c-v>"] = "open_vsplit",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
    keys = {
      { "<leader>e", false }, -- Disable default toggle
      {
        "<C-n>",
        function()
          local neo_tree_window = vim.fn.bufwinnr("neo-tree")
          if neo_tree_window > 0 then
            vim.cmd(neo_tree_window .. "wincmd w")
          else
            vim.cmd("wincmd h")
          end
        end,
        desc = "Focus Neo-tree",
      },
    },
  },

  -- Add tpope's commentary plugin
  {
    "tpope/vim-commentary",
    event = "VeryLazy",
    keys = {
      { "gcc", mode = "n", desc = "Comment line" },
      { "gc", mode = { "n", "o" }, desc = "Comment motion" },
      { "gc", mode = "x", desc = "Comment selection" },
    },
  },

  -- Custom colorscheme
  {
    "bobbydmartino/awesome-vim-colorschemes",
    config = function()
      vim.cmd("colorscheme jupyterlike")
    end,
  },

  -- LSP and formatting configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Add your language servers here
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black", "isort" },
        -- Add other formatters for different filetypes here
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- Disable sections that might interfere with bufferline
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
    },
  },
}

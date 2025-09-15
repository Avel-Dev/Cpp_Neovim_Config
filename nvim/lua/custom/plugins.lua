local plugins = {
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      { "nvim-neotest/nvim-nio" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Codelldb adapter
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
          args = { "--port", "${port}" },
        },
      }

      -- Debug config for C++
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch", -- must be lowercase
          program = function ()
            vim.fn.jobstart("cargo build")
            local exe = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            local input = vim.fn.input("Program arguments: ")
            local args = vim.split(input, " +")

            dap.configurations.cpp[1].args = args
            return exe
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {}, -- must be a list
        },
      }

      -- Reuse config for C
      dap.configurations.c = dap.configurations.cpp

      dap.configurations.rust = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function ()
            vim.fn.jobstart("cargo build")
            local exe = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/","file")

            -- then ask for args
            local input = vim.fn.input("Program arguments: ")
            local args = vim.split(input, " +")
            -- assign args dynamically
            dap.configurations.rust[1].args = args
            return exe
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          runInTerminal = false
        }
      }
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function(_, _)
      require("core.utils").load_mappings("dap")
    end,
    opts = {
      handlers = {},
    },
  },
 
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function ()
      local cfg = require("rustaceanvim.config")

      -- Root Mason path
      local mason_root = vim.fn.stdpath("data") .. "/mason"
      local codelldb_root = mason_root .. "/packages/codelldb/extension/"

      local codelldb_path = codelldb_root .. "adapter/codelldb"
      local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"
    
      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }

    end 
  },

  {
    "mfussenegger/nvim-dap",
  },

  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },

  {
    'saecki/crates.nvim',
    ft = {'toml'},
    config = function ()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require("cmp").setup.buffer({
        sources = {{name = "crates"}}
      })
    end
  },

  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.none-ls"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "codelldb",
        "rust-analyzer"
      },
    },
  },
}

return plugins


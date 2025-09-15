local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd>lua require('dap').toggle_breakpoint()<CR>",
      "Toggle breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd>lua require('dap').continue()<CR>",
      "Start or continue debugger",
    },
    ["<leader>do"] = {
      "<cmd>lua require('dap').step_over()<CR>",
      "Step over",
    },
    ["<leader>di"] = {
      "<cmd>lua require('dap').step_into()<CR>",
      "Step into",
    },
    ["<leader>du"] = {
      "<cmd>lua require('dap').step_out()<CR>",
      "Step out",
    },
    ["<leader>dq"] = {
      "<cmd>lua require('dap').terminate()<CR>",
      "Terminate debugging",
    },
    ["<C-up>"] = {
      ":resize +2<CR>",
      "Resize Split up"
    },
    ["<C-Down>"] = {
      ":resize -2<CR>",
      "Resize Split up"
    },
    ["<C-Left>"] = {
      ":vertical resize -2<CR>",
      "Resize Split up"
    },
    ["<C-Right>"] = {
      ":vertical resize +2<CR>",
      "Resize Split up"
    },
    ["<A-S-h>"] = {
      "<C-w>H",
      "Move Panel Left"
    },
    ["<A-S-l>"] = {
      "<C-w>L",
      "Move Panel Right"
    },
    ["<A-S-k>"] = {
      "<C-w>K",
      "Move Panel Up"
    },
    ["<A-S-j>"] = {
      "<C-w>J",
      "Move Panel Down"
    }
  },
}

return M


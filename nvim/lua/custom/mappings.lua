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
  },
}

return M


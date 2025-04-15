return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("dapui").setup({})
            require("nvim-dap-virtual-text").setup({
                commented = true,      -- Show virtual text alongside comment
                all_frames = true,     -- Show virtual text for all frames (function calls)
                virt_text_pos = "eol", -- Position of virtual text (at the end of line)
            })

            -- Python debugging setup
            -- require("dap-python").setup("/usr/bin/python3")
            local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(mason_path)

            vim.fn.sign_define("DapBreakpoint", {
                text = "",
                texthl = "DiagnosticSignError",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapBreakpointRejected", {
                text = "", -- or "❌"
                texthl = "DiagnosticSignError",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapStopped", {
                text = "", -- or "→"
                texthl = "DiagnosticSignWarn",
                linehl = "Visual",
                numhl = "DiagnosticSignWarn",
            })

            -- Automatically open/close DAP UI
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end

            local opts = { noremap = true, silent = true }

            -- Show variables when hovering
            vim.keymap.set("n", "<leader>dh", function()
                dapui.eval()
            end, opts)

            vim.keymap.set("n", "<leader>dw", function()
                dapui.open({ sidebar = "watch" })
            end, opts)

            -- Toggle breakpoint
            vim.keymap.set("n", "<leader>db", function()
                dap.toggle_breakpoint()
            end, opts)

            -- Continue / Start
            vim.keymap.set("n", "<leader>dc", function()
                dap.continue()
            end, opts)

            -- Step Over
            vim.keymap.set("n", "<leader>do", function()
                dap.step_over()
            end, opts)

            -- Step Into
            vim.keymap.set("n", "<leader>di", function()
                dap.step_into()
            end, opts)

            -- Step Out
            vim.keymap.set("n", "<leader>dO", function()
                dap.step_out()
            end, opts)

            -- Keymap to terminate debugging
            vim.keymap.set("n", "<leader>dq", function()
                require("dap").terminate()
            end, opts)

            -- Toggle DAP UI
            vim.keymap.set("n", "<leader>du", function()
                dapui.toggle()
            end, opts)
        end,
    },
}

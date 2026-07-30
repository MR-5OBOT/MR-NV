return {
	{
		"mfussenegger/nvim-dap",
		cmd = {
			"DapContinue",
			"DapToggleBreakpoint",
			"DapStepOver",
			"DapStepInto",
			"DapStepOut",
			"DapTerminate",
		},
		keys = {
			{ "<leader>dh", function() require("dapui").eval() end, desc = "Debug: Evaluate expression" },
			{ "<leader>dw", function() require("dapui").open({ sidebar = "watch" }) end, desc = "Debug: Watch" },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle breakpoint" },
			{ "<leader>dc", function() require("dap").continue() end, desc = "Debug: Continue" },
			{ "<leader>do", function() require("dap").step_over() end, desc = "Debug: Step over" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Debug: Step into" },
			{ "<leader>dO", function() require("dap").step_out() end, desc = "Debug: Step out" },
			{ "<leader>dq", function() require("dap").terminate() end, desc = "Debug: Terminate" },
			{ "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
		},
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
				commented = true, -- Show virtual text alongside comment
				all_frames = true, -- Show virtual text for all frames (function calls)
				virt_text_pos = "eol", -- Position of virtual text (at the end of line)
			})

			-- Debug through Mason's debugpy, while running code with the nearest
			-- project virtual environment when one exists.
			local dap_python = require("dap-python")
			local debugpy_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
			dap_python.resolve_python = function()
				local filename = vim.api.nvim_buf_get_name(0)
				local directory = filename ~= "" and vim.fs.dirname(filename) or vim.fn.getcwd()
				local venv = vim.fs.find({ ".venv", "venv" }, { path = directory, upward = true })[1]
				if venv then
					local python = venv .. (vim.fn.has("win32") == 1 and "/Scripts/python.exe" or "/bin/python")
					if vim.fn.executable(python) == 1 then
						return python
					end
				end

				return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3") or "python3"
			end
			dap_python.setup(vim.uv.fs_stat(debugpy_python) and debugpy_python or "python3")

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

		end,
	},
}

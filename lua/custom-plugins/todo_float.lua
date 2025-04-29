function Expand_path(path)
  if path:sub(1, 1) == "~" then
    return os.getenv("HOME") .. path:sub(2)
  end
  return path
end

function Center_in(outer, inner)
  return (outer - inner) / 2
end

local M = {}

local function float_win_config()
  local width = math.min(math.floor(vim.o.columns * 0.8), 64)
  local height = math.floor(vim.o.lines * 0.8)

  return {
    relative = "editor",
    width = width,
    height = height,
    col = Center_in(vim.o.columns, width),
    row = Center_in(vim.o.lines, height),
    border = "single",
  }
end

local function open_floating_file(filepath)
  -- Check if the file exists
  if vim.fn.filereadable(filepath) == 0 then
    vim.notify("File does not exist: " .. filepath, vim.log.levels.ERROR)
    return
  end

  -- Look for an existing buffer with this file
  local buf = vim.fn.bufnr(filepath, true) -- Changed 'path' to 'filepath'

  -- If the buffer doesn't exist, create one and edit the file
  if buf == 0 then -- Changed from -1 to 0.  bufnr returns 0 if not found.
    buf = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(buf, filepath) -- Changed 'path' to 'filepath'
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("edit " .. vim.fn.fnameescape(filepath)) -- Changed 'path' to 'filepath'
    end)
  end

  vim.bo[buf].swapfile = false

  local win = vim.api.nvim_open_win(buf, true, float_win_config())
  vim.cmd("setlocal nospell")

  vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
    noremap = true,
    silent = true,
    callback = function()
      if vim.api.nvim_get_option_value("modified", { buf = buf }) then
        vim.notify("Save your changes!", vim.log.levels.WARN)
      elseif vim.api.nvim_win_is_valid(win) then -- Add this check
        vim.api.nvim_win_close(win, true)
      end
    end,
  })

  vim.api.nvim_create_autocmd("VimResized", {
    callback = function()
      if vim.api.nvim_win_is_valid(win) then -- Check if the window is still valid.
        vim.api.nvim_win_set_config(win, float_win_config())
      end
    end,
    once = false,
  })
end

local function setup_user_commands(opts)
  local target_file = opts.target_file or "todo.md"
  local global_file = opts.global_file

  vim.api.nvim_create_user_command("Td", function()
    local resolved_path = vim.fn.resolve(target_file)
    if vim.fn.filereadable(resolved_path) == 1 then
      open_floating_file(resolved_path)
    else
      open_floating_file(Expand_path(global_file))
    end
  end, {})
end

M.setup = function(opts)
  setup_user_commands(opts)
end

return M

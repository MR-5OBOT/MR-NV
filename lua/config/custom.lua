-- If you only want buffers that are currently open in windows:
vim.api.nvim_create_user_command("ListBuffers", function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        print("Buffer ID:", buf, "Name:", vim.api.nvim_buf_get_name(buf))
    end
end, {})

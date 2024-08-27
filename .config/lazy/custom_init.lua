
-- Set absolute line numbers
vim.wo.number = true
vim.wo.relativenumber = false

-- Custom keymaps
vim.keymap.set("n", "<leader>f", function()
  require("conform").format()
end, { desc = "Format document" })

vim.keymap.set("n", "ZX", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_name = vim.api.nvim_buf_get_name(bufnr)
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  local buf_count = #vim.fn.getbufinfo({ buflisted = 1 })
  local buf_empty = vim.fn.empty(vim.fn.expand("%")) == 1 and not modified

  -- Check if current buffer is Neo-tree
  if buf_name:match("neo%-tree filesystem") then
    -- Focus on the next window
    vim.cmd("wincmd w")
    return
  end

  if buf_count == 1 or buf_empty then
    if modified then
      vim.ui.input({
        prompt = "Buffer is modified. Save changes? (y/n) ",
      }, function(input)
        if input == "y" then
          vim.cmd("write")
        end
        vim.cmd("qall")
      end)
    else
      vim.cmd("qall")
    end
  else
    if modified then
      vim.ui.input({
        prompt = "Buffer is modified. Save changes? (y/n) ",
      }, function(input)
        if input == "y" then
          vim.cmd("write")
        end
        vim.cmd("bdelete " .. bufnr)
        -- Focus on the next buffer after closing
        vim.cmd("bnext")
      end)
    else
      vim.cmd("bdelete " .. bufnr)
      -- Focus on the next buffer after closing
      vim.cmd("bnext")
    end
  end
end, { desc = "Close current buffer or exit Vim" })

-- Automatically open Neo-tree on startup and focus on the main window
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
    vim.cmd("wincmd l") -- Move focus to the main window
  end,
})

-- Prevent Neo-tree from taking full screen when closing buffers
vim.api.nvim_create_autocmd("WinClosed", {
  callback = function()
    if #vim.api.nvim_list_wins() == 1 then
      local buf_name = vim.api.nvim_buf_get_name(0)
      if buf_name:match("neo%-tree filesystem") then
        vim.cmd("quit")
      end
    end
  end,
})

-- Custom keymaps
vim.keymap.set({ "n", "v" }, "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format document or range" })

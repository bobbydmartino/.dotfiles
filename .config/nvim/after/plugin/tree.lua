-- empty setup using defaults
require("nvim-tree").setup({
    -- ignore_buffer_on_setup = true,
    -- open_on_setup = true,
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})


vim.keymap.set("n", "<C-n>", [[:NvimTreeToggle<CR>]])

count_bufs_by_type = function(loaded_only)
    loaded_only = (loaded_only == nil and true or loaded_only)
    count = {normal = 0, acwrite = 0, help = 0, nofile = 0,
    nowrite = 0, quickfix = 0, terminal = 0, prompt = 0}
    buftypes = vim.api.nvim_list_bufs()
    for _, bufname in pairs(buftypes) do
       if (not loaded_only) or vim.api.nvim_buf_is_loaded(bufname) then
           buftype = vim.api.nvim_buf_get_option(bufname, 'buftype')
           buftype = buftype ~= '' and buftype or 'normal'
           count[buftype] = count[buftype] + 1
       end
    end
    return count

end

vim.keymap.set('n','ZX', function()
    vim.cmd('NvimTreeClose')
    local bufTable = count_bufs_by_type()
    if (bufTable.normal <= 1) then
       vim.api.nvim_exec([[:q]], true)
    else
        vim.api.nvim_exec([[:bd]], true)
    end
end)




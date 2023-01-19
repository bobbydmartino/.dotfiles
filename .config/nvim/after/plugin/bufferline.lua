require("bufferline").setup{
  options = {
      numbers="ordinal",
      indicator={
        icon = "▎",
        style = "icon",
      },
      modified_icon = "●",
      close_icon='',
      max_name_length = 18,
      separator_style = "slant",
      offsets = {
          {
              filetype = "NvimTree",
              test = "File Explorer",
              text_align = "center",
              separator = "true"
          }
      }
  }
}

vim.keymap.set('n', 'H', ':bprev<CR>')
vim.keymap.set('n', 'L', ':bnext<CR>')



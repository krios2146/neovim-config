vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    require('ibl').setup_buffer(0, { enabled = true, scope = { enabled = false } })
  end,
})

-- Indentation lines & tabs highlight
return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = { enabled = false, scope = { show_start = false, show_end = false } },
  },
}

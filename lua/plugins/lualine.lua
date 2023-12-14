return {{
    'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup({
            sections = {
                lualine_x = { 
                    { 'datetime', style = '%H:%M:%S' }, 
                    'filetype'
                }
            }
        })
    end
}}

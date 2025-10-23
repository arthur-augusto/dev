return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        vim.cmd('colorscheme github_dark_high_contrast')
        require('lualine').setup({})
    end
}

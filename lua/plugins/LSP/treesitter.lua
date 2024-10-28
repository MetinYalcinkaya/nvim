return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cmake',
        'cpp',
        'go',
        'html',
        'lua',
        'luadoc',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'regex',
        'rust',
        'sql',
        'swift',
        'vim',
        'vimdoc',
      },
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'swift' }, -- Not sure why, but performs terribly with swift
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = false, disable = { 'ruby' } },
    },
  },
}

function config()
  pcall(require('nvim-treesitter.install').update({ with_sync = true }))
  require('nvim-treesitter.install').compilers = { "clang" }
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      "help",
      "bash",
      "lua",
      "javascript",
      "typescript",
      "python",
      "tsx",
      "html",
      "css",
      "json",
    },
    sync_install = false, -- install parsers synchronously
    auto_install = true, -- automatically install missing parsers when entering buffer
    highlight = {
      enable = true,
      --disable = { "..." },

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    autopairs = {
      enable = true,
    },
    indent = {
      enable = true,
      --disable = { "..." },
    },
  }
end

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = config,
}

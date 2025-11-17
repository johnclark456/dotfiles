return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          keys = {
            {
              "<leader>h",
              "<cmd>ClangdSwitchSourceHeader<cr>",
              desc = "Switch between source and header",
            },
          },
        },
      },
    },
  },
}

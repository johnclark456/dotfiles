return {
  -- Treesitter grammar (optional but improves highlighting & folding)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "bzl", "starlark" })
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "bzl" })
    end,
  },
  -- Formatting via buildifier
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        bzl = { "buildifier" },
        bazel = { "buildifier" },
      },
      formatters = {
        buildifier = {
          command = "buildifier",
          args = { "-" },
          stdin = true,
        },
      },
    },
  },

  {
    "nvim-lua/plenary.nvim",
    init = function()
      vim.filetype.add({
        extension = {
          bzl = "bzl",
          bazel = "bazel",
        },
        filename = {
          ["BUILD"] = "bzl",
          ["BUILD.bazel"] = "bzl",
          ["MODULE.bazel"] = "bzl",
          ["WORKSPACE"] = "bzl",
          ["WORKSPACE.bazel"] = "bzl",
        },
      })
    end,
  },
}

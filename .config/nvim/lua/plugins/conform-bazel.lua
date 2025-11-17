-- ~/.config/nvim/lua/plugins/conform-bazel.lua
return {
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
}

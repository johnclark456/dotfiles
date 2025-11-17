-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- lua/config/keymaps.lua
local map = vim.keymap.set

-- Function to add or update include guards in C headers
local function add_or_update_include_guard()
  local filename = vim.fn.expand("%:t")
  local ext = vim.fn.expand("%:e")

  if ext ~= "h" and ext ~= "hpp" then
    vim.notify("Not a header file", vim.log.levels.WARN)
    return
  end

  local guard = filename:upper():gsub("[^A-Z0-9]", "_") .. "_"
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local found_ifndef, found_define = nil, nil

  for i, line in ipairs(lines) do
    if line:match("^#ifndef") then
      found_ifndef = i
    end
    if line:match("^#define") then
      found_define = i
    end
  end

  -- Remove old guard lines if found
  if found_ifndef and found_define then
    table.remove(lines, found_define)
    table.remove(lines, found_ifndef)
  end

  -- Remove existing #endif guard at end if present
  if #lines > 0 and lines[#lines]:match("^#endif") then
    table.remove(lines)
  end

  -- Insert new include guard
  table.insert(lines, 1, "#define " .. guard)
  table.insert(lines, 1, "#ifndef " .. guard)
  table.insert(lines, "#endif /* " .. guard .. " */")

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.notify("Include guard added: " .. guard, vim.log.levels.INFO)
end

-- Keymap: <leader>ig to add/update include guard
map("n", "<leader>ig", add_or_update_include_guard, { desc = "Add or update C include guard" })
-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

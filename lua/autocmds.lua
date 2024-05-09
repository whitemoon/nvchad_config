local function augroup(name)
  return vim.api.nvim_create_augroup("nvchad_cusom_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup "last_loc",
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].custom_last_loc then
      return
    end
    vim.b[buf].custom_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup "modified_list",
  callback = function(event)
    local buf = event.buf
    vim.b[buf].custom_buffer_modified = true
  end,
})

vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter", "tabnew" }, {
  group = augroup "delete_unmodified_buffer",
  callback = function()
    vim.t.bufs = vim.tbl_filter(function(bufnr)
      if vim.b[bufnr].custom_buffer_modified or vim.api.nvim_get_option_value("modified", { buf = bufnr }) then
        return true
      end
      return false
    end, vim.t.bufs)
  end,
})

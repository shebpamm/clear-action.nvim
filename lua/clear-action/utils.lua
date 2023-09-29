local M = {}

M.code_action_request = function(bufnr, params, on_result)
  vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(error, results, context)
    if error then
      local message = type(error) == "string" and error or error.message
      vim.notify("code action: " .. message, vim.log.levels.WARN)
    end
    if results then on_result(results, context) end
  end)
end

M.handle_action = function(action, client, ctx)
  if action.edit then
    vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
  elseif action.command then
    local command = type(action.command) == "table" and action.command or action
    client._exec_cmd(command, ctx)
  end
end

return M

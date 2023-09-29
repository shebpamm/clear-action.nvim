# clear-action.nvim

A simple Neovim plugin that enhances LSP code actions with fully customizable signs, personalized actions, and server-specific mappings, making code actions more predictable.

![Preview](https://github.com/luckasRanarison/clear-action.nvim/assets/101930730/73d57753-1e9f-4d48-903b-8646908a127f)

## Installation

Using Lazy:

```lua
{
  "luckasRanarison/clear-action.nvim",
  opts = {}
}
```

Using packer:

```lua
use {
  "luckasRanarison/clear-action.nvim",
  config = function()
    require("clear-action").setup({})
  end
}
```

## Configuration

The default configuration:

```lua
{
  signs = {
    enable = true,
    timeout = 1000, -- in milliseconds
    combine = false, -- combines all action kinds into a single sign
    position = "eol", -- "right_align" | "overlay"
    separator = " ", -- signs separator
    show_count = true, -- show the number of each action kind
    show_label = false, -- show the string returned by `label_fmt`
    label_fmt = function(actions) return actions[1].title end, -- actions is an array of `CodeAction`
    update_on_insert = false, -- show and update signs in insert mode
    icons = {
      quickfix = "🔧",
      refactor = "💡",
      source = "🔗",
      combined = "💡", -- used when combine is set to true
    },
    highlights = { -- higlight groups
      quickfix = "NonText",
      refactor = "NonText",
      source = "NonText",
      combined = "NonText",
      label = "NonText",
    },
  },
  mappings = {
    -- These are just basically `vim.lsp.buf.code_action` with the `apply` option with some filters
    -- If there's only one code action, it gets automatically applied.
    -- The values can either be a string or a string tuple (with description)
    -- example: "<leader>aq" | { "<leader>aq", "Quickfix" }
    apply_first = nil, -- applies first code action
    quickfix = nil, -- can be filtered with the `quickfix_filter` option bellow
    quickfix_next = nil, -- tries to fix the next diagnostic
    quickfix_prev = nil, -- tries to fix the previous diagnostic
    refactor = nil,
    refactor_inline = nil,
    refactor_extract = nil,
    refactor_rewrite = nil,
    source = nil,
    -- server-specific mappings, server_name = {...}
    -- This is a map of code actions prefixes and keys
    actions = {
      -- example:
      -- ["rust_analyzer"] = {
      --   ["Inline"] = "<leader>ai"
      --   ["Add braces"] = { "<leader>ab", "Add braces" }
      -- }
    },
  }
  -- This is used for filtering actions in the quickfix functions
  -- It's a map of diagnostic codes and the preferred action prefixes
  -- You can check the diagnostic codes by hovering on the diagnostic
  quickfix_filters = {
    -- example:
    -- ["rust_analyzer"] = {
    --   ["E0433"] = "Import",
    -- },
    -- ["lua_ls"] = {
    --   ["unused-local"] = "Disable diagnostics on this line",
    -- },
  },
}
```

## Commands

Available commands:

- `CodeActionToggleSigns`: Toggle the signs.
- `CodeActionToggleLabel`: Toggle the label.

## Contributing

Issues, pull requests, ideas and feature requests are all welcome!

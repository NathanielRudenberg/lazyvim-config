return {
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup({
        virtualtext = {
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",
            accept_line = "<M-l>",
            prev = "<M-[>", -- Cycle to previous suggestion
            next = "<M-]>", -- Cycle to next suggestion
            dismiss = "<M-e>", -- Dismiss the suggestion
          },
        },
        provider = "gemini",
        provider_options = {
          gemini = {
            model = "gemini-2.0-flash",
            stream = true,
            optional = {
              generationConfig = {
                maxOutputTokens = 256,
                thinkingConfig = {
                  thinkingBudget = 0,
                },
              },
            },
          },
        },
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "saghen/blink.cmp",
      "lalitmee/codecompanion-spinners.nvim",
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Chat" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = "v", desc = "AI Inline Edit" },
      -- Quick add visual selection to chat
      { "<leader>ax", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to AI Chat" },
    },
    opts = {
      extensions = {
        spinner = {
          opts = {
            style = "snacks",
          },
        },
      },
      display = {
        diff = {
          enabled = true,
          provider = "inline",
          provider_opts = {
            inline = {
              layout = "float",
              opts = {
                context_lines = 3, -- Number of context lines in hunks
                dim = 25, -- Background dim level for floating diff (0-100, [100 full transparent], only applies when layout = "float")
                full_width_removed = true, -- Make removed lines span full width
                show_keymap_hints = true, -- Show "gda: accept | gdr: reject" hints above diff
                show_removed = true, -- Show removed lines as virtual text
              },
            },
          },
        },
        chat = {
          show_settings = true,
          show_token_count = true, -- Shows tokens as they generate
          show_tools_processing = true, -- Shows a "Loading..." message when tools run
          render_headers = true, -- Cleaner UI
          icons = {
            chat_context = "📎️", -- You can also apply an icon to the fold
            tool_pending = "⏳ ",
            tool_in_progress = "⚙️ ",
            tool_success = "✅ ",
            tool_failure = "❌ ",
          },
          fold_context = true,
        },
      },
      interactions = {
        background = {
          chat = {
            opts = { enabled = true },
          },
        },
        chat = {
          adapter = {
            name = "gemini",
            model = "gemini-2.5-pro",
          },
          roles = {
            llm = function(adapter)
              return "AI (" .. adapter.formatted_name .. ")"
            end,
            user = "Me",
          },
          slash_commands = {
            ["file"] = {
              description = "Select a file to provide context",
              opts = { provider = "snacks" },
            },
            ["buffer"] = {
              description = "Insert the current buffer",
              opts = { provider = "snacks" },
            },
          },
          tools = {
            opts = {
              auto_submit_errors = true,
              auto_submit_success = true,
              -- These tools will be available to the LLM automatically
              default_tools = {
                -- "cmd_runner", -- Run shell commands
                "file_search", -- Search/Read files
                "insert_edit_into_file", -- Edit buffers
                "read_file", -- Read files
                "create_file", -- Create new files
              },
            },
            ["create_file"] = {
              opts = {
                -- False = Let it generate the file content immediately
                require_approval_before = false,
                -- True = Show me the buffer with the new code so I can approve saving it
                require_confirmation_after = true,
              },
            },
            ["insert_edit_into_file"] = {
              opts = {
                require_approval_before = false,
                require_confirmation_after = true,
              },
            },
            ["read_file"] = {
              opts = {
                require_approval_before = false,
                require_confirmation_after = false,
              },
            },
            ["file_search"] = {
              opts = {
                require_approval_before = false,
                require_confirmation_after = false,
              },
            },
          },
          opts = {
            system_prompt = function(ctx)
              return ctx.default_system_prompt
                .. string.format(
                  "\nAdditional context:\nThe user is working on a %s machine. Response should be specific to this OS.",
                  ctx.os
                )
                .. [[

========================
CRITICAL TOOL RULES
========================

When using the `insert_edit_into_file` tool:

- `start_line_number_base_zero` MUST be an integer.
- `end_line_number_base_zero` MUST be an integer.
- NEVER use null.
- NEVER use nil.
- NEVER omit required fields.
- If editing an entire file:
  - start_line_number_base_zero = 0
  - end_line_number_base_zero = index of last line in file
- Line numbers are ZERO-BASED.
- The range MUST fully cover the lines being replaced.

Failure to follow this schema will break the edit.

========================
FILE READING RULES
========================

When reading project files:

- Use `read_file` or `file_search`.
- DO NOT use shell commands like `ls`, `cat`, or `grep` for reading files.
- Use `cmd_runner` only when absolutely necessary.
- NEVER use destructive shell commands.
- NEVER modify files via shell.

========================
EDITING STYLE RULES
========================

When modifying code:

- Make minimal, surgical edits.
- Modify only the necessary lines.
- DO NOT rewrite entire files unless explicitly requested.
- Preserve formatting and surrounding code.
- Avoid large-scale refactors unless asked.
- Keep edits localized to produce clean diff hunks.

If editing multiple files:

- Modify each file independently.
- Only change what is necessary in each file.
- Avoid broad rewrites across files.

========================
GENERAL BEHAVIOR
========================

- Prefer structured tools over shell commands.
- Think step-by-step before calling tools.
- Plan edits before executing them.
- Do not guess line numbers.
- If uncertain, read the file first.

]]
            end,
          },
        },
        inline = {
          adapter = "gemini",
          keymaps = {
            accept_change = { modes = { n = "gda" }, description = "Accept Diff" },
            reject_change = { modes = { n = "gdr" }, description = "Reject Diff" },
          },
        },
      },
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = { api_key = "GEMINI_API_KEY" },
            opts = {
              stream = true,
              tools = true,
            },
            schema = {
              model = {
                default = "gemini-2.5-pro",
              },
              -- Optimization: Increase tokens for longer chat responses
              max_tokens = {
                default = 8192,
              },
              temperature = {
                default = 0.2, -- Lower temperature = more precise code
              },
            },
          })
        end,
      },
    },
  },
}

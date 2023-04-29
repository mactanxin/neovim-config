local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "LazyVim/LazyVim", },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        message = {
          enabled = true,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      format = {
        -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
        -- view: (default is cmdline view)
        -- opts: any options passed to the view
        -- icon_hl_group: optional hl_group for the icon
        -- title: set to anything or empty string to hide
        cmdline = { pattern = "^:", icon = "", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = "🔍 ", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = "🔍 ", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
        input = {}, -- Used by input()
        -- lua = false, -- to disable a format, set to `false`
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
  },
  "airblade/vim-rooter",
  "ellisonleao/gruvbox.nvim",
  "glepnir/zephyr-nvim",
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      transparent = true,
      dim_inactive = true
    },
  },
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local dracula = require("dracula")
      dracula.setup({
        colors = { bg = "NONE" },
        transparent_bg = true,
        show_end_of_buffer = true
      })
    end
  },
  -- fzf
  "junegunn/fzf",
  "junegunn/fzf.vim",
  "junegunn/vim-easy-align",
  {
    "jcdickinson/wpm.nvim",
    config = function()
      require("wpm").setup({})
    end,
  },
  -- lualine with config
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons", "linrongbin16/lsp-progress.nvim" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          --[[ theme = chooseRandomTheme(), ]]
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true, -- need set true
          refresh = {
            statusline = 1000,
            tablinetabline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = {
            "mode",
          },
          lualine_b = { "branch", "diff", "diagnostics" },
          -- show the current filename and session name,
          lualine_c = { "filename", require("auto-session.lib").current_session_name },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress", require("wpm").wpm, require("wpm").historic_graph },
          lualine_z = { "location", require("lsp-progress").progress },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {
          lualine_a = { "buffers" },
          lualine_b = { "branch" },
          lualine_c = { "filename" },
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "tabs" },
        },
        extensions = { "fzf", "neo-tree", "fugitive" },
      })
    end,
  },
  {
    'linrongbin16/lsp-progress.nvim',
    branch = 'main',
    event = { 'VimEnter' },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lsp-progress').setup({})
      vim.cmd([[
augroup lualine_augroup
  autocmd!
  autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
augroup END
]])
    end
  },
  -- tabline with config
  {
    "kdheepak/tabline.nvim",
    lazy = false,
    config = function()
      require("tabline").setup({
        -- Defaults configuration options
        enable = true,
        options = {
          -- If lualine is installed tabline will use separators configured in lualine by default.
          -- These options can be used to override those settings.
          section_separators = { "", "" },
          component_separators = { "", "" },
          max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
          show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
          show_devicons = true, -- this shows devicons in buffer section
          show_bufnr = false, -- this appends [bufnr] to buffer section,
          show_filename_only = false, -- shows base filename only instead of relative path in filename
          modified_icon = "+ ", -- change the default modified icon
          modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
          show_tabs_only = true, -- this shows only tabs instead of tabs + buffers
        },
      })
      vim.cmd([[
        set guioptions-=e " Use showtabline in gui vim
        set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]])
      vim.notify("init tabline", "info")
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    dependencies = { "antoinemadec/FixCursorHold.nvim" },
  },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("telescope").setup({
        defaults = {
          preview = {
            mime_hook = function(filepath, bufnr, opts)
              local is_image = function(filepath)
                local image_extensions = { "png", "jpg", "jpeg" } -- Supported image formats
                local split_path = vim.split(filepath:lower(), ".", { plain = true })
                local extension = split_path[#split_path]
                return vim.tbl_contains(image_extensions, extension)
              end
              if is_image(filepath) then
                vim.notify("image dectected", "info")
                local term = vim.api.nvim_open_term(bufnr, {})
                local function send_output(_, data, _)
                  for _, d in ipairs(data) do
                    vim.api.nvim_chan_send(term, d .. "\r\n")
                  end
                end

                vim.fn.jobstart({
                  "catimg",
                  filepath, -- Terminal image viewer command
                }, { on_stdout = send_output, stdout_buffered = true })
              else
                vim.notify("image not dectected", "error")
                require("telescope.previewers.utils").set_preview_message(
                  bufnr,
                  opts.winid,
                  "Img Binary cannot be previewed"
                )
              end
            end,
          },
          -- Default configuration for telescope goes here:
          -- config_key = value,
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim", -- add this value
          },
          --[[ buffer_previewer_maker = new_maker, ]]
          -- buffer_previewer_maker = hologram.buffer_previewer_maker,
          file_ignore_patterns = {
            "node_modules",
            "build",
            "dist",
            "yarn.lock",
            "core",
            ".gitignore",
            ".ignore",
            ".rgignore",
          },
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-h>"] = "which_key",
              ["<C-u>"] = false,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files" },
            mappings = {
              n = {
                ["cd"] = function(prompt_bufnr)
                  local selection = require("telescope.actions.state").get_selected_entry()
                  local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                  require("telescope.actions").close(prompt_bufnr)
                  -- Depending on what you want put `cd`, `lcd`, `tcd`
                  vim.cmd(string.format("silent lcd %s", dir))
                end,
              },
            },
          },
        },
        extensions = {
          file_browser = {
            -- theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
              },
              ["n"] = {
                -- your custom normal mode mappings
              },
            },
          },
          media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "rg", -- find command (defaults to `fd`)
          },
          -- Your extension configuration goes here:
          -- extension_name = {
          --   extension_config_key = value,
          -- }
          -- please take a look at the readme of the extension you want to configure
        },
      })
    end,
  },
  "nvim-telescope/telescope-file-browser.nvim",
  {
    "rmagatti/session-lens",
    dependencies = {
      "rmagatti/auto-session",
      "nvim-telescope/telescope.nvim",
    },
  },
  -- lsp-zero
  -- lsp related
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    dependencies = {
      -- LSP Support
      "neovim/nvim-lspconfig", -- required
      "lukas-reineke/lsp-format.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Autocompletion
      "hrsh7th/nvim-cmp", --required
      "hrsh7th/cmp-nvim-lsp", --required
      "hrsh7th/cmp-buffer", -- Optional
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind-nvim",
      "roobert/tailwindcss-colorizer-cmp.nvim"
    },
    config = function()
      local lsp = require("lsp-zero")
      lsp.preset("recommended")
      lsp.on_attach(function(client, bufnr)
        require("lsp-format").on_attach(client, bufnr)
      end)
      lsp.nvim_workspace()
      lsp.setup()
      vim.diagnostic.config({ virtual_text = true })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require('lspconfig')['tailwindcss'].setup {}
      require('lspconfig')['tsserver'].setup {}
      require('lspconfig').tsserver.setup {
        require("typescript").setup({ server = opts })
      }
    end,
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({
        virtual_text = false
      })
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        rgb_fn = true,
        css = true,
        css_fn = true,
        tailwind = true,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
  },
  {
    "glepnir/lspsaga.nvim",
    keys = {
      { "gpr",         "<cmd>Lspsaga lsp_finder<CR>",           "n" },
      { "<leader>lr",  "<cmd>Lspsaga rename<CR>" },
      { "<leader>la",  "<cmd>Lspsaga code_action<CR>",          "n, v" },
      { "gpd",         "<cmd>Lspsaga peek_definition<CR>" },
      { "<leader>lsd", "<cmd>Lspsaga show_line_diagnostics<CR>" },
      { "<leader>so",  "<cmd>Lspsaga outline<CR>" },
      { "K",           "<cmd>Lspsaga hover_doc<CR>" },
    },
  },
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "vim", "lua", "rust", "vue", "typescript", "javascript", "html", "css", "help" },
        highlight = { enable = true },
        indent = {
          enable = true,
          disable = { "yaml" },
        },
        rainbow = {
          enable = true,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
          -- colors = {}, -- table of hex strings
          -- termcolors = {} -- table of colour name strings
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },
  -- neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    opts = {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        follow_current_file = true,
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
  },
  { "akinsho/toggleterm.nvim", opts = { open_mapping = [[<c-\>]], direction = "tab" } },
  {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup()
    end,
  },
  "numToStr/Comment.nvim",
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    },
  },
  {
    "rmagatti/session-lens",
    dependencies = {
      "rmagatti/auto-session",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
    end,
  },
  "jose-elias-alvarez/null-ls.nvim",
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup({
        signcolumn = true,
        current_line_blame = true,
      })
    end,
  },
  {
    "zbirenbaum/neodim",
    opts = {
      alpha = 0.5,
      hide = {
        virtual_text = true,
        signs = true,
        underline = true,
      },
    },
    ft = { "vue", "javascript", "typescript", "svelte" },
  },
  { "goolord/alpha-nvim",        event = "VimEnter" },
  {
    "declancm/cinnamon.nvim",
    enabled = true,
    lazy = false,
    config = function()
      require("cinnamon").setup({
        -- KEYMAPS:
        default_keymaps = true, -- Create default keymaps.
        extra_keymaps = false, -- Create extra keymaps.
        extended_keymaps = false, -- Create extended keymaps.
        override_keymaps = false, -- The plugin keymaps will override any existing keymaps.
        -- OPTIONS:
        always_scroll = false, -- Scroll the cursor even when the window hasn't scrolled.
      })
    end,
  },
  "petertriho/nvim-scrollbar",
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = {
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },
  -- active indent guide and indent text objects
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "BufReadPre",
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {
      autotag = {
        enable = true,
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0, -- Offset from pattern match
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
    lazy = false,
  },
  "mattn/emmet-vim",
  { "easymotion/vim-easymotion", event = "VeryLazy" },
  "wellle/context.vim",
  "rmagatti/goto-preview",
  "tpope/vim-surround",
  "AndrewRadev/tagalong.vim",
  { "tpope/vim-repeat",      event = "VeryLazy" },
  {
    "koenverburg/peepsight.nvim",
    event = "VeryLazy",
    config = function()
      require("peepsight").setup({
        -- go
        "function_declaration",
        "method_declaration",
        "func_literal",

        -- typescript
        "class_declaration",
        "method_definition",
        "arrow_function",
        "function_declaration",
        "generator_function_declaration",
      })
    end,
  },
  { "echasnovski/mini.nvim", version = false },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter" },
    opts = function()
      require("treesj").setup({ --[[ your config ]]
      })
    end,
  },
  {
    "leafOfTree/vim-svelte-plugin",
    ft = { "svelte" },
    config = function()
      vim.g.vim_svelte_plugin_use_typescript = 1
    end
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "Bryley/neoai.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    cmd = {
      "NeoAI",
      "NeoAIOpen",
      "NeoAIClose",
      "NeoAIToggle",
      "NeoAIContext",
      "NeoAIContextOpen",
      "NeoAIContextClose",
      "NeoAIInject",
      "NeoAIInjectCode",
      "NeoAIInjectContext",
      "NeoAIInjectContextCode",
    },
    keys = {
      { "<leader>ans", desc = "summarize text" },
      { "<leader>ag",  desc = "generate git message" },
    },
    config = function()
      require("neoai").setup({
        open_ai_key_env = "OPEN_API_KEY"
        -- Options go here
      })
    end,
  },
  {
    'VonHeikemen/searchbox.nvim',
    config = function()
      require('searchbox').setup({
        popup = {
          position = {
            row = '50%',
            col = '50%'
          }
        }
      })
    end
  },
  {
    'Exafunction/codeium.vim',
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions']( -1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

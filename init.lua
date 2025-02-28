-- lazy vim setup 
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

-- vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46" -- base 46 theming
vim.opt.rtp:prepend(lazypath)

-- table of plugins
local plugins = {
    {
    "stevearc/conform.nvim",
    lazy = true,
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
    },
    { "nvim-lua/plenary.nvim",  -- plenary 
    lazy = false
    },
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     opts = {
    --         ensure_installed = {
    --             "vim", "lua", "vimdoc",
    --         },
    --     },
    -- },
    {
        "jinh0/eyeliner.nvim",
        lazy = false,
        config = function()
            require('eyeliner').setup{
                highlight_on_key = true,
                dim = true,
                max_length = 200,
            }
        end,
    },
     {
     'nvim-orgmode/orgmode',
     event = 'VeryLazy',
     ft = { 'org' },
     config = function()
     -- Setup orgmode
     require('orgmode').setup({
       org_agenda_files = '~/projects/orgfiles/*',
       org_default_notes_file = '~/projects/orgfiles/ssd.org',
       org_deadline_warning_days = 0,
       org_startup_indented = true,
       -- win_split_mode = 'float'
     })
    end,
    },
    {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    lazy = false,
    config = function()
        require("oil").setup()
    end,
    },
    {"neanias/everforest-nvim",
    version = false,
    lazy = true,
    priority = 5000,
    config = function()
        require("everforest").setup({
                background = "soft",
                disable_italic_comments = true,
                ui_contrast = "high",
                ---@param highlight_groups Highlights
                ---@param palette Palette
                on_highlights = function(highlight_groups, palette)
                highlight_groups.LineNr = {fg = palette.red}
                highlight_groups.LineNrAbove = {fg = palette.green}
                highlight_groups.LineNrBelow = {fg = palette.green}
            end,
            })
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    showtabline = 2,
                    theme = "everforest",
                    component_separators = {left = "|", right = "|"},
                    section_separators = {left = "", right = ""},

                },
                sections = {
                    lualine_a = {
                        {
                            'mode',
                        },
                        {
                            'filename',
                            file_status = false,
                            newfile_status = true,
                            use_mode_colors = true,
                        },
                    },
                    lualine_c = {},
                },
                refresh = {
                    statusline = 200,
                    tabline = 1000,
                },
                tabline = {
                    lualine_a = {
                        {
                        'buffers',
                        icons_enabled = false,
                            symbols = {
                                modified = '[+]',
                                alternate_file = '',
                                directory = "/",
                            },
                            buffers_color = {
                                active  = {gui = "bold"},
                                inactive = {bg = '#9DA9A0'}
                            },
                        },
                    },
                } 
            })
        end,
    },
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8', -- telescope for file finding 
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function() 
          require("telescope").setup{
              defaults = {
		      initial_mode = "normal",
	      }
          }
      end,
    },
}
opts = {}
local lazy_config = require "configs.lazy"

-- vim options
vim.opt.relativenumber = true
vim.opt.number = true 
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true 
vim.opt.splitbelow = true
vim.opt.sdf = NONE
vim.api.nvim_set_hl(0, "EyelinerPrimary", {fg = '#E67E80', bold = true})
vim.api.nvim_set_hl(0, "EyelinerSecondary", {fg = '#7FBBB3', bold = false})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<S-TAB>', '<cmd>bprev<CR>', opts)
vim.keymap.set('n', '<TAB>', '<cmd>bnext<CR>', opts)
vim.keymap.set('n', '<leader>x', '<cmd>bdelete<CR>', opts)
require("lazy").setup(plugins, lazy_config)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.api.nvim_set_hl(0, '@org.agenda.deadline', {fg = '#FF0000'})
vim.api.nvim_set_hl(0, '@org.agenda.scheduled', {link = 'Identifier'})
-- dofile(vim.g.base46_cache .. "defaults")
-- dofile(vim.g.base46_cache .. "statusline")
-- dofile(vim.g.base46_cache .. "syntax")
-- dofile(vim.g.base46_cache .. "treesitter")
-- dofile(vim.g.base46_cache .. "git")
-- dofile(vim.g.base46_cache .. "nvimtree")
require("everforest").load()

vim.pack.add({
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

-- Build fzf-native if make is available
-- Note: This will run after the plugin is downloaded on first startup
vim.defer_fn(function()
	local fzf_path = vim.fn.stdpath("data") .. "/pack/downloads/opt/telescope-fzf-native.nvim"
	if vim.fn.executable("make") == 1 and vim.fn.isdirectory(fzf_path) == 1 then
		vim.system({"make"}, { cwd = fzf_path })
	end
end, 1000)
		-- Telescope is a fuzzy finder that comes with a lot of different things that
		-- it can fuzzy find! It's more than just a "file finder", it can search
		-- many different aspects of Neovim, your workspace, LSP, and more!
		--
		-- The easiest way to use Telescope, is to start by doing something like:
		--  :Telescope help_tags
		--
		-- After running this command, a window will open up and you're able to
		-- type in the prompt window. You'll see a list of `help_tags` options and
		-- a corresponding preview of the help.
		--
		-- Two important keymaps to use while in Telescope are:
		--  - Insert mode: <c-/>
		--  - Normal mode: ?
		--
		-- This opens a window that shows you all of the keymaps for the current
		-- Telescope picker. This is really useful to discover what Telescope can
		-- do as well as how to actually do it!

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		local actions = require("telescope.actions")
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			defaults = {
				file_ignore_patterns = {
					"*.lock",
					"target/.*",
					"BraveSoftware/.*",
					"Code %- OSS",
					"hypr/wallpapers/",
				},
				mappings = {
					i = {
						["<c-enter>"] = "to_fuzzy_refine",
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<CR>"] = function(prompt_bufnr)
							actions.select_default(prompt_bufnr)
							-- Change to git root after selecting
							vim.defer_fn(function()
								local git_root =
									vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
								if vim.v.shell_error == 0 and git_root ~= "" then
									vim.cmd("lcd " .. git_root)
								end
							end, 100)
						end,
						-- ['<Esc>'] = actions.close,
					},
				},
			},
			-- pickers = {}
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		vim.keymap.set("n", "<leader>sR", function()
			builtin.live_grep({
				prompt_title = "Rust Docs",
				search_dirs = { vim.fn.systemlist("rustup doc --path")[1] },
			})
		end, { desc = "Search [R]ust Documentation" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
		vim.keymap.set("n", "<leader>sc", function()
			builtin.find_files({ cwd = "~/.config" })
		end, { desc = "[S]earch [C]onfig dotfiles" })

		vim.keymap.set("n", "<leader>sl", function()
			vim.diagnostic.setloclist({ open = false })
			-- if vim.tbl_isempty(vim.fn.getloclist()) then
			--   vim.notify('Good Job!! Local Quickfix list is empty', vim.log.levels.WARN)
			--   return
			-- end
			builtin.loclist()
		end, { desc = "Show [L]ocal Quickfix List" })
		vim.keymap.set("n", "<leader>sq", function()
			vim.diagnostic.setqflist({ open = false })
			if vim.tbl_isempty(vim.fn.getqflist()) then
				vim.notify("Good Job!! Global Quickfix list is empty", vim.log.levels.WARN)
				return
			end
			builtin.quickfix()
		end, { desc = "Show Global [Q]uickfix List" })

		-- Diagnostic filtering by severity
		vim.keymap.set("n", "<leader>se", function()
			builtin.diagnostics({ severity = vim.diagnostic.severity.ERROR })
		end, { desc = "[S]earch [E]rrors only" })

		vim.keymap.set("n", "<leader>sw", function()
			builtin.diagnostics({ severity = vim.diagnostic.severity.WARN })
		end, { desc = "[S]earch [W]arnings only" })

		vim.keymap.set("n", "<leader>si", function()
			builtin.diagnostics({
				severity = { vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT },
			})
		end, { desc = "[S]earch [I]nfo/Hints" })

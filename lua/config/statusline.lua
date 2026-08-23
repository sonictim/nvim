-- Statusline (replaces lualine — no plugins needed)
-- web-devicons still loaded via oil.lua

local pal = {
    bg     = "#1a1b26",
    fg     = "#c0caf5",
    dim    = "#565f89",
    blue   = "#7aa2f7",
    green  = "#9ece6a",
    purple = "#9d7cd8",
    orange = "#e0af68",
    red    = "#f7768e",
    cyan   = "#7dcfff",
}

local function set_hls()
    local p = pal
    vim.api.nvim_set_hl(0, "SLN", { fg = p.bg, bg = p.blue, bold = true })
    vim.api.nvim_set_hl(0, "SLBr", { fg = p.blue, bg = "none" })

    vim.api.nvim_set_hl(0, "SLI", { fg = p.bg, bg = p.green, bold = true })
    vim.api.nvim_set_hl(0, "SLIt", { fg = p.green, bg = "none" })

    vim.api.nvim_set_hl(0, "SLV", { fg = p.bg, bg = p.purple, bold = true })
    vim.api.nvim_set_hl(0, "SLVt", { fg = p.purple, bg = "none" })

    vim.api.nvim_set_hl(0, "SLC", { fg = p.bg, bg = p.orange, bold = true })
    vim.api.nvim_set_hl(0, "SLW", { fg = p.orange, bg = "none" })

    vim.api.nvim_set_hl(0, "SLR", { fg = p.bg, bg = p.red, bold = true })
    vim.api.nvim_set_hl(0, "SLE", { fg = p.red, bg = "none" })

    vim.api.nvim_set_hl(0, "SLT", { fg = p.bg, bg = p.cyan, bold = true })
    vim.api.nvim_set_hl(0, "SLTt", { fg = p.cyan, bg = "none" })

    vim.api.nvim_set_hl(0, "text", { fg = p.fg, bg = "none" })
    vim.api.nvim_set_hl(0, "SLDm", { fg = p.dim, bg = "none" })
end

set_hls()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hls })

local modes = {
    n = { " NORMAL ", "SLN", "SLBr" },
    no = { " O-PEND ", "SLN", "SLBr" },
    i = { " INSERT ", "SLI", "SLIt" },
    ic = { " INSERT ", "SLI", "SLIt" },
    v = { " VISUAL ", "SLV", "SLVt" },
    vs = { " VISUAL ", "SLV", "SLVt" },
    V = { " V-LINE ", "SLV", "SLVt" },
    Vs = { " V-LINE ", "SLV", "SLVt" },
    ["\22"] = { " V-BLOCK ", "SLV", "SLVt" },
    c = { " COMMAND ", "SLC", "SLW" },
    R = { " REPLACE ", "SLR", "SLE" },
    Rv = { " V-REPL ", "SLR", "SLE" },
    t = { " TERMINAL ", "SLT", "SLTt" },
    s = { " SELECT ", "SLT", "SLTt" },
    S = { " S-LINE ", "SLT", "SLTt" },
}
local function file_icon()
    local ok, devicons = pcall(require, 'nvim-web-devicons')
    if not ok then return '' end
    local fname = vim.fn.expand('%:t')
    local ext   = vim.fn.expand('%:e')
    return devicons.get_icon(fname, ext) or ''
end

function _G.Statusline()
    local mode = vim.fn.mode()
    local m = modes[mode] or { " " .. mode:upper() .. " ", "SLN" }
    local hl = "%#" .. m[2] .. "#"  -- mode colour only
    local txt = "%#" .. m[3] .. "#" -- mode colour only
    local pill = hl .. m[1]         -- mode colour + mode name

    local branch = vim.b.gitsigns_head
    local br = branch and (txt .. "   " .. branch .. "  ") or ""

    local dc = vim.diagnostic.count(0)
    local de = dc[vim.diagnostic.severity.ERROR] or 0
    local dw = dc[vim.diagnostic.severity.WARN] or 0
    local diag = (de > 0 and ("%#SLE# " .. de .. " ") or "")
        .. (dw > 0 and ("%#SLW# " .. dw .. " ") or "")

    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

    local ft = vim.bo.filetype
    local icon = file_icon()
    local ft_str = ft ~= "" and ("[%#SLW#" .. (icon ~= "" and icon .. " " or "") .. "%#SLBr#" .. ft .. "%#SLDm#]") or ""

    return pill .. br .. diag
        .. " %#text# %f %m%r"
        .. "%="
        .. "%#SLBr#󰉋 " .. cwd .. "%#SLDm#  %{&encoding}  %{&fileformat}  " .. ft_str .. "  "
        .. "%#text#%p%%  "
        .. hl .. " %l:%c "
end

vim.o.laststatus = 3
vim.o.statusline = "%{%v:lua.Statusline()%}"


--
--   U+E0B0  right solid
--   U+E0B2  left solid
--   U+E0B1  right thin
--   U+E0B3  left thin
--
--
-- ▶  U+25B6
-- ▷  U+25B7
-- ◀  U+25C0
-- ◁  U+25C1
--
-- ▲  U+25B2
-- △  U+25B3
-- ▼  U+25BC
-- ▽  U+25BD
-- ●  U+25CF
-- ○  U+25CB
-- ◉  U+25C9
-- ◎  U+25CE
--
-- ◆  U+25C6
-- ◇  U+25C7
--
-- ■  U+25A0
-- □  U+25A1
-- ▪  U+25AA
-- ▫  U+25AB
--
-- │
-- ┃
-- ▏
-- ▕
-- ╱
-- ╲
-- ⟩
-- ⟪
-- ⟫
-- »
-- «
--
-- ❯
-- ❮
-- ➜
-- ➤
-- →
-- ←
-- ⟶
-- ⟵
--
--
--  
--
--
--

--
--
--
--
-- ████▶  █████████████████
-- █████████████████████

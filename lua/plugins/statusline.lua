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
    vim.api.nvim_set_hl(0, "SLI", { fg = p.bg, bg = p.green, bold = true })
    vim.api.nvim_set_hl(0, "SLV", { fg = p.bg, bg = p.purple, bold = true })
    vim.api.nvim_set_hl(0, "SLC", { fg = p.bg, bg = p.orange, bold = true })
    vim.api.nvim_set_hl(0, "SLR", { fg = p.bg, bg = p.red, bold = true })
    vim.api.nvim_set_hl(0, "SLT", { fg = p.bg, bg = p.cyan, bold = true })
    vim.api.nvim_set_hl(0, "SLBr", { fg = p.blue, bg = "none" })
    vim.api.nvim_set_hl(0, "SLE", { fg = p.red, bg = "none" })
    vim.api.nvim_set_hl(0, "SLW", { fg = p.orange, bg = "none" })
    vim.api.nvim_set_hl(0, "SLDm", { fg = p.dim, bg = "none" })
end

set_hls()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hls })

local modes = {
    n = { " NORMAL ", "SLN" },
    no = { " O-PEND ", "SLN" },
    i = { " INSERT ", "SLI" },
    ic = { " INSERT ", "SLI" },
    v = { " VISUAL ", "SLV" },
    vs = { " VISUAL ", "SLV" },
    V = { " V-LINE ", "SLV" },
    Vs = { " V-LINE ", "SLV" },
    ["\22"] = { " V-BLOCK", "SLV" },
    c = { " COMMAND ", "SLC" },
    R = { " REPLACE ", "SLR" },
    Rv = { " V-REPL ", "SLR" },
    t = { " TERMINAL", "SLT" },
    s = { " SELECT ", "SLT" },
    S = { " S-LINE ", "SLT" },
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
    local pill = "%#" .. m[2] .. "#" .. m[1]

    local branch = vim.b.gitsigns_head
    local br = branch and ("%#SLBr#  " .. branch .. "  ") or ""

    local dc = vim.diagnostic.count(0)
    local de = dc[vim.diagnostic.severity.ERROR] or 0
    local dw = dc[vim.diagnostic.severity.WARN] or 0
    local diag = (de > 0 and ("%#SLE# " .. de .. " ") or "")
        .. (dw > 0 and ("%#SLW# " .. dw .. " ") or "")

    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

    local ft = vim.bo.filetype
    local icon = file_icon()
    local ft_str = ft ~= "" and ("[" .. (icon ~= "" and icon .. " " or "") .. ft .. "]") or ""

    return pill .. br .. diag
        .. "%#StatusLine# %f %m%r"
        .. "%="
        .. "%#SLDm#󰉋 " .. cwd .. "  %{&encoding}  %{&fileformat}  " .. ft_str .. "  "
        .. "%p%%  "
        .. pill .. " %l:%c "
end

vim.o.statusline = "%{%v:lua.Statusline()%}"

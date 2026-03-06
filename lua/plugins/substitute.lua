-- Plugin: gbprod/substitute.nvim
-- Installed via store.nvim
-- Note: Using 'gS' prefix instead of 'gs' to avoid conflicts with mini-surround
-- mini-surround keymaps: sa, sd, sc, sF, sf, sh, sr
-- Our keymaps: gS, gSS, gSE, gSV (visual)

return {
    "gbprod/substitute.nvim",
    opts = {},
    config = function()
        local substitute = require('substitute')

        substitute.setup()

        -- Use 'gS' as prefix to avoid conflicts with mini-surround (sa, sd, sc, etc.)
        vim.keymap.set('n', 'gS', substitute.operator, { noremap = true, desc = "Substitute operator" })
        vim.keymap.set('n', 'gSS', substitute.line, { noremap = true, desc = "Substitute line" })
        vim.keymap.set('n', 'gSE', substitute.eol, { noremap = true, desc = "Substitute to end of line" })
        vim.keymap.set('x', 'gSV', substitute.visual, { noremap = true, desc = "Substitute visual selection" })
    end
}

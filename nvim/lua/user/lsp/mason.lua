local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({})

local servers = { "jsonls", "sumneko_lua" }
lspconfig.setup {
    ensure_installed = servers,
}

local nvim_lsp = require "lspconfig"

lspconfig.setup_handlers {
    function(server_name)
        nvim_lsp[server_name].setup{}
    end,
}

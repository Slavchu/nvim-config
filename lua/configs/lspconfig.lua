local merge_tb = vim.tbl_deep_extend

local configs = require("nvchad.configs.lspconfig")
local on_init = configs.on_init
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require("lspconfig")
local servers = { "clangd", "gopls" }

for _, lsp in ipairs(servers) do
	local opts = {
		on_init = on_init,
		on_attach = on_attach,
		capabilities = capabilities,
	}

	local exists, settings = pcall(require, "configs.lsp.server-settings." .. lsp)
	if exists then
		opts = merge_tb("force", settings, opts)
	end

	lspconfig[lsp].setup(opts)
end


local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
-- 对mason进行初始化设置
mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
-- 对mason_lspconfig进行初始化设置，同时自动安装ensure_installed中的lsp服务
mason_lspconfig.setup({
	ensure_installed = { "clangd", "pyright" },
})
-- 对lsp服务进行初始化
mason_lspconfig.setup_handlers({
	function(server_name) -- 当lsp服务加载成功时，该函数被调用
		-- 首先定义了一个公用的配置，包括lsp快捷键、禁用格式化等
    local common_opt = {
			flags = {
				debounce_text_changes = 150,
			},
			on_attach = function(client, bufnr)
				-- 禁用格式化功能，交给专门插件插件处理
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false

				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end
				-- 绑定快捷键
				require("keybindings").mapLSP(buf_set_keymap)
			end,
		}
    -- 定义了公用的配置之后，尝试加载针对特定lsp服务的配置，若有则插入common_opt中
    -- 对于这些额外的配置可以在 https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md 查看
		local status, config = pcall(require, "lsp.config." .. server_name)
		if status then
			for k, v in pairs(config) do
				common_opt[k] = v
			end
		end
		lspconfig[server_name].setup(common_opt)
	end,
})

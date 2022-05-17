-- 基础配置
require("basic")
-- 快捷键配置
require("keybindings")
-- 插件管理
require("plugins")
-- 主题设置
require("colorscheme")
-- 自动命令
require("autocmds")
-- 插件配置
require("plugin-config.nvim-tree") -- 侧边栏
require("plugin-config.bufferline") -- 顶部标签页
require("plugin-config.lualine") -- 底部信息栏
require("plugin-config.telescope") -- 模糊测试插件
require("plugin-config.nvim-treesitter") -- 代码高亮插件
require("plugin-config.surround") -- 高效操作与括号、引号或html、xml标签相关的配对符号
require("plugin-config.comment") -- 代码注释插件
require("plugin-config.nvim-autopairs") -- 括号自动补全
require("plugin-config.fidget") -- lsp进度显示
-- 内置LSP
require("lsp.setup")
require("lsp.cmp") -- 代码自动补全
require("lsp.ui")
require("lsp.null-ls")

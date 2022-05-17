local lsp_installer = require("nvim-lsp-installer")

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  pyright = require("lsp.config.pyright"),
  clangd = require("lsp.config.clangd"),
}

-- 自动安装 Language Servers
for name, config in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    else
      if type(config) == "table" and config.on_init then
        config.on_init(server)
        print("onInit " .. type(config))
      end
    end
  end
end

lsp_installer.on_server_ready(function(server)
  local config = servers[server.name]
  if config == nil then
    return
  end
  if type(config) == "table" and config.on_setup then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(server)
  else
    -- 使用默认参数
    server:setup({})
  end
end)

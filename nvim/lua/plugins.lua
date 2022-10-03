-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("正在安装Pakcer.nvim，请稍后...")
  paccker_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    -- "https://gitcode.net/mirrors/wbthomason/packer.nvim",
    install_path,
  })

  -- https://github.com/wbthomason/packer.nvim/issues/750
  local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end
  vim.notify("Pakcer.nvim 安装完毕")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("没有安装 packer.nvim")
  return
end


packer.startup({
  function(use)
   -- Packer 本身
   use('wbthomason/packer.nvim')
   -- 插件列表
   -- 主题插件
   use("folke/tokyonight.nvim")
   -- 侧边栏插件nvim-tree
   use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
   -- 标签页插件bufferline
   use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }})
   -- 底部信息栏lualine
   use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
   use("arkav/lualine-lsp-progress")
   -- 模糊搜索Telescope
   use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }
   -- 代码高亮插件
   use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
   --------------------- LSP --------------------
   use{"williamboman/mason.nvim","williamboman/mason-lspconfig.nvim","neovim/nvim-lspconfig"}
   -- 补全引擎
   use("hrsh7th/nvim-cmp")
   -- Snippet 引擎
   use("hrsh7th/vim-vsnip")
   -- 补全源
   use("hrsh7th/cmp-vsnip")
   use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
   use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
   use("hrsh7th/cmp-path") -- { name = 'path' }
   use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
   use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }
   -- 常见编程语言代码段
   use("rafamadriz/friendly-snippets")
   -- UI 增强
   use("onsails/lspkind-nvim")
   use("tami5/lspsaga.nvim")
   -- 代码格式化
   use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
   -- surround
   use("ur4ltz/surround.nvim")
   -- Comment
   use("numToStr/Comment.nvim")
   -- nvim-autopairs
   use("windwp/nvim-autopairs")
   -- 跨ssh复制
   use("ojroques/vim-oscyank")
   -- 显示lsp索引进度
   use("j-hui/fidget.nvim")

   end,
   config = {
    -- 设置插件快照路径
    snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),
    -- 锁定插件版本为v2
    snapshot = "v3",
    -- 并发数限制
    max_jobs = 16,
    -- 自定义源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
  },
})

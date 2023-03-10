-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim") -- packer
  use("bluz71/vim-nightfly-colors") -- color scheme
  
  -- plugins for text editing
  use("tpope/vim-surround")
  use("vim-scripts/ReplaceWithRegister")
  use("nvim-lua/plenary.nvim") -- commonly used lua functions
  -- easy outcommenting
  use("numToStr/Comment.nvim")
  -- file explorer plugins
  use("nvim-tree/nvim-tree.lua")

  -- configure mason for lsp server management
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- snippets and completions
  use("hrsh7th/nvim-cmp") -- completion framework
  use("hrsh7th/cmp-nvim-lsp") -- lsp completion source
  use({"glepnir/lspsaga.nvim", branch = "main"})
  use("jose-elias-alvarez/typescript.nvim")
  use("onsails/lspkind.nvim")


  -- useful snippet resources
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-nvim-lsp-signature-help")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/vim-vsnip")

  -- lsp server config
  use("neovim/nvim-lspconfig")
  -- rust tools
  use("simrat39/rust-tools.nvim")
  -- git tools
  use("dinhhuy258/git.nvim")
  use("lewis6991/gitsigns.nvim")

  -- pretty icons
  use("nvim-tree/nvim-web-devicons")
  -- pretty status bar
  use("nvim-lualine/lualine.nvim")

  -- markdown previews
  use("ellisonleao/glow.nvim")

  -- auto close brackets
  use("windwp/nvim-autopairs")

  if packer_bootstrap then
    require("packer").sync()
  end
end)

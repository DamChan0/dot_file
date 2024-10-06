require('packer').startup(function(use)
  -- Packer 자신
  use 'wbthomason/packer.nvim'

  -- 파일 탐색기 (NERDTree 대체)
  use 'kyazdani42/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons'

  -- 코드 하이라이팅 및 문법 체크 (Syntastic 대체)
  use 'nvim-treesitter/nvim-treesitter'
  use 'dense-analysis/ale'

  -- 상태 표시줄
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -- 색상 테마
  use 'morhetz/gruvbox'
  use 'folke/tokyonight.nvim'

  -- 자동 완성 (AutoComplPop 대체)
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- LSP 설정
  use 'neovim/nvim-lspconfig'
  
  -- 주석 플러그인 (nerdcommenter 대체)
  use 'tpope/vim-commentary'

  -- 파일 및 내용 검색 (CtrlP 대체)
  use 'nvim-telescope/telescope.nvim'

  -- Git 통합
  use 'tpope/vim-fugitive'
end)

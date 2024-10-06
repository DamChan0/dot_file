" Plug 시작 부분
call plug#begin('~/.local/share/nvim/plugged')

" 파일 탐색기 및 아이콘 지원
Plug 'preservim/nerdtree'        " NERDTree: 파일 탐색기
Plug 'ryanoasis/vim-devicons'    " 파일 아이콘 지원

" 코드 하이라이팅 및 문법 검사
Plug 'sheerun/vim-polyglot'      " 다중 언어 구문 강조 (Neovim v0.4.3에 적합)
Plug 'dense-analysis/ale'        " ALE: 실시간 문법 검사 및 오류 표시

" 상태 표시줄 및 테마
Plug 'vim-airline/vim-airline'   " Airline: 가벼운 상태 표시줄
Plug 'vim-airline/vim-airline-themes' " Airline 테마

" 색상 테마
Plug 'morhetz/gruvbox'           " Gruvbox 테마: 다크 모드 테마
Plug 'joshdick/onedark.vim'      " OneDark 테마: Atom 에디터 스타일

" 자동 완성 및 코드 탐색
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1


" 텍스트 조작 및 편집 도구
Plug 'tpope/vim-commentary'      " Vim-Commentary: 주석 처리 플러그인
Plug 'tpope/vim-surround'        " Vim-Surround: 텍스트 둘러싸기 조작
Plug 'tpope/vim-repeat'          " Vim-Repeat: `.` 명령어 반복 기능 강화
Plug 'easymotion/vim-easymotion' " EasyMotion: 키 조합으로 빠른 텍스트 이동

" Git 통합
Plug 'tpope/vim-fugitive'        " Vim-Fugitive: Git 통합

" Plug 끝 부분
call plug#end()

" 기본 설정
set number          " 라인 번호 표시
set norelativenumber  " 상대적 줄 번호 비활성화
set cursorline      " 커서 라인 강조
set autoindent      " 자동 들여쓰기
set smartindent     " 스마트 들여쓰기
set shiftwidth=4    " 들여쓰기 시 사용되는 공백 수
set tabstop=4       " 탭을 4칸으로 설정
set expandtab       " 탭을 공백으로 변환
set ignorecase      " 검색 시 대소문자 무시
set smartcase       " 대소문자 구별 검색
set hlsearch        " 검색 결과 하이라이트
set incsearch       " 점진적 검색
set termguicolors   " 24비트 RGB 색상 사용
set background=dark " 다크 배경

" 색상 테마 설정
colorscheme gruvbox

" NERDTree 설정
nmap <C-n> :NERDTreeToggle<CR>  " Ctrl+n으로 NERDTree 토글

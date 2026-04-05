# dotfiles

[chezmoi](https://www.chezmoi.io/)로 관리하는 Linux 개발 환경 설정 파일 모음.

새 머신에서 **한 줄**로 프로그램 설치 + 설정 파일 적용이 완료됩니다.

## 빠른 시작

### 새 머신에 처음 설정

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply DamChan0 --source dot_file
```

이 명령 하나로 다음이 순서대로 실행됩니다:

1. chezmoi 설치
2. 이 저장소 clone
3. `run_once_install-packages.sh` 실행 (필요한 프로그램 자동 설치)
4. 모든 설정 파일을 홈 디렉토리에 적용

### 이미 설정된 머신에서 최신 상태로 업데이트

```bash
chezmoi update
```

## 자동 설치되는 프로그램

`run_once_install-packages.sh`가 최초 1회 실행되며, 이미 설치된 항목은 건너뜁니다.

| 분류 | 프로그램 | 설치 방법 |
|------|----------|-----------|
| 폰트 | [MesloLGS Nerd Font](https://github.com/ryanoasis/nerd-fonts) | GitHub release |
| Shell | zsh | apt |
| Shell 프레임워크 | [Oh My Zsh](https://ohmyz.sh/) | 공식 스크립트 |
| Shell 테마 | [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | git clone (omz custom theme) |
| Shell 플러그인 | zsh-autosuggestions, zsh-syntax-highlighting | git clone (omz custom plugin) |
| 편집기 | [Neovim](https://neovim.io/) (latest) | GitHub release |
| 터미널 멀티플렉서 | [Zellij](https://zellij.dev/) | cargo install |
| 검색 도구 | fzf, ripgrep, fd-find | apt |
| 시스템 모니터 | [btop](https://github.com/aristocratos/btop) | apt |
| 스크린샷 | [Flameshot](https://flameshot.org/) | apt |
| 한글 입력 | [fcitx5](https://fcitx-im.org/) + hangul | apt |
| 버전 관리 | git, [GitHub CLI](https://cli.github.com/) | apt |
| 언어 런타임 | [Rust](https://rustup.rs/) (rustup) | 공식 스크립트 |
| 언어 런타임 | [Node.js](https://nodejs.org/) LTS ([nvm](https://github.com/nvm-sh/nvm)) | nvm |
| 빌드 도구 | build-essential, curl, wget, unzip | apt |

## 관리되는 설정 파일

```
~
├── .zshrc                          # Zsh 메인 설정 (oh-my-zsh + powerlevel10k)
├── .bashrc                         # Bash 설정
├── .p10k.zsh                       # Powerlevel10k 프롬프트 테마
├── .zshenv                         # Zsh 환경변수 (cargo)
├── .zsh_plugins.txt                # antidote 플러그인 목록
├── .zsh_plugins.zsh                # antidote 플러그인 로더
├── .profile                        # 로그인 쉘 PATH 설정
├── .gitconfig                      # Git 사용자 정보 + gh credential helper
├── .xinputrc                       # fcitx5 한글 입력기 설정
└── .config/
    ├── nvim/                       # Neovim (LazyVim 기반)
    │   ├── init.lua
    │   ├── lazy-lock.json
    │   └── lua/
    │       ├── config/
    │       │   ├── autocmds.lua
    │       │   ├── keymaps.lua
    │       │   ├── lazy.lua
    │       │   └── options.lua
    │       └── plugins/
    │           └── example.lua
    ├── btop/
    │   └── btop.conf               # btop 시스템 모니터 설정
    ├── flameshot/
    │   └── flameshot.ini            # Flameshot 스크린샷 설정
    └── zellij/
        └── config.kdl              # Zellij 터미널 멀티플렉서 설정
```

## 일상 사용법

### 설정 파일 수정 후 chezmoi에 반영

```bash
# 방법 1: chezmoi를 통해 편집 (자동으로 소스에 반영)
chezmoi edit ~/.zshrc

# 방법 2: 직접 편집한 뒤 수동으로 추가
vim ~/.zshrc
chezmoi add ~/.zshrc
```

### 변경사항 확인 및 적용

```bash
chezmoi diff          # 소스와 홈 디렉토리 차이 확인
chezmoi apply         # 소스 → 홈 디렉토리 적용
chezmoi apply -n      # dry-run (적용하지 않고 미리보기)
```

### 변경사항 저장소에 반영

```bash
chezmoi cd            # chezmoi 소스 디렉토리로 이동
git add -A && git commit -m "update configs"
git push
exit                  # 원래 디렉토리로 복귀
```

### 새 설정 파일 추가

```bash
chezmoi add ~/.config/새파일    # chezmoi 관리 대상에 추가
```

## 참고

- **OS**: Ubuntu (apt 기반 배포판)
- **기본 쉘**: zsh (설치 스크립트에서 `chsh`로 자동 변경)
- **Nerd Font**: MesloLGS Nerd Font가 자동 설치됩니다. 터미널 설정에서 폰트를 `MesloLGS Nerd Font`로 변경하면 됩니다

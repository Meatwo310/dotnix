{ ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number
      set relativenumber
      set cursorline

      set ignorecase
      set smartcase

      set expandtab
      set tabstop=2
      set shiftwidth=2
      set softtabstop=2

      set splitright
      set splitbelow

      let g:mapleader = ' '

      nnoremap <S-l> :bnext<CR>
      nnoremap <S-h> :bprev<CR>

      vnoremap < <gv
      vnoremap > >gv

      nnoremap j gj
      nnoremap k gk
      nnoremap gj j
      nnoremap gk k

      nnoremap <Esc><Esc> :nohlsearch<CR>
      nnoremap n nzzzv
      nnoremap N Nzzzv
    '';
  };
}

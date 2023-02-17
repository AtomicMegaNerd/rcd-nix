{ config, pkgs, unstable, ... }:
{
  home.username = "rcd";
  home.homeDirectory = "/home/rcd";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    wget
    curl
    fzf
    ripgrep
    fd
    exa
    bat
    du-dust
    duf
    htop
    neofetch
    git
    gcc
    gnumake
    zip
    unzip
    go
    jq
    python311
    tldr
    grc
    procs
    just
    exercism
    poetry
    ruff
    yarn
    go-tools
  ];


  programs.bash = {
    enable = false;
  };

  programs.neovim = {
    package = unstable.neovim-unwrapped;
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    extraPackages = with unstable; [
      # Language servers
      pyright
      gopls
      sumneko-lua-language-server
      rnix-lsp
      ruff
      rust-analyzer
      yaml-language-server
      nodePackages.bash-language-server
      nodePackages.typescript-language-server

      # null-ls sources
      black
      gofumpt
      mypy
      shellcheck
      stylua
      nixpkgs-fmt
      nodePackages.prettier
      nodePackages.markdownlint-cli
    ];

    plugins = with unstable.vimPlugins;
      let
        nvim-transparent = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-transparent";
          src = pkgs.fetchFromGitHub {
            owner = "xiyaowong";
            repo = "nvim-transparent";
            rev = "6816751e3d595b3209aa475a83b6fbaa3a5ccc98";
            sha256 = "sha256-j1PO0r2q5w0fJvO7BG0xXDjIdOVl73eGO1rclB221uw=";
          };
        };
      in
      [
        nvim-transparent
        nvim-treesitter.withAllGrammars
        alpha-nvim
        telescope-nvim
        telescope-ui-select-nvim
        telescope-file-browser-nvim
        telescope-fzf-native-nvim
        nightfox-nvim
        gitsigns-nvim
        nvim-lspconfig
        null-ls-nvim
        fidget-nvim
        nvim-cmp
        cmp-nvim-lsp
        cmp-path
        cmp-buffer
        cmp_luasnip
        luasnip
        lspkind-nvim
        lualine-nvim
        nvim-web-devicons
        plenary-nvim
        rust-tools-nvim
        comment-nvim
        todo-comments-nvim
        which-key-nvim
        vim-eunuch
        vim-fugitive
        vim-test
        vim-rooter
      ];
  };

  programs.fish =
    {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting # Disable greeting

        ### Nightfox theme ###
        set -l foreground cdcecf
        set -l selection 223249
        set -l comment 526176
        set -l red c94f6d
        set -l orange f4a261
        set -l yellow dbc074
        set -l green 81b29a
        set -l purple 9d79d6
        set -l cyan 63cdcf
        set -l pink d67ad2

        # Syntax Highlighting Colors
        set -g fish_color_normal $foreground
        set -g fish_color_command $cyan
        set -g fish_color_keyword $pink
        set -g fish_color_quote $yellow
        set -g fish_color_redirection $foreground
        set -g fish_color_end $orange
        set -g fish_color_error $red
        set -g fish_color_param $purple
        set -g fish_color_comment $comment
        set -g fish_color_selection --background=$selection
        set -g fish_color_search_math --background=$selection
        set -g fish_color_operator $green
        set -g fish_color_escape $pink
        set -g fish_color_autosuggestion $comment

        # Completion Pager Colors
        set -g fish_pager_color_progress $comment
        set -g fish_pager_color_prefix $cyan
        set -g fish_pager_color_completion $foreground
        set -g fish_pager_color_description $commentc

        # omf configuration 
        set -x VIRTUAL_ENV_DISABLE_PROMPT 1
        set -g theme_nerd_fonts yes
        set -g theme_color_scheme nord
        set -g theme_newline_cursor yes
        set -g theme_newline_prompt '% ' 
      '';

      shellAliases = {
        ls = "exa";
        ll = "exa -lah";
        df = "duf";
        cat = "bat --paging=never --style=plain";

        # Directory aliases
        ch = "cd ~";
        csrc = "cd ~/Code";
        cr = "cd ~/Code/Rust/";
        cg = "cd ~/Code/Go/";
        cpy = "cd ~/Code/Python/";
        ce = "cd ~/Code/Exercism/";
        cgo = "cd ~/Code/Go/";
        cdot = "cd ~/Code/Nix/rcd-nix";

        # Just use ripgrep
        grep = "rg";

        tl = "tmux list-sessions";
        ta = "tmux attach";
        tk = "tmux kill-session";
        tka = "tmux kill-server";
      };

      functions =
        {
          tn = "tmux new -s (basename (eval pwd))";
        };

      plugins = [
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "bobthefish";
          src = pkgs.fetchFromGitHub
            {
              owner = "oh-my-fish";
              repo = "theme-bobthefish";
              rev = "2dcfcab653ae69ae95ab57217fe64c97ae05d8de";
              sha256 = "jBbm0wTNZ7jSoGFxRkTz96QHpc5ViAw9RGsRBkCQEIU=";
            };
        }
      ];
    };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
  };

  xdg.configFile = {
    nvim = {
      source = ../common/nvim;
      target = "nvim";
    };
    tmux = {
      source = ../common/tmux;
      target = "tmux";
    };
  };

  programs.git = {
    enable = true;
    userName = "Chris Dunphy";
    userEmail = "chris@megaparsec.ca";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
}

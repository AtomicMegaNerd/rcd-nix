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

    plugins = [
      unstable.vimPlugins.nvim-treesitter.withAllGrammars
      unstable.vimPlugins.alpha-nvim
      unstable.vimPlugins.telescope-nvim
      unstable.vimPlugins.telescope-ui-select-nvim
      unstable.vimPlugins.telescope-file-browser-nvim
      unstable.vimPlugins.telescope-fzf-native-nvim
      unstable.vimPlugins.nightfox-nvim
      unstable.vimPlugins.gitsigns-nvim
      unstable.vimPlugins.nvim-lspconfig
      unstable.vimPlugins.null-ls-nvim
      unstable.vimPlugins.fidget-nvim
      unstable.vimPlugins.nvim-cmp
      unstable.vimPlugins.cmp-nvim-lsp
      unstable.vimPlugins.cmp-path
      unstable.vimPlugins.cmp-buffer
      unstable.vimPlugins.cmp_luasnip
      unstable.vimPlugins.luasnip
      unstable.vimPlugins.lspkind-nvim
      unstable.vimPlugins.lualine-nvim
      unstable.vimPlugins.nvim-web-devicons
      unstable.vimPlugins.plenary-nvim
      unstable.vimPlugins.rust-tools-nvim
      unstable.vimPlugins.comment-nvim
      unstable.vimPlugins.todo-comments-nvim
      unstable.vimPlugins.which-key-nvim
      unstable.vimPlugins.vim-eunuch
      unstable.vimPlugins.vim-fugitive
      unstable.vimPlugins.vim-test
      unstable.vimPlugins.vim-rooter
    ];
  };

  programs.bash = {
    enable = false;
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

  # Some weird bug
  manual.manpages.enable = false;
  manual.html.enable = false;
  manual.json.enable = false;

}

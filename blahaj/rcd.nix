{ config, pkgs, unstable, ... }:
{
  home.username = "rcd";
  home.homeDirectory = "/home/rcd";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = with unstable; [
    neofetch
    oh-my-posh
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.neovim = {
    package = unstable.neovim-unwrapped;
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    extraPackages = with unstable; [
      # Language servers
      sumneko-lua-language-server
      rnix-lsp

      # null-ls sources
      shellcheck
      stylua
      nixpkgs-fmt
      nodePackages.markdownlint-cli
    ];

    plugins = with unstable.vimPlugins;
      let
        nvim-transparent = unstable.vimUtils.buildVimPlugin {
          name = "nvim-transparent";
          src = unstable.fetchFromGitHub {
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

  programs.fish = {
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

      set -x VIRTUAL_ENV_DISABLE_PROMPT 1

      oh-my-posh init fish --config ~/.config/oh-my-posh/rcd.omp.json | source
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
        src = unstable.fishPlugins.grc.src;
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
    oh-my-posh = {
      source = ../common/oh-my-posh;
      target = "oh-my-posh";
    };
    poetry = {
      source = ../common/poetry;
      target = "poetry";
    };
  };

  programs.git = {
    enable = true;
    userName = "Chris Dunphy";
    userEmail = "chris@megaparsec.ca";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
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

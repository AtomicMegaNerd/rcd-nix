{ config, pkgs, unstable, ... }:
{
  home.username = "root";
  home.homeDirectory = "/root";
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
    grc
  ];

  programs.neovim = {
    package = unstable.neovim-unwrapped;
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    plugins = [
      unstable.vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };

  programs.fish =
    {
      enable = true;

      shellInit = ''
        set -gx NIX_PATH $NIX_PATH:$HOME/.nix-defexpr/channels
      '';

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
      '';

      shellAliases = {
        ls = "exa";
        ll = "exa -lah";
        df = "duf";
        cat = "bat --paging=never --style=plain";

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
      ];
    };


  programs.tmux = {
    enable = true;
    prefix = "C-a";
    extraConfig = ''
      		# Nightfox Theme for tmux
      		################################################################
      		set -g mode-style "fg=#719cd6,bg=#3b4261"
      		set -g message-style "fg=#719cd6,bg=#3b4261"
      		set -g message-command-style "fg=#719cd6,bg=#3b4261"
      		set -g pane-border-style "fg=#3b4261"
      		set -g pane-active-border-style "fg=#719cd6"
      		set -g status "on"
      		set -g status-justify "left"
      		set -g status-style "fg=#719cd6,bg=#131A24"
      		set -g status-left-length "100"
      		set -g status-right-length "100"
      		set -g status-left-style NONE
      		set -g status-right-style NONE
      		set -g status-left "#[fg=#393b44,bg=#719cd6,bold] #S #[fg=#719cd6,bg=#131A24,nobold,nounderscore,noitalics]"
      		set -g status-right "#[fg=#131A24,bg=#131A24,nobold,nounderscore,noitalics]#[fg=#719cd6,bg=#131A24] #{prefix_highlight} #[fg=#3b4261,bg=#131A24,nobold,nounderscore,noitalics]#[fg=#719cd6,bg=#3b4261] %Y-%m-%d  %H:%M #[fg=#719cd6,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#393b44,bg=#719cd6,bold] #h "
      		setw -g window-status-activity-style "underscore,fg=#AEAFB0,bg=#131A24"
      		setw -g window-status-separator ""
      		setw -g window-status-style "NONE,fg=#AEAFB0,bg=#131A24"
      		setw -g window-status-format "#[fg=#131A24,bg=#131A24,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#131A24,bg=#131A24,nobold,nounderscore,noitalics]"
      		setw -g window-status-current-format "#[fg=#131A24,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#719cd6,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#131A24,nobold,nounderscore,noitalics]"

      		# Other tmux settings
      		################################################################

      		# Force Tmux to support more colors
      		set  -g default-terminal "screen-256color"
      		set-option -sa terminal-overrides ",xterm-256color:RGB"

      		# Enable Mouse
      		setw -g mouse on

      		# Neovim recommended
      		set-option -sg escape-time 10
      		set-option -g focus-events on

      		# remap prefix from C-b to C-a
      		unbind C-b
      		set-option -g prefix C-a
      		bind-key C-a send-prefix

      		# Set the base index to something sensible
      		set -g base-index 1
      	  '';
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

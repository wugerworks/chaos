{ super, inputs, ... }:
{ pkgs, lib, ... }:
let GB = 1024 * 1024 * 1024;
in {
  imports = [
    super.users.wuger
    super.users.root
  ];

  ### System  
  system.stateVersion = "23.11";
  time.timeZone = "Europe/Amsterdam";

  nix = {
    settings = {
      sandbox = true;

    # Give root user and wheel group special Nix privileges.
      trusted-users = [ "root" "@wheel" ];

      keep-outputs = true;
      keep-derivations = true;
      builders-use-substitutes = true;
      experimental-features = [ "flakes" "nix-command" ];
      fallback = true;
      warn-dirty = false;

    # Some free space
      min-free = lib.mkDefault (5 * GB);
      extra-trusted-substituters = [
        "https://cache.garnix.io"
        "https://cachix.org/api/v1/cache/emacs"
        "https://colmena.cachix.org"
        "https://hyprland.cachix.org"
        "https://microvm.cachix.org"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://nichijou.cachix.org"
        "https://nix-community.cachix.org"
        "https://nixos-cn.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://numtide.cachix.org"
      ];
      extra-trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
        "nichijou.cachix.org-1:rbaTU9nLgVW9BK/HSV41vsag6A7/A/caBpcX+cR/6Ps="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };
  # Improve nix store disk usage
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  #### Tools
  # Selection of sysadmin tools that can come in handy
  environment.systemPackages = with pkgs; [
    curl
    direnv
    dnsutils
    entr
    file
    git
    jql
    lnav
    lsof
    nmap
    whois
    yq
    zsh
    ## Rust
    #program net-utilization monitor
    bandwhich
    #cat
    bat
    #system monitor
    bottom
    #syntax highlighter
    delta
    #disk space monitor
    du-dust
    #find
    fd
    #text editor
    helix
    #file explorer
    joshuto
    #jq in rust
    jql
    #extended make
    just
    #ls extended
    lsd
    #grep
    ripgrep
    #port Scanner
    rustscan
    #sed
    sd
    #fuzzy
    skim
    #csv toolkit
    xsv
    #HTTP client
    xh
  ];

  #### Environment
  environment = {
    variables = {
      # vim as default editor
      EDITOR = "hx";
      VISUAL = "hx";

      # Use custom `less` colors for `man` pages.
      LESS_TERMCAP_md = "$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)";
      LESS_TERMCAP_me = "$(tput sgr0 2> /dev/null)";

      # Don't clear the screen after quitting a `man` page.
      MANPAGER = "less -X";
    };
    pathsToLink = [ "/share/zsh" ];
  };

  
  # motd
  # programs.rust-motd = {
  #   enable = true;
  #   enableMotdInSSHD = true;
  #   settings = {
  #     global = {
  #       progress_full_character = "=";
  #       progress_empty_character = "-";
  #       progress_prefix = "[";
  #       progress_suffix = "]";
  #     };
  #     uptime.prefix = "up";
  #     filesystems.root = "/";
  #   };
  # };

  # shell settings
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "cd.." = "cd ..";

      # internet ip
      # TODO: explain this hard-coded IP address
      myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";

      mn = ''
        manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | sk --preview="manix '{}'" | xargs manix
      '';

      mkdir = "mkdir -pv";
      cp = "cp -iv";
      mv = "mv -iv";

      ll = "ls -l";
      la = "ls -la";

      path = ''printf \"%b\\n\" \"\''${PATH//:/\\\n}\"'';

      hx = "helix";

      issh = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
    };
  };

  # editor settings
  programs.helix = {
    enable = true;
    settings = {
      theme = "rose_pine";
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
    };
  };

  # git settings
  programs = {
    git = {
      enable = true;
      delta = {
        enable = true;
      };
    };
    gh.settings.git_protocol = "ssh";
  };

  programs.command-not-found.enable = false;
  programs.nix-index.enable = false;

  users.defaultUserShell = pkgs.zsh;
}

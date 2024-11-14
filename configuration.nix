# Edit this configuration file to define what should be installed on your system. Help is available in the configuration.nix(5) man page, on https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
      <home-manager/nixos>  
    ];
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname. networking.networkmanager.enable = true;
  networking.nameservers = [ "9.9.9.9" "8.8.8.8" ];
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    displayManager = {
      sddm = {
        enable = true;
        theme = "eucalyptus-drop";
      };
      defaultSession = "none+i3";
    };
    xserver = {
      xkb.layout = "fr";
      enable = true;
      desktopManager = {xterm.enable=false;};
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          rofi
          picom
          dunst
	  feh
        ];
      };
    }; 
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.openssh.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  programs = {
   zsh = {
      enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
         enable = true;
         theme = "af-magic";
         plugins = [
           "git"
           "npm"
           "history"
           "node"
         ];
      };
    };
  };

  users.users.botman = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "sudo" ];
    packages = with pkgs; [
      bat
      firefox
      kitty
      discord
      docker
      tree
      syncthing
      keepassxc
      pavucontrol
      btop
   ];
  }; 

  home-manager.backupFileExtension = "hm-backup";
  home-manager.users.botman = {
   gtk.enable = true;
   gtk.cursorTheme.name = "macOS-BigSur";
   gtk.cursorTheme.package = pkgs.apple-cursor;
   gtk.theme.name = "cattpuccin";
   nixpkgs.config.allowUnfree = true;
   services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
        pulseSupport = true;
        i3Support = true;
      };
      script = "polybar &";
    };
    home.packages = [ pkgs.dconf ];
    home.stateVersion = "24.05";
  };

  nixpkgs.config.allowUnfree = true;
  nix.extraOptions = ''experimental-features = nix-command flakes'';

  environment.systemPackages = with pkgs; [
    neovim
    neofetch
    git
    unzip
    wget
    clang
    nodejs_22
  ];

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  services.gvfs.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}


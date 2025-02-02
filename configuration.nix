# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/bundle.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-01c03db3-499a-49ce-bfc6-73499a067aad".device = "/dev/disk/by-uuid/01c03db3-499a-49ce-bfc6-73499a067aad";
  networking.hostName = "ddeus-nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.th = {
    isNormalUser = true;
    description = "Thaddeus";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
	tmux
	vim
	vscode
	bitwarden-desktop
	tailscale
	git
	wget
	gedit
	home-manager
	konsole
	tailscale
	busybox
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  
  services.flatpak.enable = true;
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

# Automatic Garbage Collection
nix.gc = {
                automatic = true;
                dates = "weekly";
                options = "--delete-older-than 30d";
        };

nix.settings.experimental-features = [ "nix-command" "flakes" ];

########### Gnome Settings ##########
#  services.xserver.enable = true;
#  
#    # Configure keymap in X11
#  services.xserver.xkb = {
#    layout = "us";
#    variant = "";
#  	};
#  
#  services.xserver.displayManager.gdm.enable = true;
#  services.xserver.desktopManager.gnome.enable = true;
#  environment.gnome.excludePackages = with pkgs; [
#    orca
#    evince
#    # file-roller
#    geary
#    gnome-disk-utility
#    # seahorse
#    # sushi
#    # sysprof
#    #
#    # gnome-shell-extensions
#    #
#    # adwaita-icon-theme
#    # nixos-background-info
#    gnome-backgrounds
#    # gnome-bluetooth
#    # gnome-color-manager
#    # gnome-control-center
#    # gnome-shell-extensions
#    gnome-tour # GNOME Shell detects the .desktop file on first log-in.
#    gnome-user-docs
#    # glib # for gsettings program
#    # gnome-menus
#    # gtk3.out # for gtk-launch program
 #   # xdg-user-dirs # Update user dirs as described in https://freedesktop.org/wiki/Software/xdg-user-dirs/
#    # xdg-user-dirs-gtk # Used to create the default bookmarks
#    #
#    baobab
#    epiphany
#    gnome-text-editor
#    gnome-calculator
#    gnome-calendar
#    gnome-characters
#    # gnome-clocks
#    gnome-console
#    gnome-contacts
#    gnome-font-viewer
#    gnome-logs
#    gnome-maps
#    gnome-music
#    # gnome-system-monitor
#    gnome-weather
#    # loupe
#    # nautilus
#    gnome-connections
#    simple-scan
#    snapshot
#    totem
#    yelp
#    gnome-software
#  ];
#  #environment.systemPackages = with pkgs.gnomeExtensions; [
#  #  blur-my-shell
#  #  pop-shell
#    # ...
#  #];
########### Gnome Settings ##########
}

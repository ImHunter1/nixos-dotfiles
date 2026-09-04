# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,lib, niri, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = false;
  ## mounts
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/mnt/windows/w970" =
      { device = "/dev/nvme0n1p2";
        fsType = "ntfs-3g"; 
        options = [ "nofail" "x-systemd.automount" "rw" ];
      };
fileSystems."/mnt/windows/w980" =
    { device = "/dev/nvme1n1p3";
    fsType = "ntfs-3g"; 
    options = [ "nofail" "x-systemd.automount" "rw" ];
    };
  ##niri
  programs.niri.enable = true;
  networking.hostName = "hntr"; 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  #shell 
  users.users.hntr.shell = pkgs.fish;
  programs.fish.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Warsaw";
  #printing 
  services.printing = {
      enable = true;
      drivers = [  
      pkgs.brlaser
      pkgs.brgenml1lpr
      pkgs.brgenml1cupswrapper];
  };
  services.avahi = {
      enable = true;
      nssmdns4 = true;
  };
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };
services.gnome.gnome-keyring.enable = lib.mkForce false;
boot.loader = {
        grub = {
            enable                = true;
            useOSProber           = true;
            copyKernels           = true;
            efiInstallAsRemovable = true;
            efiSupport            = true;
            fsIdentifier          = "label";
            devices               = [ "nodev" ];
            extraEntries = ''
                menuentry "Reboot" {
                    reboot
                }
                menuentry "Poweroff" {
                    halt
                }
            '';
        };
    };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };
 # Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  hardware.nvidia = {
	open = true;
	modesetting.enable = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  services.greetd ={
	enable = true;
	settings = {
		default_session = {
		command = "${config.programs.niri.package}/bin/niri-session";
		user = "hntr";
		};
	};
  };
  systemd.user.services.niri.enableDefaultPath = false;
  # Configure console keymap
  console.keyMap = "pl2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."hntr" = {
    isNormalUser = true;
    description = "Hntr";
    extraGroups = [ "networkmanager" "wheel" "lpadnim"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     kitty
  ];
  fonts.packages = with pkgs ; [
	nerd-fonts.jetbrains-mono
  ];
programs.nix-ld.enable = true;
hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
};
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

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
  system.stateVersion = "26.05"; # Did you read the comment?
  nix.settings.experimental-features = ["nix-command" "flakes"];
}

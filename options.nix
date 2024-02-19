# PLEASE READ THE WIKI FOR DETERMINING
# WHAT TO PUT HERE AS OPTIONS.
# https://gitlab.com/Zaney/fabeanos/-/wikis/Setting-Options

let
  # THINGS YOU NEED TO CHANGE
  username = "josh";
  hostname = "farfetchd";
  userHome = "/home/${username}";
  flakeDir = "${userHome}/Code/fabeanos";
  waybarStyle = "slickbar"; # simplebar, slickbar, or default
in {
  # User Variables
  username = "${username}";
  hostname = "${hostname}";
  gitUsername = "Josh Fabean";
  gitEmail = "me@joshfabean.com";
  theme = "gigavolt";
  slickbar = if waybarStyle == "slickbar" then true else false;
  simplebar = if waybarStyle == "simplebar" then true else false;
  borderAnim = true;
  browser = "firefox";
  # wallpaperGit = "https://gitlab.com/Zaney/my-wallpapers.git"; # This will give you my wallpapers
  # ^ (use as is or replace with your own repo - removing will break the wallsetter script)
  wallpaperDir = "${userHome}/Pictures/Wallpapers";
  screenshotDir = "${userHome}/Pictures/Screenshots";
  flakeDir = "${flakeDir}";
  flakePrev = "${userHome}/.fabeanos-previous";
  flakeBackup = "${userHome}/.fabeanos-backup";
  terminal = "alacritty"; # This sets the terminal that is used by the hyprland terminal keybinding

  # System Settings
  clock24h = true;
  theLocale = "en_US.UTF-8";
  theKBDLayout = "us";
  theSecondKBDLayout = "de";
  theKBDVariant = "";
  theLCVariables = "en_US.UTF-8";
  theTimezone = "America/New_York";
  theShell = "bash"; # Possible options: bash, zsh
  theKernel = "default"; # Possible options: default, latest, lqx, xanmod, zen
  sdl-videodriver = "x11"; # Either x11 or wayland ONLY. Games might require x11 set here
  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "amd";
  gpuType = "amd";

  # Nvidia Hybrid Devices
  # ONLY NEEDED FOR HYBRID
  # SYSTEMS!
  intel-bus-id = "PCI:0:2:0";
  nvidia-bus-id = "PCI:14:0:0";

  # Enable / Setup NFS
  nfs = false;
  nfsMountPoint = "/mnt/nas";
  nfsDevice = "nas:/volume1/nas";

  # NTP & HWClock Settings
  ntp = true;
  localHWClock = false;

  # Enable Printer & Scanner Support
  printer = true;

  # Enable Flatpak & Larger Programs
  flatpak = false;
  kdenlive = true;
  blender = false;

  # Enable Support For
  # Logitech Devices
  logitech = true;

  # Enable Terminals
  # If You Disable All You Get Kitty
  wezterm = false;
  alacritty = true;
  kitty = false;

  # Enable Python & PyCharm
  python = false;

}

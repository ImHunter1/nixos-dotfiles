{config, pkgs, inputs, ...}:


{
	home.username = "hntr";
	home.homeDirectory = "/home/hntr";
	programs.git = {
  		enable = true;

 		 userName = "ImHunter1";
 		 userEmail = "icaldhunter@gmail.com";
		};	
	programs.fastfetch.enable = true;
	programs.noctalia.enable = true;
	programs.brave = {
		enable = true;
		commandLineArgs = ["--password-store=basic"];
	};
	## fish
	programs.starship = {
	  enable = true;
	  enableFishIntegration = true;
	settings = {
	    add_newline = true;

	    format = "$directory$git_branch$git_status$character";

	    directory = {
	      style = "bold cyan";
	      format = "[$path]($style) ";
	    };

	    git_branch = {
	      symbol = " ";
	      style = "bold purple";
	      format = "[$symbol$branch]($style) ";
	    };

	    git_status = {
	      style = "bold yellow";
	      format = "([$all_status$ahead_behind]($style)) ";
	    };

	    character = {
	      success_symbol = "[❯](bold green)";
	      error_symbol = "[❯](bold red)";
	    };
	  };
	};

xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
xdg.configFile."fastfetch/config.jsonc".source = ./fastfetch/config.jsonc;
xdg.configFile."kitty/kitty.conf".source = ./kitty/kitty.conf;
xdg.configFile."noctalia/colors.json".source = ./noctalia/colors.json;
xdg.configFile."noctalia/settings.json".source = ./noctalia/settings.json;
xdg.configFile."noctalia/plugins.json".source = ./noctalia/plugins.json;
xdg.configFile."fish/config.fish".source = ./fish/config.fish;

	home.stateVersion = "26.05";
	home.packages = with pkgs; [
		pwvucontrol
		uv
		gh
		python3
		nil
    go
    dotnet-sdk
		nixpkgs-fmt
		unzip
		eza
		bat
    nautilus
  	fzf 
		ripgrep
		fd
		gcc
		nodejs
		fuzzel
		kitty
		swaybg
		imv
		neovim
		starship
		fish
		swaylock
		spotify
		btop
		cava
		discord
		pipes
		
	];
	imports = [
		inputs.noctalia.homeModules.default
	];
	## home.file.".config/qtile".source = ./config/qtile;
}

{
	description = "My NixOs Flake config";
	
	inputs = {
		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		noctalia = {
			url = "github:noctalia-dev/noctalia";
			inputs.nixpkgs.follows = "nixpkgs";
			};
		
	};
	
	outputs = inputs@{self,nixpkgs,home-manager,noctalia, ... }:
		{
			nixosConfigurations.hntr = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./configuration.nix
					./hardware-configuration.nix 
					home-manager.nixosModules.home-manager
					{
						
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.hntr = import ./home.nix;
						home-manager.backupFileExtension = "backup";
						home-manager.extraSpecialArgs = {
							inherit inputs;
						};
					}
				];
			};
		};
}
		


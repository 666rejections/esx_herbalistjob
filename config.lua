-----------------------------------------
-- Created and modify by Slewog
-----------------------------------------

Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.Locale = 'fr'

Config.Zones = {

	PlantFarm = {
		Pos   = {x = 3554.488, y = 3660.185, z = 27.122},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = _U('plant_farm'),
		Type  = 1
	},


	TraitementPlant = {
		Pos   = {x = 3559.976, y = 3675.390, z = 27.123},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = _U('plant_trait'),
		Type  = 1
	},
	
	SellFarm = {
		Pos   = {x = -227.592, y = -15.358, z = 49.274},
		Size  = {x = 2.5, y = 2.5, z = 1.4},
		Color = {r = 136, g = 243, b = 216},
		Name  = _U('plant_sell'),
		Type  = 1
	},

	HerbalistActions = {
		Pos   = {x = 3561.132, y = 3684.176, z = 27.123},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = _U('herbalist_cloakroom'),
		Type  = 0
	 },
	  
	VehicleSpawner = {
		Pos   = {x = 3618.989, y = 3741.622, z = 27.691},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = _U('vehicle_garage'),
		Type  = 0
	},

	VehicleSpawnPoint = {
		Pos   = {x = 3614.273, y = 3741.593, z = 27.691},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = _U('spawn_point'),
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = {x = 3620.360, y = 3736.363, z = 27.691},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = _U('del_vehicle'),
		Type  = 0
	}

}


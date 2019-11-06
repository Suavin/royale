local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPg = {}
Tunnel.bindInterface("vrp_adv_garages",vRPg)
Proxy.addInterface("vrp_adv_garages",vRPg)

local vehicles = {}
local mods = {}
local toggles = {}
local colors = {}
local wheel = 0

function vRPg.toggleNeon(neon)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		if not toggles[neon] then toggles[neon] = false end
		toggles[neon] = not toggles[neon]
		SetVehicleNeonLightEnabled(veh,neon,toggles[neon])
	end
end

function vRPg.setNeonColour(r,g,b)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		SetVehicleNeonLightsColour(veh,r,g,b)
	end
end

function vRPg.setSmokeColour(r,g,b)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		SetVehicleTyreSmokeColor(veh,r,g,b)
	end
end

function vRPg.scrollVehiclePrimaryColour(pmod)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		if not colors[1] then colors[1] = 0 end
		colors[1] = colors[1]+pmod
		if colors[1] > 160 then colors[1] = 0 end
		if colors[1] < 0 then colors[1] = 160 end
		SetVehicleModKit(veh,0)
		ClearVehicleCustomPrimaryColour(veh)
		SetVehicleColours(veh,colors[1],colors[2])
	end
end

function vRPg.scrollVehicleSecondaryColour(smod)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		if not colors[2] then colors[2] = 0 end
		colors[2] = colors[2]+smod
		if colors[2] > 160 then colors[2] = 0 end
		if colors[2] < 0 then colors[2] = 160 end
		SetVehicleModKit(veh,0)
		ClearVehicleCustomSecondaryColour(veh)
		SetVehicleColours(veh,colors[1],colors[2])
	end
end

function vRPg.setCustomPrimaryColour(r,g,b)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		SetVehicleCustomPrimaryColour(veh,r,g,b)
	end
end

function vRPg.setCustomSecondaryColour(r,g,b)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		SetVehicleCustomSecondaryColour(veh,r,g,b)
	end
end

function vRPg.scrollVehiclePearlescentColour(emod)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		if not colors[3] then colors[3] = 0 end
		SetVehicleModKit(veh,0)
		colors[3] = colors[3]+emod
		if colors[3] > 160 then colors[3] = 0 end
		if colors[3] < 0 then colors[3] = 160 end
		SetVehicleExtraColours(veh,colors[3],colors[4])
	end
end

function vRPg.scrollVehicleWheelColour(wmod)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		if not colors[4] then colors[4] = 0 end
		SetVehicleModKit(veh,0)
		colors[4] = colors[4]+wmod
		if colors[4] > 160 then colors[4] = 0 end
		if colors[4] < 0 then colors[4] = 160 end
		SetVehicleExtraColours(veh,colors[3],colors[4])
	end
end
  
function vRPg.scrollVehicleMods(mod,add)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		local num = GetNumVehicleMods(veh,mod)

		if mod == 35 or mod == 26 then 
			num = GetNumberOfVehicleNumberPlates() 
		elseif mod == 46 then
			num = 6 
		end

		SetVehicleModKit(veh,0)
		if not mods[mod] then mods[mod] = 0 end
		mods[mod] = mods[mod] + add
	  
		if mod > 17 and mod < 23 then
			if toggles[mod] == nil then toggles[mod] = false end
			toggles[mod] = not toggles[mod]
			ToggleVehicleMod(veh,mod,toggles[mod])
			if toggles[mod] then
				TriggerEvent("Notify","sucesso","Aplicada com sucesso.")
			else
				TriggerEvent("Notify","negado","Removida com sucesso.")
			end

		elseif (mod == 23 or mod == 24) and add == 0 then
			wheel = wheel+1
			if wheel > 7 then wheel = 0 end
			SetVehicleWheelType(veh,wheel)
			SetVehicleMod(veh,mod,mods[mod])

		elseif mod == 49 then
			if GetVehicleModVariation(veh,23) == 1 then
				SetVehicleMod(veh,23,mods[23],false)
				SetVehicleMod(veh,24,mods[24],false)
			else
				SetVehicleMod(veh,23,mods[23],true)
				SetVehicleMod(veh,24,mods[24],true)
			end

		elseif num == 0 then
			TriggerEvent("Notify","importante","Nenhuma modificação disponível para este veículo.")
		elseif mods[mod] > num then
			mods[mod] = num
			TriggerEvent("Notify","importante","Atingiu o máximo.")
		elseif mods[mod] < 0 then
			mods[mod] = 0
			TriggerEvent("Notify","importante","Atingiu o mínimo.")
		elseif mod == 35 or mod == 26 then
			SetVehicleNumberPlateTextIndex(veh,mods[mod])
		elseif mod == 46 then
			SetVehicleWindowTint(veh,mods[mod])
		else
			SetVehicleMod(veh,mod,mods[mod],false)
			if mod == 16 and mods[mod] > 3 then
				SetVehicleTyresCanBurst(veh,true)
			elseif mod == 16 then
				SetVehicleTyresCanBurst(veh,false)
			end
		end
	end
end

function vRPg.getVehicleMods()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		local placa,vname,vnet = vRP.ModelName(7)
		if vname then
			local custom = {}
			if DoesEntityExist(veh) then
				local colours = table.pack(GetVehicleColours(veh))
				local extra_colors = table.pack(GetVehicleExtraColours(veh))

				custom.plate = {}
				custom.plate.text = GetVehicleNumberPlateText(veh)
				custom.plate.index = GetVehicleNumberPlateTextIndex(veh)

				custom.colour = {}
				custom.colour.primary = colours[1]
				custom.colour.secondary = colours[2]
				custom.colour.pearlescent = extra_colors[1]
				custom.colour.wheel = extra_colors[2]

				colors[1] = custom.colour.primary
				colors[2] = custom.colour.secondary
				colors[3] = custom.colour.pearlescent
				colors[4] = custom.colour.wheel

				custom.colour.neon = table.pack(GetVehicleNeonLightsColour(veh))
				custom.colour.smoke = table.pack(GetVehicleTyreSmokeColor(veh))

				custom.colour.custom = {}
				custom.colour.custom.primary = table.pack(GetVehicleCustomPrimaryColour(veh))
				custom.colour.custom.secondary = table.pack(GetVehicleCustomSecondaryColour(veh))

				custom.mods = {}
				for i=0,49 do
					custom.mods[i] = GetVehicleMod(veh, i)
				end

				custom.mods[46] = GetVehicleWindowTint(veh)
				custom.mods[18] = IsToggleModOn(veh,18)
				custom.mods[20] = IsToggleModOn(veh,20)
				custom.mods[22] = IsToggleModOn(veh,22)
				custom.turbo = IsToggleModOn(veh,18)
				custom.janela = GetVehicleWindowTint(veh)
				custom.fumaca = IsToggleModOn(veh,20)
				custom.farol = IsToggleModOn(veh,22)
				custom.tyres = GetVehicleMod(veh,23)
				custom.tyresvariation = GetVehicleModVariation(veh,23)

				mods = custom.mods
				toggles[18] = custom.mods[18]
				toggles[20] = custom.mods[20]
				toggles[22] = custom.mods[22]

				custom.neon = {}
				custom.neon.left = IsVehicleNeonLightEnabled(veh,0)
				custom.neon.right = IsVehicleNeonLightEnabled(veh,1)
				custom.neon.front = IsVehicleNeonLightEnabled(veh,2)
				custom.neon.back = IsVehicleNeonLightEnabled(veh,3)

				custom.bulletproof = GetVehicleTyresCanBurst(veh)
				custom.wheel = GetVehicleWheelType(veh)
				wheel = custom.wheel
				return vname,custom
			end
		end
	end
	return false,false
end

function vRPg.setVehicleMods(custom,veh)
	if not veh then
		veh = GetVehiclePedIsUsing(PlayerPedId())
	end
	if custom and veh then
		SetVehicleModKit(veh,0)
		if custom.colour then
			SetVehicleColours(veh,tonumber(custom.colour.primary),tonumber(custom.colour.secondary))
			SetVehicleExtraColours(veh,tonumber(custom.colour.pearlescent),tonumber(custom.colour.wheel))
			if custom.colour.neon then
				SetVehicleNeonLightsColour(veh,tonumber(custom.colour.neon[1]),tonumber(custom.colour.neon[2]),tonumber(custom.colour.neon[3]))
			end
			if custom.colour.smoke then
				SetVehicleTyreSmokeColor(veh,tonumber(custom.colour.smoke[1]),tonumber(custom.colour.smoke[2]),tonumber(custom.colour.smoke[3]))
			end
			if custom.colour.custom then
				if custom.colour.custom.primary then
					SetVehicleCustomPrimaryColour(veh,tonumber(custom.colour.custom.primary[1]),tonumber(custom.colour.custom.primary[2]),tonumber(custom.colour.custom.primary[3]))
				end
				if custom.colour.custom.secondary then
					SetVehicleCustomSecondaryColour(veh,tonumber(custom.colour.custom.secondary[1]),tonumber(custom.colour.custom.secondary[2]),tonumber(custom.colour.custom.secondary[3]))
				end
			end
		end

		if custom.plate then
			SetVehicleNumberPlateTextIndex(veh,tonumber(custom.plate.index))
		end

		SetVehicleWindowTint(veh,tonumber(custom.janela))
		SetVehicleTyresCanBurst(veh,tonumber(custom.bulletproof))
		SetVehicleWheelType(veh,tonumber(custom.wheel))

		ToggleVehicleMod(veh,18,tonumber(custom.turbo))
		ToggleVehicleMod(veh,20,tonumber(custom.fumaca))
		ToggleVehicleMod(veh,22,tonumber(custom.farol))

		if custom.neon then
			SetVehicleNeonLightEnabled(veh,0,tonumber(custom.neon.left))
			SetVehicleNeonLightEnabled(veh,1,tonumber(custom.neon.right))
			SetVehicleNeonLightEnabled(veh,2,tonumber(custom.neon.front))
			SetVehicleNeonLightEnabled(veh,3,tonumber(custom.neon.back))
		end

		for i,mod in pairs(custom.mods) do
			if i ~= 18 and i ~= 20 and i ~= 22 and i ~= 46 then
				SetVehicleMod(veh,tonumber(i),tonumber(mod))
			end
		end
		SetVehicleMod(veh,23,tonumber(custom.tyres),custom.tyresvariation)
		SetVehicleMod(veh,24,tonumber(custom.tyres),custom.tyresvariation)
	end
end

local spawnLocs = {
	[1] = {
		[1] = { ['x'] = 50.66, ['y'] = -873.02, ['z'] = 30.45, ['h'] = 159.65 },
		[2] = { ['x'] = 47.34, ['y'] = -871.81, ['z'] = 30.45, ['h'] = 159.65 },
		[3] = { ['x'] = 44.17, ['y'] = -870.50, ['z'] = 30.45, ['h'] = 159.65 }
	},
	[2] = {
		[1] = { ['x'] = 334.52, ['y'] = 2623.09, ['z'] = 44.49, ['h'] = 20.0 }
	},
	[3] = {
		[1] = { ['x'] = -772.82, ['y'] = 5578.48, ['z'] = 33.48, ['h'] = 89.01 }
	},
	[4] = {
		[1] = { ['x'] = 285.05, ['y'] = -339.29, ['z'] = 44.91, ['h'] = 249.0 }
	},
	[5] = {
		[1] = { ['x'] = 608.21, ['y'] = 104.11, ['z'] = 92.81, ['h'] = 70.0 }
	},
	[6] = {
		[1] = { ['x'] = -328.80, ['y'] = 277.92, ['z'] = 86.34, ['h'] = 95.0 }
	},
	[7] = {
		[1] = { ['x'] = -2024.27, ['y'] = -471.93, ['z'] = 11.40, ['h'] = 140.0 }
	},
	[8] = {
		[1] = { ['x'] = -1186.70, ['y'] = -1490.54, ['z'] = 4.37, ['h'] = 125.0 }
	},
	[9] = {
		[1] = { ['x'] = -84.96, ['y'] = -2004.22, ['z'] = 18.01, ['h'] = 352.0 }
	},
	[10] = {
		[1] = { ['x'] = 227.62, ['y'] = -789.23, ['z'] = 30.68, ['h'] = 247.0 }
	},
	[11] = {
		[1] = { ['x'] = -334.58, ['y'] = -891.73, ['z'] = 31.07, ['h'] = 345.0 }
	},
	[12] = {
		[1] = { ['x'] = 57.63, ['y'] = 18.25, ['z'] = 69.29, ['h'] = 339.38 }
	},
	[13] = {
		[1] = { ['x'] = 371.18, ['y'] = 284.78, ['z'] = 103.25, ['h'] = 338.86 }
	},
	[14] = {
		[1] = { ['x'] = 445.88, ['y'] = -1025.84, ['z'] = 28.65, ['h'] = 7.7 },
		[2] = { ['x'] = 442.20, ['y'] = -1026.32, ['z'] = 28.72, ['h'] = 7.7 },
		[3] = { ['x'] = 438.42, ['y'] = -1026.84, ['z'] = 28.79, ['h'] = 7.7 },
		[4] = { ['x'] = 434.70, ['y'] = -1027.33, ['z'] = 28.85, ['h'] = 7.7 },
		[5] = { ['x'] = 431.09, ['y'] = -1027.44, ['z'] = 28.92, ['h'] = 7.7 },
		[6] = { ['x'] = 427.40, ['y'] = -1027.77, ['z'] = 28.98, ['h'] = 7.7 }
	},
	[15] = {
		[1] = { ['x'] = 1873.68, ['y'] = 3686.05, ['z'] = 33.58, ['h'] = 210.0 }
	},
	[16] = {
		[1] = { ['x'] = -463.50, ['y'] = 6009.80, ['z'] = 31.34, ['h'] = 90.0 }
	},
	[17] = {
		[1] = { ['x'] = 316.7, ['y'] = -550.59, ['z'] = 28.74, ['h'] = 274.77 },
		[2] = { ['x'] = 316.99, ['y'] = -544.78, ['z'] = 28.74, ['h'] = 270.88 }
	},
	[18] = {
		[1] = { ['x'] = 1805.27, ['y'] = 3680.97, ['z'] = 34.22, ['h'] = 120.0 }
	},
	[19] = {
		[1] = { ['x'] = -259.22, ['y'] = 6344.43, ['z'] = 32.42, ['h'] = 90.0 }
	},
	[20] = {
		[1] = { ['x'] = -371.38, ['y'] = -107.87, ['z'] = 38.68, ['h'] = 255.63 }
	},
	[21] = {
		[1] = { ['x'] = 899.16, ['y'] = -180.51, ['z'] = 73.82, ['h'] = 238.56 },
		[2] = { ['x'] = 897.33, ['y'] = -183.60, ['z'] = 73.76, ['h'] = 238.56 }
	},
	[22] = {
		[1] = { ['x'] = 72.89, ['y'] = 121.01, ['z'] = 79.18, ['h'] = 160.0 }
	},
	[23] = {
		[1] = { ['x'] = -342.17, ['y'] = -1560.10, ['z'] = 25.23, ['h'] = 100.0 }
	},
	[24] = {
		[1] = { ['x'] = 462.22, ['y'] = -605.06, ['z'] = 28.49, ['h'] = 220.0 }
	},
	[25] = {
		[1] = { ['x'] = -1189.17, ['y'] = -1571.31, ['z'] = 4.32, ['h'] = 125.0 }
	},
	[26] = {
		[1] = { ['x'] = -897.22, ['y'] = -778.68, ['z'] = 15.91, ['h'] = 80.0 }
	},
	[27] = {
		[1] = { ['x'] = -247.68, ['y'] = -1527.71, ['z'] = 31.59, ['h'] = 230.0 }
	},
	[28] = {
		[1] = { ['x'] = -1619.61, ['y'] = -1175.78, ['z'] = -0.08, ['h'] = 130.0 }
	},
	[29] = {
		[1] = { ['x'] = -1526.63, ['y'] = 1499.64, ['z'] = 109.08, ['h'] = 350.0 }
	},
	[30] = {
		[1] = { ['x'] = 1343.24, ['y'] = 4269.59, ['z'] = 30.11, ['h'] = 190.0 }
	},
	[31] = {
		[1] = { ['x'] = -195.95, ['y'] = 788.35, ['z'] = 195.93, ['h'] = 230.0 }
	},
	[32] = {
		[1] = { ['x'] = -795.85, ['y'] = 303.96, ['z'] = 85.70, ['h'] = 179.0 }
	},
	[33] = {
		[1] = { ['x'] = 149.66, ['y'] = -585.29, ['z'] = 43.98, ['h'] = 67.0 }
	},
	[34] = {
		[1] = { ['x'] = -1299.24, ['y'] = -405.64, ['z'] = 35.91, ['h'] = 297.0 }
	},
	[35] = {
		[1] = { ['x'] = -1417.43, ['y'] = -523.60, ['z'] = 31.90, ['h'] = 213.0 }
	},
	[36] = {
		[1] = { ['x'] = -922.50, ['y'] = -408.35, ['z'] = 37.56, ['h'] = 115.0 }
	},
	[37] = {
		[1] = { ['x'] = -331.29, ['y'] = 216.83, ['z'] = 87.54, ['h'] = 358.0 }
	},
	[38] = {
		[1] = { ['x'] = 1406.73, ['y'] = 1118.89, ['z'] = 114.83, ['h'] = 87.0 }
	},
	[39] = {
		[1] = { ['x'] = -1155.71, ['y'] = -1549.34, ['z'] = 4.27, ['h'] = 301.0 }
	},
	[40] = {
		[1] = { ['x'] = -820.07, ['y'] = 184.30, ['z'] = 72.13, ['h'] = 130.0 }
	},
	[41] = {
		[1] = { ['x'] = -189.37, ['y'] = 505.09, ['z'] = 134.50, ['h'] = 290.0 }
	},
	[42] = {
		[1] = { ['x'] = 355.79, ['y'] = 438.24, ['z'] = 146.00, ['h'] = 290.0 }
	},
	[43] = {
		[1] = { ['x'] = 391.29, ['y'] = 434.54, ['z'] = 143.24, ['h'] = 260.0 }
	},
	[44] = {
		[1] = { ['x'] = -687.15, ['y'] = 605.04, ['z'] = 143.71, ['h'] = 320.0 }
	},
	[45] = {
		[1] = { ['x'] = -749.56, ['y'] = 628.13, ['z'] = 142.45, ['h'] = 190.0 }
	},
	[46] = {
		[1] = { ['x'] = -862.28, ['y'] = 704.71, ['z'] = 149.12, ['h'] = 270.0 }
	},
	[47] = {
		[1] = { ['x'] = 131.06, ['y'] = 571.19, ['z'] = 183.43, ['h'] = 270.0 }
	},
	[48] = {
		[1] = { ['x'] = -1323.20, ['y'] = 450.40, ['z'] = 99.72, ['h'] = 1.0 }
	},
	[49] = {
		[1] = { ['x'] = -1507.75, ['y'] = 429.52, ['z'] = 111.07, ['h'] = 50.0 }
	},
	[50] = {
		[1] = { ['x'] = -1412.13, ['y'] = 538.28, ['z'] = 122.53, ['h'] = 100.0 }
	},
	[51] = {
		[1] = { ['x'] = -1356.17, ['y'] = 605.95, ['z'] = 134.02, ['h'] = 10.0 }
	},
	[52] = {
		[1] = { ['x'] = -969.55, ['y'] = 766.17, ['z'] = 175.20, ['h'] = 40.0 }
	},
	[53] = {
		[1] = { ['x'] = -442.65, ['y'] = 677.18, ['z'] = 152.24, ['h'] = 120.0 }
	},
	[54] = {
		[1] = { ['x'] = 1295.45, ['y'] = -567.97, ['z'] = 71.23, ['h'] = 350.0 }
	},
	[55] = {
		[1] = { ['x'] = 1318.95, ['y'] = -575.41, ['z'] = 72.98, ['h'] = 340.0 }
	},
	[56] = {
		[1] = { ['x'] = 1351.63, ['y'] = -595.03, ['z'] = 74.33, ['h'] = 320.0 }
	},
	[57] = {
		[1] = { ['x'] = 1360.12, ['y'] = -600.839, ['z'] = 74.33, ['h'] = 360.0 }
	},
	[58] = {
		[1] = { ['x'] = 1377.72, ['y'] = -596.03, ['z'] = 74.33, ['h'] = 50.0 }
	},
	[59] = {
		[1] = { ['x'] = 1387.43, ['y'] = -577.91, ['z'] = 74.33, ['h'] = 110.0 }
	},
	[60] = {
		[1] = { ['x'] = 1363.47, ['y'] = -552.22, ['z'] = 74.33, ['h'] = 160.0 }
	},
	[61] = {
		[1] = { ['x'] = 1353.13, ['y'] = -554.18, ['z'] = 74.10, ['h'] = 160.0 }
	},
	[62] = {
		[1] = { ['x'] = 1317.99, ['y'] = -534.88, ['z'] = 72.05, ['h'] = 160.0 }
	},
	[63] = {
		[1] = { ['x'] = 1308.05, ['y'] = -535.15, ['z'] = 71.29, ['h'] = 160.0 }
	},
	[64] = {
		[1] = { ['x'] = -24.14, ['y'] = -1438.26, ['z'] = 30.65, ['h'] = 180.0 }
	},
	[65] = {
		[1] = { ['x'] = 13.31, ['y'] = 547.29, ['z'] = 176.03, ['h'] = 92.0 }
	},
	[66] = {
		[1] = { ['x'] = 1185.20, ['y'] = -3251.40, ['z'] = 6.02, ['h'] = 91.07 }
	},
	[67] = {
		[1] = { ['x'] = 449.34, ['y'] = -981.14, ['z'] = 43.69, ['h'] = 91.28 }
	},
	[68] = {
		[1] = { ['x'] = 351.66, ['y'] = -588.13, ['z'] = 74.16, ['h'] = 247.48 }
	},
	[69] = {
		[1] = { ['x'] = 477.87, ['y'] = -1021.89, ['z'] = 28.02, ['h'] = 272.65 }
	},
	[70] = {
		[1] = { ['x'] = -16.34, ['y'] = -1081.19, ['z'] = 26.54, ['h'] = 125.35 }
	},
	[71] = {
		[1] = { ['x'] = -1027.53, ['y'] = -2726.81, ['z'] = 13.66, ['h'] = 159.65 }
	},
	[72] = {
		[1] = { ['x'] = 87.55, ['y'] = -1968.5, ['z'] = 20.75, ['h'] = 317.74 }
	},
	[73] = {
		[1] = { ['x'] = -219.43, ['y'] = -1692.75, ['z'] = 33.92, ['h'] = 178.4 }
	},
	[74] = {
		[1] = { ['x'] = -201.35, ['y'] = -1296.96, ['z'] = 31.3, ['h'] = 274.0 }
	},
	[75] = {
		[1] = { ['x'] = 857.43, ['y'] = -2119.26, ['z'] = 30.67, ['h'] = 272.17 }
	},
	[76] = {
		[1] = { ['x'] = -2669.21, ['y'] = 1309.55, ['z'] = 147.12, ['h'] = 269.41 }
	},
	[77] = {
		[1] = { ['x'] = -452.29, ['y'] = 5998.33, ['z'] = 31.21, ['h'] = 85.38 },
		[2] = { ['x'] = -448.73, ['y'] = 5994.45, ['z'] = 31.21, ['h'] = 88.18 },
		[3] = { ['x'] = -455.58, ['y'] = 6001.89, ['z'] = 31.21, ['h'] = 88.31 }
	},
	[78] = {
		[1] = { ['x'] = -475.58, ['y'] = 5987.89, ['z'] = 33.4, ['h'] = 316.17 }
	},
	[79] = {
	    [1] = { ['x'] = 1753.80, ['y'] = 3324.98, ['z'] = 41.22, ['h'] = 110.1 }
	},
	[80] = {
	    [1] = { ['x'] = -536.94, ['y'] = -905.36, ['z'] = 23.86, ['h'] = 56.96 }
	},
	[81] = {
	    [1] = { ['x'] = -582.85, ['y'] = -930.64, ['z'] = 36.83, ['h'] = 88.84 }
	},
	[82] = {
	    [1] = { ['x'] = -963.84, ['y'] = -1484.51, ['z'] = 5.01, ['h'] = 112.43 },
	    [2] = { ['x'] = -965.01, ['y'] = -1481.16, ['z'] = 5.02, ['h'] = 110.62 }
	},
	[83] = {
	    [1] = { ['x'] = 331.82, ['y'] = -2044.53, ['z'] = 20.81, ['h'] = 323.19 }
	},
	[84] = {
	    [1] = { ['x'] = -724.47, ['y'] = -1443.87, ['z'] = 5.00, ['h'] = 140.43 }
	},
	[85] = {
	    [1] = { ['x'] = 3864.09, ['y'] = 4472.92, ['z'] = 0.83, ['h'] = 283.47 }
	},
	[86] = {
	    [1] = { ['x'] = 1743.85, ['y'] = 3280.95, ['z'] = 41.09, ['h'] = 283.47 }
	},
	[87] = {
	    [1] = { ['x'] = -22.62, ['y'] = 6443.19, ['z'] = 31.42, ['h'] = 38.81 }
	},
	[88] = {
	    [1] = { ['x'] = -230.96, ['y'] = 6249.1293, ['z'] = 31.48, ['h'] = 176.43 }
	}
}

function vRPg.spawnGarageVehicle(name,custom,enginehealth,bodyhealth,fuellevel,loc)
	local vehicle = vehicles[name]
	if vehicle == nil then
		local mhash = GetHashKey(name)
		while not HasModelLoaded(mhash) do
			RequestModel(mhash)
			Citizen.Wait(10)
		end

		if HasModelLoaded(mhash) then
			rand = 1
			while true do
				checkPos = GetClosestVehicle(spawnLocs[loc][rand].x,spawnLocs[loc][rand].y,spawnLocs[loc][rand].z,3.001,0,71)
				if DoesEntityExist(checkPos) and checkPos ~= nil then
					rand = rand + 1
					if rand > #spawnLocs[loc] then
						rand = -1
						TriggerEvent("Notify","importante","Todas as vagas estão ocupadas no momento.")
						break
					end
				else
					break
				end
				Citizen.Wait(1)
			end

			if rand ~= -1 then
				nveh = CreateVehicle(mhash,spawnLocs[loc][rand].x,spawnLocs[loc][rand].y,spawnLocs[loc][rand].z+0.5,spawnLocs[loc][rand].h,true,false)
				netveh = VehToNet(nveh)

				NetworkRegisterEntityAsNetworked(nveh)
				while not NetworkGetEntityIsNetworked(nveh) do
					NetworkRegisterEntityAsNetworked(nveh)
					Citizen.Wait(1)
				end

				if NetworkDoesNetworkIdExist(netveh) then
					SetEntitySomething(nveh,true)
					if NetworkGetEntityIsNetworked(nveh) then
						SetNetworkIdExistsOnAllMachines(netveh,true)
					end
				end

				NetworkFadeInEntity(NetToEnt(netveh),true)
				SetVehicleIsStolen(NetToVeh(netveh),false)
				SetVehicleNeedsToBeHotwired(NetToVeh(netveh),false)
				SetEntityInvincible(NetToVeh(netveh),false)
				SetVehicleNumberPlateText(NetToVeh(netveh),vRP.getRegistrationNumber())
				SetEntityAsMissionEntity(NetToVeh(netveh),true,true)
				SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh),true)

				SetVehRadioStation(NetToVeh(netveh),"OFF")

				if custom then
					vRPg.setVehicleMods(custom,NetToVeh(netveh))
				end

				SetVehicleEngineHealth(NetToVeh(netveh),enginehealth+0.0)
				SetVehicleBodyHealth(NetToVeh(netveh),bodyhealth+0.0)
				SetVehicleFuelLevel(NetToVeh(netveh),fuellevel+0.0)

				SetModelAsNoLongerNeeded(mhash)

				vehicles[name] = { name,nveh }
			end

			return true,VehToNet(nveh),name
		end
	end
	return false,0,nil
end

function vRPg.despawnGarageVehicle(name)
	local vehicle = vehicles[name]
	if vehicle then
		vehicles[name] = nil
	end
end

function vRPg.toggleLock()
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		local locked = GetVehicleDoorLockStatus(vehicle) >= 2
		if locked then
			TriggerServerEvent("tryLock",VehToNet(vehicle))
			TriggerEvent("Notify","importante","Veículo <b>destrancado</b> com sucesso.")
		else
			TriggerServerEvent("tryLock",VehToNet(vehicle))
			TriggerEvent("Notify","importante","Veículo foi <b>trancado</b> com sucesso.")
		end
		if not IsPedInAnyVehicle(PlayerPedId()) then
			vRP._playAnim(true,{{"anim@mp_player_intmenu@key_fob@","fob_click"}},false)
		end
	end
end

function vRPg.toggleTrunk()
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trytrunk",VehToNet(vehicle))
	end
end

carChestOpen = false
RegisterNetEvent("vrp:inventario:chestOpen")
AddEventHandler("vrp:inventario:chestOpen",function()
	carChestOpen = true
end)

RegisterNetEvent("vrp:inventario:chestclose")
AddEventHandler("vrp:inventario:chestclose",function()
	if carChestOpen then 
		vRPg.toggleTrunk()
		carChestOpen = false
	end
end)

local ancorado = false
function vRPg.toggleAnchor()
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) and GetVehicleClass(vehicle) == 14 then
		if ancorado then
			FreezeEntityPosition(vehicle,false)
			ancorado = false
		else
			FreezeEntityPosition(vehicle,true)
			ancorado = true
		end
	end
end

local cooldown = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if cooldown > 0 then
			cooldown = cooldown - 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,182) and cooldown < 1 then
			cooldown = 1
			TriggerServerEvent("buttonLock")
		end
		if IsControlJustPressed(0,10) and cooldown < 1 then
			cooldown = 1
			TriggerServerEvent("buttonTrunk")
		end
	end
end)

RegisterNetEvent("syncLock")
AddEventHandler("syncLock",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				local locked = GetVehicleDoorLockStatus(v)
				if locked == 1 then
					SetVehicleDoorsLocked(v,2)
				else
					SetVehicleDoorsLocked(v,1)
				end
				SetVehicleLights(v,2)
				Wait(200)
				SetVehicleLights(v,0)
				Wait(200)
				SetVehicleLights(v,2)
				Wait(200)
				SetVehicleLights(v,0)
			end
		end
	end
end)
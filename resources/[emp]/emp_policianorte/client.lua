local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_policianorte")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = -439.82
local CoordenadaY = 5992.07
local CoordenadaZ = 31.71
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -422.39, ['y'] = 5955.38, ['z'] = 31.44 },
	[2] = { ['x'] = -785.86, ['y'] = 5430.91, ['z'] = 35.49 },
	[3] = { ['x'] = -740.41, ['y'] = 5319.53, ['z'] = 72.98 },
	[4] = { ['x'] = -720.08, ['y'] = 5169.38, ['z'] = 111.48 },
	[5] = { ['x'] = -120.28, ['y'] = 4604.32, ['z'] = 123.55 },
	[6] = { ['x'] = 174.60, ['y'] = 4423.66, ['z'] = 74.42 },
	[7] = { ['x'] = 834.01, ['y'] = 4231.96, ['z'] = 51.58 },
	[8] = { ['x'] = 1314.06, ['y'] = 4328.81, ['z'] = 37.90 },
	[9] = { ['x'] = 1910.78, ['y'] = 4609.57, ['z'] = 37.76 },
	[10] = { ['x'] = 2019.17, ['y'] = 4821.46, ['z'] = 41.14 },
	[11] = { ['x'] = 2396.41, ['y'] = 5141.89, ['z'] = 47.09},
	[12] = { ['x'] = 2603.38, ['y'] = 5298.46, ['z'] = 44.32 },
	[13] = { ['x'] = 1705.32, ['y'] = 6419.59, ['z'] = 32.30 },
	[14] = { ['x'] = 1421.44, ['y'] = 6591.32, ['z'] = 12.59 },
	[15] = { ['x'] = 486.69, ['y'] = 6582.60, ['z'] = 26.55 },
	[16] = { ['x'] = 108.35, ['y'] = 6959.95, ['z'] = 12.66 },
	[17] = { ['x'] = -64.40, ['y'] = 6685.54, ['z'] = 12.75 },
	[18] = { ['x'] = 179.13, ['y'] = 6577.88, ['z'] = 31.51 },
	[19] = { ['x'] = -89.96, ['y'] = 6592.15, ['z'] = 28.87 },
	[20] = { ['x'] = -130.36, ['y'] = 6434.46, ['z'] = 31.11 },
	[21] = { ['x'] = -114.59, ['y'] = 6295.45, ['z'] = 31.09 },
	[22] = { ['x'] = -366.75, ['y'] = 6016.68, ['z'] = 30.96 },
	[23] = { ['x'] = -1421.70, ['y'] = 5088.48, ['z'] = 60.55 },
	[24] = { ['x'] = -2204.21, ['y'] = 4258.42, ['z'] = 47.36 },
	[25] = { ['x'] = -3022.10, ['y'] = 3334.01, ['z'] = 9.85 },
	[26] = { ['x'] = -2018.46, ['y'] = 2709.62, ['z'] = 2.89 },
	[27] = { ['x'] = -357.06, ['y'] = 2954.84, ['z'] = 25.07 },
	[28] = { ['x'] = 1199.95, ['y'] = 2671.96, ['z'] = 37.41 },
	[29] = { ['x'] = 2044.97, ['y'] = 3707.75, ['z'] = 32.76 },
	[30] = { ['x'] = 1859.44, ['y'] = 3950.76, ['z'] = 32.72 },
	[31] = { ['x'] = 76.35, ['y'] = 3591.87, ['z'] = 39.42 },
	[32] = { ['x'] = -499.81, ['y'] = 4932.39, ['z'] = 146.94 },
	[33] = { ['x'] = -424.35, ['y'] = 5925.94, ['z'] = 32.04 },
	[34] = { ['x'] = -387.74, ['y'] = 6143.32, ['z'] = 31.10 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(23,CoordenadaX,CoordenadaY,CoordenadaZ-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
				if distance <= 1.5 then
					if IsControlJustPressed(0,38) and emP.checkPermission() then
						servico = true
						selecionado = 1
						CriandoBlip(locs,selecionado)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.30,0,0,0,0,180.0,130.0,2.0,2.0,1.0,240,200,80,20,1,0,0,1)
				if distance <= 2.5 then
					if IsControlJustPressed(0,38) and emP.checkPermission() then
						if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiacharger2018norte")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiasilverado")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiabmwr1200")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiatahoenorte")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiataurusnorte")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiavictorianorte")) then
							RemoveBlip(blips)
							if selecionado == 52 then
								selecionado = 1
							else
								selecionado = selecionado + 1
							end
							emP.checkPayment()
							CriandoBlip(locs,selecionado)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rota de Patrulha")
	EndTextCommandSetBlipName(blips)
end
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_trafico")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local Teleport = {
	["TRAFICO01"] = {
		positionFrom = { ['x'] = -3033.40, ['y'] = 3333.93, ['z'] = 10.27, ['perm'] = "entrada.permissao" },
		positionTo = { ['x'] = 894.49, ['y'] = -3245.88, ['z'] = -98.25, ['perm'] = "entrada.permissao" }
	}
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(Teleport) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.positionFrom.x,v.positionFrom.y,v.positionFrom.z)
			local distance = GetDistanceBetweenCoords(v.positionFrom.x,v.positionFrom.y,cdz,x,y,z,true)
			local bowz,cdz2 = GetGroundZFor_3dCoord(v.positionTo.x,v.positionTo.y,v.positionTo.z)
			local distance2 = GetDistanceBetweenCoords(v.positionTo.x,v.positionTo.y,cdz2,x,y,z,true)

			if distance <= 10 then
				DrawMarker(1,v.positionFrom.x,v.positionFrom.y,v.positionFrom.z-1,0,0,0,0,0,0,1.0,1.0,1.0,255,255,255,50,0,0,0,0)
				if distance <= 1.5 then
					if IsControlJustPressed(0,38) and func.checkPermission(v.positionTo.perm) then
						SetEntityCoords(PlayerPedId(),v.positionTo.x,v.positionTo.y,v.positionTo.z-0.50)
					end
				end
			end

			if distance2 <= 10 then
				DrawMarker(1,v.positionTo.x,v.positionTo.y,v.positionTo.z-1,0,0,0,0,0,0,1.0,1.0,1.0,255,255,255,50,0,0,0,0)
				if distance2 <= 1.5 then
					if IsControlJustPressed(0,38) and func.checkPermission(v.positionFrom.perm) then
						SetEntityCoords(PlayerPedId(),v.positionFrom.x,v.positionFrom.y,v.positionFrom.z-0.50)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = 114.38, ['y'] = 6355.56, ['z'] = 32.31, ['text'] = "Reagentes", ['perm'] = "maconha.permissao" }, -- maconha
	{ ['id'] = 2, ['x'] = 102.92, ['y'] = 6353.97, ['z'] = 31.37, ['text'] = "Preparo", ['perm'] = "maconha.permissao" }, -- maconha
	{ ['id'] = 3, ['x'] = 113.43, ['y'] = 6360.16, ['z'] = 33.19, ['text'] = "Maconha", ['perm'] = "maconha.permissao" }, -- maconha
	
	{ ['id'] = 4, ['x'] = 1505.47, ['y'] = 6391.93, ['z'] = 20.783, ['text'] = "Reagentes", ['perm'] = "meta.permissao" }, -- coca
	{ ['id'] = 5, ['x'] = 1493.10, ['y'] = 6390.25, ['z'] = 21.25, ['text'] = "Preparo", ['perm'] = "meta.permissao" }, -- coca
	{ ['id'] = 6, ['x'] = 1494.74, ['y'] = 6395.36, ['z'] = 20.78, ['text'] = "Cocaina", ['perm'] = "meta.permissao" }, -- coca
	
	{ ['id'] = 7, ['x'] = 2197.85, ['y'] = 5603.68, ['z'] = 53.48, ['text'] = "Reagentes", ['perm'] = "coca.permissao" }, -- meta
	{ ['id'] = 8, ['x'] = 2195.67, ['y'] = 5594.35, ['z'] = 53.76, ['text'] = "Preparo", ['perm'] = "coca.permissao" }, -- meta
	{ ['id'] = 9, ['x'] = 2191.78, ['y'] = 5598.44, ['z'] = 53.71, ['text'] = "Metanfetamina", ['perm'] = "coca.permissao" }, -- meta

	{ ['id'] = 10, ['x'] = 889.54, ['y'] = -2099.56, ['z'] = 35.59, ['text'] = "CAPSULA", ['perm'] = "motoclub.permissao" }, -- motoclub
	{ ['id'] = 11, ['x'] = 90.39, ['y'] = 3745.67, ['z'] = 40.77, ['text'] = "POLVORA", ['perm'] = "motoclub.permissao" }, -- motoclub
	{ ['id'] = 12, ['x'] = 91.0, ['y'] = 3752.22, ['z'] = 40.77, ['text'] = "MUNIÇÃO", ['perm'] = "motoclub.permissao" }, -- motoclub

	{ ['id'] = 13, ['x'] = 1391.62, ['y'] = 3606.42, ['z'] = 38.94, ['text'] = "CARBONO", ['perm'] = "mafia.permissao" }, -- mafia
	{ ['id'] = 14, ['x'] = -2679.02, ['y'] = 1327.99, ['z'] = 144.26, ['text'] = "FERRO", ['perm'] = "mafia.permissao" }, -- mafia
	{ ['id'] = 15, ['x'] = -2678.55, ['y'] = 1330.31, ['z'] = 140.88, ['text'] = "AÇO", ['perm'] = "mafia.permissao" } -- mafia
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.2 and not processo then
				drawTxt("PRESSIONE  ~b~E~w~  PARA PRODUZIR "..v.text,4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and func.checkPermission(v.perm) then
					if func.checkPayment(v.id) then
						processo = true
						TriggerEvent('cancelando',true)
						TriggerEvent("progress",10000,"produzindo")
						SetTimeout(10000,function()
							processo = false
							TriggerEvent('cancelando',false)
						end)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
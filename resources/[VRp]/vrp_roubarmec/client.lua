local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_roubarmec")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local tipo = 0
local segundos = 0
local coordenadaX = -343.77
local coordenadaY = -122.21
local coordenadaZ = 39.00
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1 , ['x'] = -344.95 , ['y'] = -129.68 , ['z'] = 39.00 , ['h'] = 74.78 },
	{ ['id'] = 2 , ['x'] = -345.55 , ['y'] = -131.52 , ['z'] = 39.00 , ['h'] = 72.11 },
	{ ['id'] = 3 , ['x'] = -339.34 , ['y'] = -131.97 , ['z'] = 39.01 , ['h'] = 38.7 },
	{ ['id'] = 4 , ['x'] = -323.53 , ['y'] = -129.45 , ['z'] = 39.01 , ['h'] = 345.61 },
	{ ['id'] = 5 , ['x'] = -345.19 , ['y'] = -124.57 , ['z'] = 39.01 , ['h'] = 69.15 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR O SISTEMA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local bowz,cdz = GetGroundZFor_3dCoord(coordenadaX,coordenadaY,coordenadaZ)
		local distance = GetDistanceBetweenCoords(coordenadaX,coordenadaY,cdz,x,y,z,true)
		if distance <= 1.1 and not andamento then
			drawTxt("PRESSIONE  ~b~F~w~  PARA DESLIGAR AS CAMERAS DE SEGURANÇA",4,0.5,0.93,0.50,255,255,255,180)
			if IsControlJustPressed(0,75) and not IsPedInAnyVehicle(ped) then
				func.checkJewelry(coordenadaX,coordenadaY,coordenadaZ,71.53,30,1)
			end
		end

		if andamento and tipo == 1 then
			drawTxt("FALTAM ~g~"..segundos.." SEGUNDOS ~w~PARA TERMINAR DE DELIGAS AS CÂMERAS DE SEGURANÇA",4,0.5,0.93,0.50,255,255,255,180)
		elseif andamento and tipo == 2 then
			drawTxt("FALTAM ~g~"..segundos.." SEGUNDOS ~w~PARA TERMINAR DE ROUBAR O BALCÃO",4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBANDO AS JOIAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for _,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.1 and not andamento then
				drawTxt("PRESSIONE  ~b~F~w~  PARA ROUBAR O BALCÃO",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,75) and not IsPedInAnyVehicle(ped) then
					if func.returnJewelry() then
						func.checkJewels(v.id,v.x,v.y,v.z,v.h,2)
					else
						TriggerEvent("Notify","negado","Desligue as câmeras de segurança.")
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO O ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandojewelry")
AddEventHandler("iniciandojewelry",function(x,y,z,h,sec,mod,status)
	andamento = status
	if status then
		tipo = mod
		segundos = sec
		ClearPedTasks(PlayerPedId())
		SetEntityHeading(PlayerPedId(),h)
		SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
		SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
		TriggerEvent('cancelando',true)
	else
		TriggerEvent('cancelando',false)
		ClearPedTasks(PlayerPedId())
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				tipo = 0
				andamento = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando',false)
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
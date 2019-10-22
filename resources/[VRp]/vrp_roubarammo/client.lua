local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_roubarammo")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local tipo = 0
local segundos = 0
local coordenadaX = 11.5
local coordenadaY = -1108.84
local coordenadaZ = 29.8
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1 , ['x'] = 20.75 , ['y'] = -1104.36 , ['z'] = 29.8 , ['h'] = 337.76 },
	{ ['id'] = 2 , ['x'] = 22.7 , ['y'] = -1104.83 , ['z'] = 29.8 , ['h'] = 348.57 },
	{ ['id'] = 3 , ['x'] = 20.28 , ['y'] = -1106.11 , ['z'] = 29.8 , ['h'] = 334.26 },
	{ ['id'] = 4 , ['x'] = 22.18 , ['y'] = -1106.85 , ['z'] = 29.8 , ['h'] = 338.13 },
	{ ['id'] = 5 , ['x'] = 22.55 , ['y'] = -1109.76 , ['z'] = 29.8 , ['h'] = 287.87 },
	{ ['id'] = 6 , ['x'] = 17.63 , ['y'] = -1111.99 , ['z'] = 29.8 , ['h'] = 66.32 },
	{ ['id'] = 7 , ['x'] = 22.62 , ['y'] = -1107.62 , ['z'] = 29.8 , ['h'] = 249.85 },
	{ ['id'] = 8 , ['x'] = 18.53 , ['y'] = -1109.8 , ['z'] = 29.8 , ['h'] = 78.09 },
	{ ['id'] = 9 , ['x'] = 20.98 , ['y'] = -1110.38 , ['z'] = 29.8 , ['h'] = 67.74 },
	{ ['id'] = 10 , ['x'] = 19.56 , ['y'] = -1109.97 , ['z'] = 29.8 , ['h'] = 252.16 }
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
			drawTxt("PRESSIONE  ~b~F~w~  PARA HACKEAR AS CÂMERAS DE SEGURANÇA",4,0.5,0.93,0.50,255,255,255,180)
			if IsControlJustPressed(0,75) and not IsPedInAnyVehicle(ped) then
				func.checkJewelry(coordenadaX,coordenadaY,coordenadaZ,71.53,30,1)
			end
		end

		if andamento and tipo == 1 then
			drawTxt("FALTAM ~g~"..segundos.." SEGUNDOS ~w~PARA TERMINAR DE HACKEAR AS CÂMERAS DE SEGURANÇA",4,0.5,0.93,0.50,255,255,255,180)
		elseif andamento and tipo == 2 then
			drawTxt("FALTAM ~g~"..segundos.." SEGUNDOS ~w~PARA TERMINAR DE ROUBAR AS BALCÃO",4,0.5,0.93,0.50,255,255,255,180)
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
				drawTxt("PRESSIONE  ~b~F~w~  PARA ROUBAR AS BALCÃO",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,75) and not IsPedInAnyVehicle(ped) then
					if func.returnJewelry() then
						func.checkJewels(v.id,v.x,v.y,v.z,v.h,2)
					else
						TriggerEvent("Notify","negado","Hackeie as câmeras de segurança.")
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
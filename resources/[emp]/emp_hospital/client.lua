local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_hospital")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local macas = {
	{ ['x'] = 353.35, ['y'] = -561.94, ['z'] = 28.79, ['x2'] = 354.46, ['y2'] = -562.03, ['z2'] = 29.72, ['h'] = 340.95 },
	{ ['x'] = 356.75, ['y'] = -563.15, ['z'] = 28.79, ['x2'] = 357.82, ['y2'] = -563.21, ['z2'] = 29.72, ['h'] = 337.11 },
	{ ['x'] = 360.15, ['y'] = -564.23, ['z'] = 28.79, ['x2'] = 361.15, ['y2'] = -564.51, ['z2'] = 29.72, ['h'] = 330.0 },
	{ ['x'] = 357.82, ['y'] = -570.74, ['z'] = 28.79, ['x2'] = 358.5, ['y2'] = -571.34, ['z2'] = 29.72, ['h'] = 150.0 },
	{ ['x'] = 354.45, ['y'] = -569.63, ['z'] = 29.79, ['x2'] = 355.21, ['y2'] = -570.03, ['z2'] = 29.72, ['h'] = 150.0 },
	{ ['x'] = 351.01, ['y'] = -568.34, ['z'] = 28.79, ['x2'] = 351.89, ['y2'] = -568.59, ['z2'] = 29.72, ['h'] = 150.0 },
	{ ['x'] = 366.13, ['y'] = -569.02, ['z'] = 28.79, ['x2'] = 366.52, ['y2'] = -568.27, ['z2'] = 29.5, ['h'] = 245.3 },
	{ ['x'] = 365.34, ['y'] = -571.05, ['z'] = 28.79, ['x2'] = 364.9, ['y2'] = -572.07, ['z2'] = 29.5, ['h'] = 251.42 },
	{ ['x'] = 347.26, ['y'] = -575.2, ['z'] = 28.79, ['x2'] = 346.88, ['y2'] = -575.97, ['z2'] = 29.5, ['h'] = 65.61 },
	{ ['x'] = 348.51, ['y'] = -572.17, ['z'] = 28.79, ['x2'] = 348.62, ['y2'] = -571.06, ['z2'] = 29.5, ['h'] = 69.01 },
	{ ['x'] = 355.22, ['y'] = -574.24, ['z'] = 28.79, ['x2'] = 355.53, ['y2'] = -573.38, ['z2'] = 29.78, ['h'] = 63.23 },
	{ ['x'] = 342.01, ['y'] = -574.95, ['z'] = 28.79, ['x2'] = 341.15, ['y2'] = -574.66, ['z2'] = 29.84, ['h'] = 159.68 },
	{ ['x'] = 337.41, ['y'] = -575.06, ['z'] = 28.79, ['x2'] = 336.57, ['y2'] = -574.76, ['z2'] = 29.78, ['h'] = 157.54 },
	{ ['x'] = 330.98, ['y'] = -572.87, ['z'] = 28.79, ['x2'] = 330.01, ['y2'] = -572.7, ['z2'] = 29.78, ['h'] = 157.55 },
	{ ['x'] = 327.13, ['y'] = -563.81, ['z'] = 28.79, ['x2'] = 327.43, ['y2'] = -563.07, ['z2'] = 29.76, ['h'] = 251.89 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEITANDO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(macas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.1 then
				drawTxt("~b~E~w~  DEITAR    ~b~G~w~  TRATAMENTO",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) then
					SetEntityCoords(ped,v.x2,v.y2,v.z2)
					SetEntityHeading(ped,v.h)
					vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
				end
				if IsControlJustPressed(0,47) then
					if emP.checkServices() then
						TriggerEvent('tratamento-macas')
						SetEntityCoords(ped,v.x2,v.y2,v.z2)
						SetEntityHeading(ped,v.h)
						vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
					else
						TriggerEvent("Notify","aviso","Existem paramédicos em serviço.")
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

RegisterNetEvent('tratamento-macas')
AddEventHandler('tratamento-macas',function()
	TriggerEvent("cancelando",true)
	repeat
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())+1)
		Citizen.Wait(2000)
	until GetEntityHealth(PlayerPedId()) >= 400 or GetEntityHealth(PlayerPedId()) <= 100
		TriggerEvent("Notify","importante","Tratamento concluido.")
		TriggerEvent("cancelando",false)
end)
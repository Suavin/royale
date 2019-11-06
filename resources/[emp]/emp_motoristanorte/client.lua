local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_motoristanorte")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local emservico = false
local CoordenadaX = -246.63
local CoordenadaY = 6239.82
local CoordenadaZ = 31.48
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DE ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
local entregas = {
	[1] = { x=-406.11,y=6134.95,z=31.90 },
	[2] = { x=-261.90,y=6104.26,z=31.78 },
	[3] = { x=62.53,y=6430.08,z=31.86 },
	[4] = { x=1446.17,y=6543.55,z=16.0 },
	[5] = { x=538.13,y=6558.91,z=28.16 },
	[6] = { x=180.28,y=6586.28,z=32.40 },
	[7] = { x=-35.88,y=6619.75,z=30.86 },
	[8] = { x=-129.18,y=6433.29,z=32.0 },
	[9] = { x=-293.03,y=6244.82,z=31.98 },
	[10] = { x=-790.95,y=5560.85,z=32.96 },
	[11] = { x=-367.35,y=6000.52,z=31.92 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not emservico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(23,CoordenadaX,CoordenadaY,CoordenadaZ-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR ROTA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						emservico = true
						destino = 1
						CriandoBlip(entregas,destino)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if emservico then
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			if distance <= 50 then
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z-0.70,0,0,0,0,180.0,130.0,2.0,2.0,1.0,211,176,72,100,1,0,0,1)
				if distance <= 2.5 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA CONTINUAR A ROTA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("coach")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("bus")) then
							RemoveBlip(blip)
							if destino == 11 then
								emP.checkPayment(600)
								destino = 1
							else
								emP.checkPayment(0)
								destino = destino + 1
							end
							CriandoBlip(entregas,destino)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if emservico then
			if IsControlJustPressed(0,168) then
				emservico = false
				RemoveBlip(blip)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCOES
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

function CriandoBlip(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,1)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rota de Motorista")
	EndTextCommandSetBlipName(blip)
end
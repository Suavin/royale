local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_taxistanorte")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = nil
local selecionado = 0
local emservico = false
local CoordenadaX = -33.23
local CoordenadaY = 6455.43
local CoordenadaZ = 31.47
local passageiro = nil
local lastpassageiro = nil
local checkped = true
local timers = 0
local payment = 120
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -399.92, ['y'] = 6034.96, ['z'] = 30.99, ['xp'] = -396.98, ['yp'] = 6040.57, ['zp'] = 31.56, ['h'] = 43.19 },
	[2] = { ['x'] = -127.96, ['y'] = 6442.59, ['z'] = 31.03, ['xp'] = -125.14, ['yp'] = 6448.10, ['zp'] = 31.54, ['h'] = 46.12 },
	[3] = { ['x'] = 156.91, ['y'] = 6589.68, ['z'] = 31.45, ['xp'] = 159.51, ['yp'] = 6591.24, ['zp'] = 32.09, ['h'] = 0.92 },
	[4] = { ['x'] = -695.37, ['y'] = 5830.61, ['z'] = 16.67, ['xp'] = -679.59, ['yp'] = 5834.03, ['zp'] = 17.33, ['h'] = 339.41 },
	[6] = { ['x'] = -520.16, ['y'] = 6277.15, ['z'] = 9.45, ['xp'] =  -491.70, ['yp'] = 6267.02, ['zp'] = 12.37, ['h'] = 352.24 }, 
	[7] = { ['x'] = 423.85, ['y'] = 6556.53, ['z'] = 26.80, ['xp'] = 413.60, ['yp'] = 6540.03, ['zp'] = 27.73, ['h'] = 264.92 },
	[8] = { ['x'] = 1447.80, ['y'] = 6541.82, ['z'] = 15.17, ['xp'] = 1467.59, ['yp'] = 6541.41, ['zp'] = 14.00, ['h'] = 346.72 },
	[9] = { ['x'] = -28.12, ['y'] = 6268.35, ['z'] = 30.81, ['xp'] = -21.33, ['yp'] = 6255.76, ['zp'] = 31.22, ['h'] = 346.72 },
	[10] = { ['x'] = -2213.37, ['y'] = 4286.06, ['z'] = 47.29, ['xp'] = -2205.83, ['yp'] = 4281.66, ['zp'] = 48.49, ['h'] = 330.42 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local pedlist = {
	[1] = { ['model'] = "ig_abigail", ['hash'] = 0x400AEC41 },
	[2] = { ['model'] = "a_m_o_acult_02", ['hash'] = 0x4BA14CCA },
	[3] = { ['model'] = "a_m_m_afriamer_01", ['hash'] = 0xD172497E },
	[4] = { ['model'] = "ig_mp_agent14", ['hash'] = 0xFBF98469 },
	[5] = { ['model'] = "u_m_m_aldinapoli", ['hash'] = 0xF0EC56E2 },
	[6] = { ['model'] = "ig_amandatownley", ['hash'] = 0x6D1E15F7 },
	[7] = { ['model'] = "ig_andreas", ['hash'] = 0x47E4EEA0 },
	[8] = { ['model'] = "csb_anita", ['hash'] = 0x0703F106 },
	[9] = { ['model'] = "u_m_y_antonb", ['hash'] = 0xCF623A2C },
	[10] = { ['model'] = "g_m_y_armgoon_02", ['hash'] = 0xC54E878A },
	[11] = { ['model'] = "ig_ashley", ['hash'] = 0x7EF440DB },
	[12] = { ['model'] = "s_m_m_autoshop_01", ['hash'] = 0x040EABE3 },
	[13] = { ['model'] = "g_m_y_ballaeast_01", ['hash'] = 0xF42EE883 },
	[14] = { ['model'] = "g_m_y_ballaorig_01", ['hash'] = 0x231AF63F },
	[15] = { ['model'] = "s_m_y_barman_01", ['hash'] = 0xE5A11106 },
	[16] = { ['model'] = "u_m_y_baygor", ['hash'] = 0x5244247D },
	[17] = { ['model'] = "a_m_o_beach_01", ['hash'] = 0x8427D398 },
	[18] = { ['model'] = "a_m_y_beachvesp_01", ['hash'] = 0x7E0961B8 },
	[19] = { ['model'] = "ig_bestmen", ['hash'] = 0x5746CD96 },
	[20] = { ['model'] = "a_f_y_bevhills_01", ['hash'] = 0x445AC854 },
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
					drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR EXPEDIENTE",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						emservico = true
						selecionado = math.random(#locs)
						CriandoBlip(locs,selecionado)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSAGEIRO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if emservico then
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsUsing(ped)
			local vehiclespeed = GetEntitySpeed(vehicle)*2.236936
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 50.0 and IsVehicleModel(vehicle,GetHashKey("taxi")) then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,240,200,80,20,1,0,0,1)
				if distance <= 2.5 then
					if IsControlJustPressed(0,38) and (GetEntityHeading(ped) >= locs[selecionado].h-20.0 and GetEntityHeading(ped) <= locs[selecionado].h+20.0) then
						RemoveBlip(blips)
						FreezeEntityPosition(vehicle,true)
						if DoesEntityExist(passageiro) then
							emP.checkPayment(payment)
							Citizen.Wait(3000)
							TaskLeaveVehicle(passageiro,vehicle,262144)
							TaskWanderStandard(passageiro,10.0,10)
							Citizen.Wait(1100)
							SetVehicleDoorShut(vehicle,3,0)
							Citizen.Wait(1000)
						end

						if checkped then
							local pmodel = math.random(#pedlist)
							modelRequest(pedlist[pmodel].model)

							passageiro = CreatePed(4,pedlist[pmodel].hash,locs[selecionado].xp,locs[selecionado].yp,locs[selecionado].zp,3374176,true,false)
							TaskEnterVehicle(passageiro,vehicle,-1,2,1.0,1,0)
							SetEntityInvincible(passageiro,true)
							checkped = false
							payment = 10
							lastpassageiro = passageiro
						else
							passageiro = nil
							checkped = true
							FreezeEntityPosition(vehicle,false)
						end

						lselecionado = selecionado
						while true do
							if lselecionado == selecionado then
								selecionado = math.random(#locs)
							else
								break
							end
							Citizen.Wait(1)
						end

						CriandoBlip(locs,selecionado)

						if DoesEntityExist(passageiro) then
							while true do
								Citizen.Wait(1)
								local x2,y2,z2 = table.unpack(GetEntityCoords(passageiro))
								if not IsPedSittingInVehicle(passageiro,vehicle) then
									DrawMarker(21,x2,y2,z2+1.3,0,0,0,0,180.0,130.0,0.6,0.8,0.5,240,200,80,50,1,0,0,1)
								end
								if IsPedSittingInVehicle(passageiro,vehicle) then
									FreezeEntityPosition(vehicle,false)
									break
								end
							end
						end
					end
				end
			end

			if IsEntityAVehicle(vehicle) and DoesEntityExist(passageiro) then
				if math.ceil(vehiclespeed) >= 81 and timers <= 0 and payment > 0 then
					timers = 5
					payment = payment - 1
				end
			end

		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if emservico then
			if timers > 0 then
				timers = timers - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVENPCS
-----------------------------------------------------------------------------------------------------------------------------------------
function removePeds()
	SetTimeout(20000,function()
		if emservico and lastpassageiro and passageiro == nil then
			TriggerServerEvent("trydeleteped",PedToNet(lastpassageiro))
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if emservico then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			if IsControlJustPressed(0,168) and IsVehicleModel(vehicle,GetHashKey("taxi")) then
				RemoveBlip(blips)
				if DoesEntityExist(passageiro) then
					TaskLeaveVehicle(passageiro,vehicle,262144)
					TaskWanderStandard(passageiro,10.0,10)
					Citizen.Wait(1100)
					SetVehicleDoorShut(vehicle,3,0)
					FreezeEntityPosition(vehicle,false)
				end
				blips = nil
				selecionado = 0
				passageiro = nil
				checkped = true
				emservico = false
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

function modelRequest(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(10)
	end
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Corrida de Taxista")
	EndTextCommandSetBlipName(blips)
end
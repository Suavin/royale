local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
RadarL = Tunnel.getInterface("vrp_radar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADAR
-----------------------------------------------------------------------------------------------------------------------------------------
local radares = {
	{ ['x'] = 99.618675231934, ['y'] = -987.81591796875, ['z'] = 28.847682952881 },
	{ ['x'] = 108.99136352539, ['y'] = -1009.2567138672, ['z'] = 28.858154296875 },
	{ ['x'] = 209.95983886719, ['y'] = -1046.2504882813, ['z'] = 28.776020050049 },
	{ ['x'] = 233.87019348145, ['y'] = -1036.7698974609, ['z'] = 28.843101501465 },
	{ ['x'] = 268.73165893555, ['y'] = -588.84252929688, ['z'] = 42.678482055664 },
	{ ['x'] = 253.16981506348, ['y'] = -581.13720703125, ['z'] = 42.789604187012 },
	{ ['x'] = -125.1385345459, ['y'] = -1721.6420898438, ['z'] = 29.563177108765 },
	{ ['x'] = -121.78657531738, ['y'] = -1744.5430908203, ['z'] = 29.702537536621 },
	{ ['x'] = -390.36486816406, ['y'] = 126.48040008545, ['z'] = 65.114898681641 },
	{ ['x'] = -2631.7548828125, ['y'] = 1206.5466308594, ['z'] = 153.94071960449 }
}

local tempo = false
local tempo2 = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for _,v in pairs(radares) do
		    local ped = PlayerPedId()
		    local vehicle = GetVehiclePedIsIn(ped)
		    local distance = GetDistanceBetweenCoords(v.x,v.y,v.z,GetEntityCoords(ped),true)
		    local speed = GetEntitySpeed(vehicle)*3.605936
		    if distance <= 8.0 then	
		        if IsEntityAVehicle(vehicle) then
			        if GetPedInVehicleSeat(vehicle,-1) then
				        if speed >= 81 and not tempo then
					        vRP.setDiv("radar",".div_radar { background: #fff; margin: 0; width: 100%; height: 100%; opacity: 0.9; }","")
					        PlaySoundFrontend( -1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1 )
		                    SetTimeout(200,function()
			                    vRP.removeDiv("radar")
			                    tempo = true
		                    end)
		                    SetTimeout(1150,function()
					        	tempo = false
					        end)
				        end
				        if speed >= 81 and speed < 150 and not RadarL.checarOrgs() then
				        	RadarL.checarMulta(646)
				        	if not tempo2 then
				        		TriggerEvent("Notify","aviso","<b>Radar:</b> Limite de velocidade permitido é <b>80KM/H</b>, voce estava a <b>"..math.ceil(speed).."KM/H</b>, recebeu uma multa de <b>$646</b>!")
				        		vRP._notify()
				        		tempo2 = true
				        		SetTimeout(1000,function()
					        	    tempo2 = false
					            end)
					        end
				        elseif speed >= 100 and speed < 200 and not RadarL.checarOrgs() then
				        	RadarL.checarMulta(1332)
				        	if not tempo2 then
				        		TriggerEvent("Notify","aviso","<b>Radar:</b> Limite de velocidade permitido é <b>80KM/H</b>, voce estava a <b>"..math.ceil(speed).."KM/H</b>, recebeu uma multa de <b>$1332</b>!")
				        		tempo2 = true
				        		SetTimeout(1000,function()
					        	    tempo2 = false
					            end)
					        end
				        elseif speed >= 150 and speed < 250 and not RadarL.checarOrgs() then
                            RadarL.checarMulta(1756)
                            if not tempo2 then
				        		TriggerEvent("Notify","aviso","<b>Radar:</b> Limite de velocidade permitido é <b>80KM/H</b>, voce estava a <b>"..math.ceil(speed).."KM/H</b>, recebeu uma multa de <b>$1756</b>!")
				        		tempo2 = true
				        		SetTimeout(1000,function()
					        	    tempo2 = false
					            end)
					        end
                        elseif speed >= 250 and not RadarL.checarOrgs() then
                        	RadarL.checarMulta(3557)
                        	if not tempo2 then
				        		TriggerEvent("Notify","aviso","<b>Radar:</b> Limite de velocidade permitido é <b>80KM/H</b>, voce estava a <b>"..math.ceil(speed).."KM/H</b>, recebeu uma multa de <b>$3557</b>!")
				        		tempo2 = true
				        		SetTimeout(1000,function()
					        	    tempo2 = false
					            end)
					        end
                        end
				    end
				end
			end
		end
	end
end)
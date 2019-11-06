-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "atum" then
		TriggerServerEvent("pescador-vender","atum")
	elseif data == "espada" then
		TriggerServerEvent("pescador-vender","espada")
	elseif data == "xareu" then
		TriggerServerEvent("pescador-vender","xareu")
	elseif data == "tubarao" then
		TriggerServerEvent("pescador-vender","tubarao")
	elseif data == "bicuda" then
		TriggerServerEvent("pescador-vender","bicuda")
	elseif data == "marlim" then
		TriggerServerEvent("pescador-vender","marlim")
	elseif data == "tainha" then
		TriggerServerEvent("pescador-vender","tainha")
	elseif data == "pampo" then
		TriggerServerEvent("pescador-vender","pampo")
	elseif data == "nero" then
		TriggerServerEvent("pescador-vender","nero")


	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),3807.86,4478.55,6.36,true)
		if distance <= 30 then
			DrawMarker(23,3807.86,4478.55,6.36-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
	end
end)
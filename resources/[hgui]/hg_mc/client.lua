local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("hg_mc")
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
	if data == "armamentos-comprar-hkp7m10" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_SNSPISTOL")
	elseif data == "armamentos-comprar-uzi" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_MICROSMG")
	elseif data == "armamentos-comprar-mtar21" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_ASSAULTSMG")
	elseif data == "armamentos-comprar-ak103" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_ASSAULTRIFLE")
	elseif data == "armamentos-comprar-magnum44" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_REVOLVER")
	elseif data == "armamentos-comprar-thompson" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_GUSENBERG")

	elseif data == "armamentos-vender-hkp7m10" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_SNSPISTOL")
	elseif data == "armamentos-vender-uzi" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_MICROSMG")
	elseif data == "armamentos-vender-mtar21" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_ASSAULTSMG")
	elseif data == "armamentos-vender-ak103" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_ASSAULTRIFLE")
	elseif data == "armamentos-vender-magnum44" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_REVOLVER")
	elseif data == "armamentos-vender-thompson" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_GUSENBERG")


	elseif data == "municoes-comprar-hkp7m10" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_SNSPISTOL")
	elseif data == "municoes-comprar-uzi" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_MICROSMG")
	elseif data == "municoes-comprar-ak103" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_ASSAULTRIFLE")
	elseif data == "municoes-comprar-magnum44" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_PISTOL_MK2")
	elseif data == "municoes-comprar-thompson" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_GUSENBERG")

	elseif data == "municoes-vender-hkp7m10" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_SNSPISTOL")
	elseif data == "municoes-vender-uzi" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_MICROSMG")
	elseif data == "municoes-vender-ak103" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_ASSAULTRIFLE")
	elseif data == "municoes-vender-magnum44" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_REVOLVER")
	elseif data == "municoes-vender-thompson" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_GUSENBERG")

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
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),885.98,-2109.16,30.76,true)
		if distance <= 30 then
			DrawMarker(23,-2679.05,1334.64,140.88-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
			if distance <= 1.1 then
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end
		end
	end
end)
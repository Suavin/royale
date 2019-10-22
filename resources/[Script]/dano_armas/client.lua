
----------------------------------------------------------------------------
--DANO ARMAS (E SOCO) MELEE ///// MELEE AND WEAPONS DAMAGE 
----------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.8) 
    	Wait(0)
    	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN"), 8.5) 
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE"), 0.8) 
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE"), 0.9) 
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"), 2.0) 
    	Wait(0)
    end
end)
----------------------------------------------------------------------------
--DANO CORONHADA //// PISTOL WHIPPING
----------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
	   DisableControlAction(1, 140, true)
       	   DisableControlAction(1, 141, true)
           DisableControlAction(1, 142, true)
        end
    end
end)

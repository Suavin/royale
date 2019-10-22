--[[--------------------------------------------------------------------------
	*
	* Mello Trainer
	* (C) Michael Goodwin 2017
	* http://github.com/thestonedturtle/mellotrainer/releases
	*
	* This menu used the Scorpion Trainer as a framework to build off of.
	* https://github.com/pongo1231/ScorpionTrainer
	* (C) Emre Cürgül 2017
	* 
	* A lot of useful functionality has been converted from the lambda menu.
	* https://lambda.menu
	* (C) Oui 2017
	*
	* Additional Contributors:
	* WolfKnight (https://forum.fivem.net/u/WolfKnight)
	*
---------------------------------------------------------------------------]]



RegisterNUICallback("player", function(data, cb)
	local playerPed = GetPlayerPed(-1)
	local action = data.action
	local newstate = data.newstate

	local text = "~r~OFF"
	if(newstate) then
		text = "~g~ON"
	end


	-- Heal Player
	if action == "heal" then
		SetEntityHealth(playerPed, 200)
		ClearPedBloodDamage(playerPed)
		ClearPedWetness(playerPed)

		if(featureKeepWet)then -- Keep Wet Check.
			SetPedWetnessHeight(playerPed, 2.0)
		end
		drawNotification("[~p~Chicago~w~] ~g~Vida recarregada e limpo.")

	-- Body Armor
	elseif action == "armor" then
		SetPedArmour(playerPed, 100)
		drawNotification("[~p~Chicago~w~] ~g~ Colete adicionado")

	-- Suicide 
	elseif action == "suicide" then
		SetEntityHealth(playerPed, 0)
		drawNotification("[~p~Chicago~w~] ~r~Você se suicidou")

	-- God Mode/Invincibility
	elseif action == "god" then
		featurePlayerInvincible = newstate
		drawNotification("[~p~Chicago~w~] God Mode: "..tostring(text))

		featurePlayerInvincibleUpdated = true;

	-- Infinite Stamina
	elseif action == "stamina" then
		featurePlayerInfiniteStamina = newstate
		drawNotification("[~p~Chicago~w~] Energina ilimitada: "..tostring(text))

	-- Drunk Mode
	elseif action == "drunk" then
		featurePlayerDrunk = newstate
		drawNotification("[~p~Chicago~w~] Modo bêbado "..tostring(text))

		featurePlayerDrunkUpdated = true;


	-- Invsibility Toggle
	elseif action == "invisible" then
		featurePlayerInvisible = newstate
		drawNotification("[~p~Chicago~w~] Invisivel: "..tostring(text))

		featurePlayerInvisibleUpdated = true;


	-- Silent Mode
	elseif action == "silent" then
		featurePlayerNoNoise = newstate
		drawNotification("[~p~Chicago~w~] Silencioso: "..tostring(text))

		featurePlayerNoNoiseUpdated = true;


	-- Everyone Ignores you
	elseif action == "everyone" then
		featurePlayerIgnoredByAll = newstate
		drawNotification("[~p~Chicago~w~] Ignorado por todos:"..tostring(text))

		featurePlayerIgnoredByAllUpdated = true;


	-- Police Ignore You
	elseif action == "police" then
		featurePlayerIgnoredByPolice = newstate
		drawNotification("[~p~Chicago~w~] Policia ignora você: "..tostring(text))

		featurePlayerIgnoredByPoliceUpdated = true;


	-- Never Wanted
	elseif action == "wanted" then
		featurePlayerNeverWanted = newstate
		drawNotification("[~p~Chicago~w~] Nunca procurado: "..tostring(text))

		featurePlayerNeverWantedUpdated = true;

	elseif action == "keepwet" then
		featureKeepWet = newstate
		featureKeepWetUpdated = true;
		drawNotification("[~p~Chicago~w~] Sempre molhado:"..tostring(text))

	elseif action == "fastswim" then
		featurePlayerFastSwim = newstate
		featurePlayerFastSwimUpdated = true;
		drawNotification("[~p~Chicago~w~] Nadar rápido:"..tostring(text))

	elseif action == "fastrun" then
		featurePlayerFastRun = newstate
		featurePlayerFastRunUpdated = true;
		drawNotification("[~p~Chicago~w~] Correr rápido:"..tostring(text))

	elseif action == "superjump" then
		featurePlayerSuperJump = newstate

		drawNotification("[~p~Chicago~w~] Super pulo:"..tostring(text))

	elseif action == "noragdoll" then
		featureNoRagDoll = newstate
		featureNoRagDollUpdated = true
		drawNotification("[~p~Chicago~w~] Nunca cair:"..tostring(text))

	elseif action == "nightvision" then
		featureNightVision = newstate
		featureNightVisionUpdated = true;
		drawNotification("[~p~Chicago~w~] Visão noturna:"..tostring(text))

	elseif action == "thermalvision" then
		featureThermalVision = newstate
		featureThermalVisionUpdated = true;
		drawNotification("[~p~Chicago~w~] Visão de calor:"..tostring(text))

	elseif action == "radiooff" then
		featureRadioAlwaysOff = newstate
		featureRadioAlwaysOffUpdated = true;
		drawNotification("[~p~Chicago~w~] Desativar rádios "..tostring(text))

	elseif action == "keepclean" then
		featureKeepClean = newstate
		drawNotification("[~p~Chicago~w~] Manter Limpo:"..tostring(text))
	elseif action == "restoreappearance"then
		featureRestoreAppearance = newstate
		drawNotification("[~p~Chicago~w~] Restaurar aparencia:"..tostring(text))
	end

	if(cb)then cb("ok") end
end)



Citizen.CreateThread(function()
	while true do
		Wait(1)

		local playerPed = GetPlayerPed(-1)
		local playerID = PlayerId()
		if playerPed then


			-- Keep Wet
			if(featureKeepWet and featureKeepWetUpdated) then
				SetPedWetnessHeight(playerPed, 2.0)
				featureKeepWetUpdated = false;
			end


			-- Silent (NOT WORKING?)
			if(featurePlayerNoNoiseUpdated)then
				if(featurePlayerNoNoise)then
					SetPlayerNoiseMultiplier(playerID, 0.0)
				else
					SetPlayerNoiseMultiplier(playerID, 1.0)
				end
				featurePlayerNoNoiseUpdated = false
			end


			-- Fast Swim
			if(featurePlayerFastSwimUpdated)then
				if(featurePlayerFastSwim)then
					SetSwimMultiplierForPlayer(playerID, 1.49)
				else
					SetSwimMultiplierForPlayer(playerID, 1.0)
				end
				featurePlayerFastSwimUpdated = false
			end


			-- Fast Run
			if(featurePlayerFastRunUpdated)then
				if(featurePlayerFastRun)then
					SetRunSprintMultiplierForPlayer(playerID, 1.49)
				else
					SetRunSprintMultiplierForPlayer(playerID, 1.0)
				end
				featurePlayerFastRunUpdated = false
			end


			-- Super Jump
			if (featurePlayerSuperJump)then
				SetSuperJumpThisFrame(playerID)
			end


			-- No Ragdoll
			if ( featureNoRagDoll ) then 
				SetPedCanRagdoll( playerPed, false )
			else 
				SetPedCanRagdoll( playerPed, true )
			end 


			-- Night Vision
			if(featureNightVisionUpdated)then
				SetNightvision(featureNightVision)

				featureNightVisionUpdated = false
			end


			-- Thermal Vision
			if (featureThermalVisionUpdated)then
				SetSeethrough(featureThermalVision)

				featureThermalVisionUpdated = false
			end


			-- Radio Off
			if (featureRadioAlwaysOffUpdated)then
				if(IsPedInAnyVehicle(playerPed, false))then
					SetVehicleRadioEnabled(GetVehiclePedIsUsing(playerPed), not featureRadioAlwaysOff)
				end
				SetUserRadioControlEnabled(not featureRadioAlwaysOff)
			end


			-- Godmode
			-- if ( featurePlayerInvincible ) then
			-- 	SetEntityInvincible( playerPed, true )
			-- else 
			-- 	SetEntityInvincible( playerPed, true )
			-- end 
			SetEntityInvincible( playerPed, featurePlayerInvincible )


			-- Stamina
			if featurePlayerInfiniteStamina then
				RestorePlayerStamina(playerID, 1.0)
			end


			-- Keep Clean
			if featureKeepClean then
				ClearPedBloodDamage(playerPed)
			end


			-- Drunk
			if ( featurePlayerDrunkUpdated ) then
				SetPedIsDrunk( playerPed, drunk )

				if ( featurePlayerDrunk ) then
					_LoadClipSet( "move_m@drunk@verydrunk" )

					SetPedMovementClipset( playerPed, "move_m@drunk@verydrunk", 1.0 )
					ShakeGameplayCam( "DRUNK_SHAKE", 1.0 )
				else
					ResetPedMovementClipset( playerPed, 1.0 )
					StopGameplayCamShaking( true )
					RemoveClipSet( "move_m@drunk@verydrunk" )
				end

				featurePlayerDrunkUpdated = false;
			end


			-- Invisibility
			if(featurePlayerInvisibleUpdated)then
				if featurePlayerInvisible then
					SetEntityVisible(playerPed, false, 0)
				else
					SetEntityVisible(playerPed, true, 0)
				end
				featurePlayerInvisibleUpdated = false;
			end


			-- Everyone Ignores Me
			SetEveryoneIgnorePlayer(PlayerID, featurePlayerIgnoredByAll)
			if(featurePlayerIgnoredByAll) then
				SuppressShockingEventsNextFrame()
			end


			-- Police Ignore Me & Don't Dispatch
			SetPoliceIgnorePlayer(PlayerID, featurePlayerIgnoredByPolice)
			if(featurePlayerIgnoredByPolice) then
				SetDispatchCopsForPlayer(playerID, false)
			else
				SetDispatchCopsForPlayer(playerID, true)
			end


			-- Never Wanted & clears wanted level.
			if(featurePlayerNeverWanted) then
				if(GetPlayerWantedLevel(PlayerID) > 0) then
					ClearPlayerWantedLevel(PlayerID)
				end
				SetMaxWantedLevel(0)
			else
				SetMaxWantedLevel(5)
			end

		end
	end
end)
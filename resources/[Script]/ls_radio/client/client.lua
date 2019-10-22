local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
azt = Tunnel.getInterface("ls_radio")
vRP = Proxy.getInterface("vRP")
radio = Tunnel.getInterface("ls_radio")

local radioMenu = false

function enableRadio(enable)
	SetNuiFocus(true, true)
	radioMenu = enable
	SendNUIMessage({ type = "enableui", enable = enable})
	TriggerEvent("status:celular",true)
end

RegisterCommand('radio', function(source, args)
	enableRadio(true)  
end, false)

RegisterCommand('off', function(source, data, cb)
    local playerName = GetPlayerName(PlayerId())
	local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel") 
    if tonumber(data.channel) ~= tonumber(getPlayerRadioChannel) then
		exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
		exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(0), true);
	end
end)

PlayerJob = "police"

RegisterNUICallback('joinRadio', function(data, cb)
    local playerName = GetPlayerName(PlayerId())
    local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")
    if tonumber(data.channel) ~= tonumber(getPlayerRadioChannel) then
        if tonumber(data.channel) <= Config.RestrictedChannels then
            if tonumber(data.channel) == 1 and radio.Cargo("Policia") then
                exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                TriggerEvent('Notify', 'importante', 'Você está atualmente no rádio: <b>1.00 MHz </b>')
            elseif tonumber(data.channel) == 2 and radio.Cargo("Paramedico") then
                exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                TriggerEvent('Notify', 'importante', 'Você está atualmente no rádio: <b>2.00 MHz </b>')
			elseif tonumber(data.channel) == 3 and radio.Cargo("Mecanico") then
			    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                TriggerEvent('Notify', 'importante', 'Você está atualmente no rádio: <b>3.00 MHz </b>')
			elseif tonumber(data.channel) == 4 and radio.Cargo("Bennys") then 
			    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                TriggerEvent('Notify', 'importante', 'Você está atualmente no rádio: <b>4.00 MHz </b>')
			elseif tonumber(data.channel) == 5 and radio.Cargo("Roxos") then 
			    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                TriggerEvent('Notify', 'importante', 'Você está atualmente no rádio: <b>5.00 MHz </b>')
			elseif tonumber(data.channel) == 6 and radio.Cargo("Verdes") then 
			    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                TriggerEvent('Notify', 'importante', 'Você está atualmente no rádio: <b>6.00 MHz </b>')
			elseif tonumber(data.channel) == 7 and radio.Cargo("Mafia") then 
			    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                TriggerEvent('Notify', 'importante', 'Você está atualmente no rádio: <b>7.00 MHz </b>')
			elseif tonumber(data.channel) == 8 and radio.Cargo("Motoclub") then 
			    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                TriggerEvent('Notify', 'importante', 'Você está atualmente no rádio: <b>8.00 MHz </b>')
            elseif tonumber(data.channel) == 9 and radio.Cargo("Tequilala") then 
                exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                TriggerEvent('Notify', 'importante', 'Você está atualmente no rádio: <b>9.00 MHz </b>') 
            elseif tonumber(data.channel) == 10 and radio.Cargo("Amarelos") then 
                exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                TriggerEvent('Notify', 'importante', 'Você está atualmente no rádio: <b>10.00 MHz </b>')
            elseif tonumber(data.channel) == 11 and radio.Cargo("Yakuza") then 
                exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
            elseif tonumber(data.channel) == 12 and radio.Cargo("PoliciaNorte") then 
                exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                TriggerEvent('Notify', 'importante', 'Você está atualmente no rádio: <b>12.00 MHz </b>')            
            end
        end
      else
          TriggerEvent('Notify', 'negado', 'Você já está no rádio: <b>'.. data.channel .. '.00 MHz </b>')
      end
    cb('ok')
end)


RegisterNUICallback('leaveRadio', function(data, cb)
   local playerName = GetPlayerName(PlayerId())
   local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")
    if getPlayerRadioChannel == "nil" then
		TriggerEvent('Notify', 'importante', Config.messages['not_on_radio'])
    else
		exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
		exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true)
		TriggerEvent('Notify', 'importante', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
    end
	cb('ok')
end)

RegisterNUICallback('escape', function(data, cb)

    enableRadio(false)
    SetNuiFocus(false, false)
	TriggerEvent("status:celular",false)
    cb('ok')
end)

-- net eventy

RegisterNetEvent('ls_radio:use')
AddEventHandler('ls_radio:use', function()
  enableRadio(true)
end)

RegisterNetEvent('ls_radio:onRadioDrop')
AddEventHandler('ls_radio:onRadioDrop', function(source)
  local playerName = GetPlayerName(source)
  local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")


  if getPlayerRadioChannel ~= "nil" then

    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
    exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true)
    TriggerEvent('Notify', 'importante', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')

end
end)

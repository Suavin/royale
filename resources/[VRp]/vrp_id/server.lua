local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP", "vrp_id")

vRPclient = Tunnel.getInterface("vRP", "vrp_id")

function Chat(text)
	TriggerEvent("chatMessage", 'Jogador Próximo', { 255,255,0}, text)
end

RegisterCommand("idp", function(source)
    local user_id = vRP.getUserId({source})
                local player = vRP.getUserSource({user_id})

                vRPclient.getNearestPlayer(player,{10},function(nplayer)
                local nuser_id = vRP.getUserId({nplayer})

                    if nplayer ~= nil then
                        local name = GetPlayerName(nplayer)
                        TriggerClientEvent("chatMessage", source, "Jogador Próximo", {255, 0, 0}, "ID: "..nuser_id.." Nome: "..name)
                    else
                        vRPclient.notify(player,{"~r~Nenhum jogador perto."})
                    end
                end)
end)
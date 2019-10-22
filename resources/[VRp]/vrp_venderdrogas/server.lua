local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_kekmememememes")

RegisterServerEvent('drogas:items')
AddEventHandler('drogas:items', function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if not vRP.tryGetInventoryItem(user_id,"Maconha",1,notify) then
	if not vRP.tryGetInventoryItem(user_id,"cocaina",1,notify) then
	if not vRP.tryGetInventoryItem(user_id,"metanfetamina",1,notify) then
	TriggerClientEvent('done', player)
	TriggerClientEvent('cancel', player)
	else
	TriggerClientEvent('cancel', player)
	end
	end
	end
end)

RegisterServerEvent('drogas:dinheiro')
AddEventHandler('drogas:dinheiro', function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local reward = math.random(70,250)
	vRP.giveMoney(user_id,reward)
end)

RegisterServerEvent('vRP_drugNPC:policia')
AddEventHandler('vRP_drugNPC:policia', function(x,y,z)
   vRP.sendServiceAlert(nil, "Policia",x,y,z,"Um cara me ofereceu itens ilegais.")
end)


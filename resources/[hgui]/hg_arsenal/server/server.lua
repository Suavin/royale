local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local armas = {
}

RegisterServerEvent('hg_arsenal:permissao')
AddEventHandler('hg_arsenal:permissao', function()
	local src = source
	local user_id = vRP.getUserId(src)
	if vRP.hasGroup(user_id,"Policia") or vRP.hasGroup(user_id,"PoliciaNorte") or vRP.hasGroup(user_id,"ComandoPolicia") then
		TriggerClientEvent('hg_arsenal:permissao', src)
	end
end)

RegisterServerEvent('hg_arsenal:colete')
AddEventHandler('hg_arsenal:colete', function()
	local src = source
	local user_id = vRP.getUserId(src)
	if vRP.hasGroup(user_id,"Policia") or vRP.hasGroup(user_id,"PoliciaNorte") or vRP.hasGroup(user_id,"ComandoPolicia") then
		local colete = 100
		vRPclient.setArmour(src,100)
		vRP.setUData(user_id,"vRP:colete", json.encode(colete))
	end
end)

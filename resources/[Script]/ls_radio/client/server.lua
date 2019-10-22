local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
radio = {}
Tunnel.bindInterface("ls_radio",radio)

function radio.Cargo(grupo)
	local user_id = vRP.getUserId(source)
	return vRP.hasGroup(user_id,grupo) 
end
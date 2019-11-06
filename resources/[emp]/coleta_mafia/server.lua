local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("coleta_mafia",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment(bonus)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveInventoryItem(user_id,"aco",math.random(20,26))
	    vRP.giveInventoryItem(user_id,"dinheirosujo",math.random(830,1292))
	end
end

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"mafia.permissao")
end
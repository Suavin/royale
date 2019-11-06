local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_taxistanorte",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment(payment)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveMoney(user_id,parseInt(math.random(30,55)*payment))
	end
end
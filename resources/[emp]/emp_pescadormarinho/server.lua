local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_pescadormarinho",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local peixes = {
	[1] = { x = "atum" },
	[2] = { x = "espada" },
	[3] = { x = "xareu" },
	[4] = { x = "tubarao" },
	[5] = { x = "bicuda" },
	[6] = { x = "marlim" },
	[7] = { x = "tainha" },
	[8] = { x = "nero" }
}

function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("atum") <= vRP.getInventoryMaxWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id,"camarao",1) then
				if math.random(100) >= 98 then
					vRP.giveInventoryItem(user_id,"pampo",1)
				else
					vRP.giveInventoryItem(user_id,peixes[math.random(8)].x,1)
				end
				return true
			end
		end
	end
end
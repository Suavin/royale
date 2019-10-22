local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = {}
Tunnel.bindInterface("vrp_trafico",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission(perm)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,perm)
end

local src = {
	[1] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "adubo", ['itemqtd'] = 5 },
	[2] = { ['re'] = "adubo", ['reqtd'] = 5, ['item'] = "fertilizante", ['itemqtd'] = 5 },
	[3] = { ['re'] = "fertilizante", ['reqtd'] = 5, ['item'] = "maconha", ['itemqtd'] = 5 },
		
	[4] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "reagentesdecoca", ['itemqtd'] = 5 },
	[5] = { ['re'] = "reagentesdecoca", ['reqtd'] = 5, ['item'] = "preparodecoca", ['itemqtd'] = 5 },
	[6] = { ['re'] = "preparodecoca", ['reqtd'] = 5, ['item'] = "cocaina", ['itemqtd'] = 5 },
	
	[7] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "reagentesdemeta", ['itemqtd'] = 5 },
	[8] = { ['re'] = "reagentesdemeta", ['reqtd'] = 5, ['item'] = "preparodemeta", ['itemqtd'] = 5 },
	[9] = { ['re'] = "preparodemeta", ['reqtd'] = 5, ['item'] = "metanfetamina", ['itemqtd'] = 5 },

	[10] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "capsula", ['itemqtd'] = 90 },
	[11] = { ['re'] = "capsula", ['reqtd'] = 30, ['item'] = "polvora", ['itemqtd'] = 30 },
	[12] = { ['re'] = "polvora", ['reqtd'] = 15, ['item'] = "wammo|WEAPON_ASSAULTSMG", ['itemqtd'] = 15 },

	[13] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "carbono", ['itemqtd'] = 25 },
	[14] = { ['re'] = "carbono", ['reqtd'] = 25, ['item'] = "ferro", ['itemqtd'] = 25 },
	[15] = { ['re'] = "ferro", ['reqtd'] = 50, ['item'] = "aco", ['itemqtd'] = 50 }
}

function func.checkPayment(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if src[id].re ~= nil then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(src[id].item)*src[id].itemqtd <= vRP.getInventoryMaxWeight(user_id) then
				if vRP.tryGetInventoryItem(user_id,src[id].re,src[id].reqtd,false) then
					vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd,false)
					return true
				end
			end
		else
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(src[id].item)*src[id].itemqtd <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd,false)
				return true
			end
		end
	end
end
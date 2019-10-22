local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("hg_mafia",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "wbody|WEAPON_SNSPISTOL", quantidade = 1, compra = 800, venda = 0 },
	{ item = "wbody|WEAPON_PISTOL_MK2", quantidade = 1, compra = 1300, venda = 0 },
	{ item = "wbody|WEAPON_MICROSMG", quantidade = 1, compra = 2300, venda = 0 },
	{ item = "wbody|WEAPON_GUSENBERG", quantidade = 1, compra = 3400, venda = 0 },
	{ item = "wbody|WEAPON_ASSAULTRIFLE", quantidade = 1, compra = 4000, venda = 0 },

	{ item = "wammo|WEAPON_SNSPISTOL", quantidade = 50, compra = 150, venda = 0 },
	{ item = "wammo|WEAPON_MICROSMG", quantidade = 50, compra = 350, venda = 0 },
	{ item = "wammo|WEAPON_GUSENBERG", quantidade = 50, compra = 400, venda = 0 },
	{ item = "wammo|WEAPON_ASSAULTRIFLE", quantidade = 50, compra = 500, venda = 0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("mafia-comprar")
AddEventHandler("mafia-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,"aco",v.compra) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>"..vRP.format(parseInt(v.compra)).." Aços</b>.")
					else
						TriggerClientEvent("Notify",source,"negado","Aço insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("mafia-vender")
AddEventHandler("mafia-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.giveInventoryItem(user_id,"aco",parseInt(v.venda))
					TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>"..vRP.format(parseInt(v.venda)).." aços</b>.")
				else
					TriggerClientEvent("Notify",source,"negado","Não possui <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> em sua mochila.")
				end
			end
		end
	end
end)

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"mafia.permissao")
end
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "algemas", quantidade = 1, compra = 150, venda = 0 },
	{ item = "capuz", quantidade = 1, compra = 120, venda = 0 },
	{ item = "lockpick", quantidade = 1, compra = 40, venda = 0 },
	{ item = "masterpick", quantidade = 1, compra = 200, venda = 0 },
	{ item = "pendrive", quantidade = 1, compra = 70, venda = 0 },
	{ item = "colete", quantidade = 1, compra = 100, venda = 0 },
	{ item = "alicate", quantidade = 1, compra = 10, venda = 0 },
	{ item = "wbody|WEAPON_STICKYBOMB", quantidade = 1, compra = 300, venda = 0 },
	{ item = "wammo|WEAPON_STICKYBOMB", quantidade = 1, compra = 175, venda = 0 },
	{ item = "placa", quantidade = 1, compra = 70, venda = 0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("contrabando-comprar")
AddEventHandler("contrabando-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,"iene",v.compra) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." ienes</b>.")
					else
						TriggerClientEvent("Notify",source,"negado","Ienes insuficiente.")
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
RegisterServerEvent("contrabando-vender")
AddEventHandler("contrabando-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(v.venda))
					TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.venda)).." dólares sujos</b>.")
				else
					TriggerClientEvent("Notify",source,"negado","Não possui <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> em sua mochila.")
				end
			end
		end
	end
end)
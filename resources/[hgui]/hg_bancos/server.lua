local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("hg_bancos",vRPN)
Proxy.addInterface("hg_bancos",vRPN)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAIXA ELETRÔNICO
-----------------------------------------------------------------------------------------------------------------------------------------
local caixas = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(caixas) do
			if v > 0 then
				caixas[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSITAR
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Depositar(valor)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(valor) > 0 then
			if vRP.tryDeposit(user_id,parseInt(valor)) then
				TriggerClientEvent("Notify",source,"sucesso","Depositou <b>$"..vRP.format(parseInt(valor)).." dólares</b> em sua conta bancária.")
			else
				TriggerClientEvent("Notify",source,"negado","Não possui <b>$"..vRP.format(parseInt(valor)).." dólares</b> em sua carteira.")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SACAR
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Sacar(valor)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if valor then
			if parseInt(valor) > 0 then
				if vRP.tryWithdraw(user_id,parseInt(valor)) then
					TriggerClientEvent("Notify",source,"sucesso","Sacou <b>$"..vRP.format(parseInt(valor)).." dólares</b> de sua conta bancária.")
				else
					TriggerClientEvent("Notify",source,"negado","Não possui <b>$"..vRP.format(parseInt(valor)).." dólares</b> em sua conta bancária.")
				end
			end
		else
			if caixas[user_id] == 0 or not caixas[user_id] then
				if vRP.tryWithdraw(user_id,1000) then
					caixas[user_id] = 600
					TriggerClientEvent("Notify",source,"sucesso","Sacou <b>$1.000 dólares</b> de sua conta bancária.")
				else
					TriggerClientEvent("Notify",source,"negado","Não possui <b>$1.000 dólares</b> em sua conta bancária.")
				end
			else
				TriggerClientEvent("Notify",source,"importante","Aguarde <b>"..caixas[user_id].." segundos</b> para efetuar outro saque.")
			end
		end
	end
end
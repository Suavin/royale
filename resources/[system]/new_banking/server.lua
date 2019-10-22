--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","new_banking")

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
	local xPlayer = vRP.getUserId(source)
	if amount == nil or amount <= 0 or amount > vRP.getMoney(xPlayer) then
		TriggerClientEvent('bank:result', source, "error", "Quantidade invalida.")
	else
		vRP.tryDeposit(xPlayer,math.floor(math.abs(amount)))
		TriggerClientEvent('bank:result', source, "success", "Deposito efetuado.")
	end
end)


RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
	local xPlayer = vRP.getUserId(source)
	local base = 0
	amount = tonumber(amount)
	base = vRP.getBankMoney(xPlayer)
	if amount == nil or amount <= 0 or amount > base then
		TriggerClientEvent('bank:result', source, "error", "Quantidade invalida.")
	else
		vRP.tryWithdraw(xPlayer,math.floor(math.abs(amount)))
		TriggerClientEvent('bank:result', source, "success", "Saque efetuado.")
	end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
	local xPlayer = vRP.getUserId(source)
	balance = vRP.getBankMoney(xPlayer)
	TriggerClientEvent('currentbalance1', source, balance)
end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)

	local xPlayer = vRP.getUserId(source)
	local zPlayer = to
	
	-- print(xPlayer)
-- print(zPlayer)
	local balance = 0

	if(zPlayer == nil or zPlayer == -1) then
		TriggerClientEvent('bank:result', source, "error", "Destinatário não encontrado.")
	else
		balance = vRP.getBankMoney(xPlayer)
		zbalance = vRP.getBankMoney(zPlayer)
		
		if tonumber(xPlayer) == tonumber(zPlayer) then
			TriggerClientEvent('bank:result', source, "error", "Você não pode transferir dinheiro para você mesmo.")
		else
			if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent('bank:result', source, "error", "Você não tem dinheiro suficiente no banco.")
			else
				transfer(xPlayer, zPlayer, amountt)
				TriggerClientEvent('bank:result', source, "success", "Transferencia efetuada.")
			end
		end
	end
end)

function transfer (fPlayer, tPlayer, amount)
-- print(fPlayer)
-- print(tPlayer)
  local user_id = vRP.getUserId(fPlayer)
  local user_id2 = vRP.getUserId(tPlayer)

  local bankbalance = vRP.getBankMoney(user_id)
  local bankbalance2 = vRP.getBankMoney(user_id2)
  -- print(bankbalance)
  local new_balance = bankbalance + math.abs(tonumber(amount))
  local new_balance2 = bankbalance2 - math.abs(tonumber(amount))

  

  vRP.setBankMoney(user_id, new_balance)
  vRP.setBankMoney(user_id2, new_balance2)
end






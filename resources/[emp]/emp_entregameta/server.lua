local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("emp_entregameta",emP)
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return not vRP.hasPermission(user_id,"meta.permissao")
end

local quantidade = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(4,6)
	end
end

function emP.checkPayment()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"metanfetamina",quantidade[source]) then
			vRP.giveInventoryItem(user_id,"dinheirosujo",math.random(550,610)*quantidade[source])
			quantidade[source] = nil
			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..quantidade[source].."x Metanfetaminas</b>.")
		end
	end
end

function emP.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if user_id then
		TriggerClientEvent("Notify",source,"aviso","A policia foi acionada.")
		local soldado = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Recebemos uma denuncia do tráfico de drogas, verifique o ocorrido.")
					SetTimeout(15000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
	end
end
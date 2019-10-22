local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
local idgens = Tools.newIDGenerator()
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
burglary = {}
Tunnel.bindInterface("vrp_robhome",burglary)
Proxy.addInterface("vrp_robhome",burglary)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local timers = 0
local roubando = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
function LockPick()
	local src = source
	local user_id = vRP.getUserId(src)
	return vRP.tryGetInventoryItem(user_id,"lockpick",1,false)
end

function burglary.Timer(house)
	local source = source
	local user_id = vRP.getUserId(source)
	if (os.time()-timers) <= 300 and not roubando then
		TriggerClientEvent("Notify",source,"aviso","A <b>Casa</b> não se recuperou do ultimo <b>roubo</b>, aguarde <b>"..vRP.format(parseInt((300-(os.time()-timers)))).." segundos</b> até que o dono compre novas <b>coisas</b>.")
	else
	    if LockPick() then
	        TriggerClientEvent('Burglary:HouseBreak',source,house,segundos)
	        roubando = true
	        timers = os.time()
	    else
            TriggerClientEvent("Notify",source,"aviso","Voce nao tem <b>1x LockPick</b>!")
        end
	end
end

RegisterServerEvent('robhome:getitem')
AddEventHandler('robhome:getitem', function(item, qtty)
	local src = source
	local user_id = vRP.getUserId(src)
	vRP.giveInventoryItem(user_id,item,qtty)
end)

RegisterServerEvent('robhome:tryitem')
AddEventHandler('robhome:tryitem', function(item, qtty)
	local src = source
	local user_id = vRP.getUserId(src)
	vRP.tryGetInventoryItem(user_id,item,qtty,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function burglary.callPoliceBank(x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("policia.permissao")
	for l,w in pairs(policia) do
		local player = vRP.getUserSource(parseInt(w))
		if player then
			async(function()
				local ids = idgens:gen()
				vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo a Residencia",0.6,true)
				TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Recebemos uma denuncia de roubo a residencia, verifique o ocorrido.")
				SetTimeout(60000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timers) do
			if v > 0 then
				timers[k] = v - 1
			end
		end
		if roubando then
			segundos = segundos - 1
			if segundos <= 0 then
				timers = {}
				roubando = false
			end
		end
	end
end)
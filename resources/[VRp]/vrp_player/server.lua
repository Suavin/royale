local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	["ferramenta"] = { index = "ferramenta", nome = "Ferramenta" },
	["encomenda"] = { index = "encomenda", nome = "Encomenda" },
	["sacodelixo"] = { index = "sacodelixo", nome = "Saco de Lixo" },
	["garrafavazia"] = { index = "garrafavazia", nome = "Garrafa Vazia" },
	["garrafadeleite"] = { index = "garrafadeleite", nome = "Garrafa de Leite" },
	["tora"] = { index = "tora", nome = "Tora de Madeira" },
	["roupas"] = { index = "roupas", nome = "Roupas" },
	["alianca"] = { index = "alianca", nome = "Aliança" },
	["bandagem"] = { index = "bandagem", nome = "Bandagem" },
	["cerveja"] = { index = "cerveja", nome = "Cerveja" },
	["tequila"] = { index = "tequila", nome = "Tequila" },
	["vodka"] = { index = "vodka", nome = "Vodka" },
	["whisky"] = { index = "whisky", nome = "Whisky" },
	["conhaque"] = { index = "conhaque", nome = "Conhaque" },
	["absinto"] = { index = "absinto", nome = "Absinto" },
	["dinheirosujo"] = { index = "dinheirosujo", nome = "Dinheiro Sujo" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos" },
	["algemas"] = { index = "algemas", nome = "Algemas" },
	["capuz"] = { index = "capuz", nome = "Capuz" },
	["alicate"] = { index = "alicate", nome = "Alicate" },
	["pills"] = { index = "pills", nome = "Pills" },
	["pack"] = { index = "pack", nome = "Pack de Drogas" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick" },
	["masterpick"] = { index = "masterpick", nome = "Masterpick" },
	["militec"] = { index = "militec", nome = "Militec-1" },
	---------------------------------------------------------------------------
	["carnedecormorao"] = { index = "carnedecormorao", nome = "Carne de Cormorão" },
	["carnedecorvo"] = { index = "carnedecorvo", nome = "Carne de Corvo" },
	["carnedeaguia"] = { index = "carnedeaguia", nome = "Carne de Águia" },
	["carnedecervo"] = { index = "carnedecervo", nome = "Carne de Cervo" },
	["carnedecoelho"] = { index = "carnedecoelho", nome = "Carne de Coelho" },
	["carnedecoyote"] = { index = "carnedecoyote", nome = "Carne de Coyote" },
	["carnedelobo"] = { index = "carnedelobo", nome = "Carne de Lobo" },
	["carnedepuma"] = { index = "carnedepuma", nome = "Carne de Puma" },
	["carnedejavali"] = { index = "carnedejavali", nome = "Carne de Javali" },
	---------------------------------------------------------------------------
	["isca"] = { index = "isca", nome = "Isca" },
	["camarao"] = { index = "camarao", nome = "Camarãozinho" },
	["dourado"] = { index = "dourado", nome = "Dourado" },
	["corvina"] = { index = "corvina", nome = "Corvina" },
	["salmao"] = { index = "salmao", nome = "Salmão" },
	["pacu"] = { index = "pacu", nome = "Pacu" },
	["pintado"] = { index = "pintado", nome = "Pintado" },
	["pirarucu"] = { index = "pirarucu", nome = "Pirarucu" },
	["tilapia"] = { index = "tilapia", nome = "Tilápia" },
	["tucunare"] = { index = "tucunare", nome = "Tucunaré" },
	["lambari"] = { index = "lambari", nome = "Lambari" },
	["atum"] = { index = "atum", nome = "Atum" },
	["espada"] = { index = "espada", nome = "Peixe Espada" },
	["xareu"] = { index = "xareu", nome = "Xareu" },
	["tubarao"] = { index = "tubarao", nome = "Tubarão" },
	["bicuda"] = { index = "bicuda", nome = "Bicuda" },
	["marlim"] = { index = "marlim", nome = "Marlim Azul" },
	["tainha"] = { index = "tainha", nome = "Tainha" },
	["pampo"] = { index = "pampo", nome = "Pampo" },
	["nero"] = { index = "nero", nome = "Peixe Nero" },
	---------------------------------------------------------------------------
	["energetico"] = { index = "energetico", nome = "Energético" },
	["iene"] = { index = "iene", nome = "Ienes" },
	["mochila"] = { index = "mochila", nome = "Mochila" },
	["maconha"] = { index = "maconha", nome = "Maconha" },
	["dryice"] = { index = "dryice", nome = "Dry Ice" },
	["superlemon"] = { index = "superlemon", nome = "Super Lemon" },
	["purplebud"] = { index = "purplebud", nome = "Purple Bud" },
	["placa"] = { index = "placa", nome = "Placa" },
	["rebite"] = { index = "rebite", nome = "Rebite" },
	["carbono"] = { index = "carbono", nome = "Carbono" },
	["ferro"] = { index = "ferro", nome = "Ferro" },
	["aco"] = { index = "aco", nome = "Aço" },
	["adubo"] = { index = "adubo", nome = "Adubo" },
	["fertilizante"] = { index = "fertilizante", nome = "Fertilizante" },
	["colete"] = { index = "colete", nome = "Colete" },
	---------------------------------------------------------------------------
	["reagentesdemeta"] = { index = "reagentesdemeta", nome = "Reagentes De Metanfetamina" },
	["preparodemeta"] = { index = "preparodemeta", nome = "Preparo De Metanfetamina" },
	["metanfetamina"] = { index = "metanfetamina", nome = "Metanfetamina" },
	["reagentesdecoca"] = { index = "reagentesdecoca", nome = "Reagentes De Cocaina" },
	["preparodecoca"] = { index = "preparodecoca", nome = "Preparo De Cocaina" },
	["cocaina"] = { index = "cocaina", nome = "Cocaina" },
	---------------------------------------------------------------------------

	["capsula"] = { index = "capsula", nome = "Cápsula" },
	["polvora"] = { index = "polvora", nome = "Pólvora" },
	["orgao"] = { index = "orgao", nome = "Órgão" },
	["etiqueta"] = { index = "etiqueta", nome = "Etiqueta" },
	["pendrive"] = { index = "pendrive", nome = "Pendrive" },
	["relogioroubado"] = { index = "relogioroubado", nome = "Relógio Roubado" },
	["pulseiraroubada"] = { index = "pulseiraroubada", nome = "Pulseira Roubada" },
	["anelroubado"] = { index = "anelroubado", nome = "Anel Roubado" },
	["diamante"] = { index = "diamante", nome = "Diamante" },
	["colarroubado"] = { index = "colarroubado", nome = "Colar Roubado" },
	["brincoroubado"] = { index = "brincoroubado", nome = "Brinco Roubado" },
	["carteiraroubada"] = { index = "carteiraroubada", nome = "Carteira Roubada" },
	["carregadorroubado"] = { index = "carregadorroubado", nome = "Carregador Roubado" },
	["tabletroubado"] = { index = "tabletroubado", nome = "Tablet Roubado" },
	["sapatosroubado"] = { index = "sapatosroubado", nome = "Sapatos Roubado" },
	["vibradorroubado"] = { index = "vibradorroubado", nome = "Vibrador Roubado" },
	["perfumeroubado"] = { index = "perfumeroubado", nome = "Perfume Roubado" },
	["maquiagemroubada"] = { index = "maquiagemroubada", nome = "Maquiagem Roubada" },
    ---------------------------------------------------------------------------
	["wbody|WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga" },
	["wbody|WEAPON_BAT"] = { index = "beisebol", nome = "Taco de Beisebol" },
	["wbody|WEAPON_BOTTLE"] = { index = "garrafa", nome = "Garrafa" },
	["wbody|WEAPON_CROWBAR"] = { index = "cabra", nome = "Pé de Cabra" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golf", nome = "Taco de Golf" },
	["wbody|WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo" },
	["wbody|WEAPON_HATCHET"] = { index = "machado", nome = "Machado" },
	["wbody|WEAPON_KNUCKLE"] = { index = "ingles", nome = "Soco-Inglês" },
	["wbody|WEAPON_KNIFE"] = { index = "faca", nome = "Faca" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Machete" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete" },
	["wbody|WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha" },
	["wbody|WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra" },
	["wbody|WEAPON_PISTOL"] = { index = "m1911", nome = "M1911" },
	["wbody|WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "FN Five Seven" },
	["wbody|WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock 19" },
	["wbody|WEAPON_APPISTOL"] = { index = "vp9", nome = "Koch VP9" },
	["wbody|WEAPON_STUNGUN"] = { index = "tazer", nome = "Tazer" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "hkp7m10", nome = "HK P7M10" },
	["wbody|WEAPON_VINTAGEPISTOL"] = { index = "m1922", nome = "M1922" },
	["wbody|WEAPON_REVOLVER"] = { index = "magnum44", nome = "Magnum 44" },
	["wbody|WEAPON_MUSKET"] = { index = "winchester22", nome = "Winchester 22" },
	["wbody|WEAPON_FLARE"] = { index = "sinalizador", nome = "Sinalizador" },
	["wbody|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas" },
	["wbody|WEAPON_STICKYBOMB"] = { index = "stickybomb", nome = "Stickybomb" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor" },
	["wbody|WEAPON_MICROSMG"] = { index = "uzi", nome = "Uzi" },
	["wbody|WEAPON_SMG"] = { index = "mp5", nome = "MP5" },
	["wbody|WEAPON_ASSAULTSMG"] = { index = "mtar21", nome = "MTAR-21" },
	["wbody|WEAPON_COMBATPDW"] = { index = "sigsauer", nome = "Sig Sauer MPX" },
	["wbody|WEAPON_PUMPSHOTGUN"] = { index = "remington", nome = "Remington 870" },
	["wbody|WEAPON_CARBINERIFLE"] = { index = "m4a1", nome = "M4A1" },
	["wbody|WEAPON_ASSAULTRIFLE"] = { index = "ak103", nome = "AK-103" },
	["wbody|WEAPON_GUSENBERG"] = { index = "thompson", nome = "Thompson" },
	["wammo|WEAPON_PISTOL"] = { index = "m-m1911", nome = "Munição de M1911" },
	["wammo|WEAPON_STICKYBOMB"] = { index = "m-c4", nome = "Carga C4" },
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-fiveseven", nome = "Munição de FN Five Seven" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "Munição de Glock 19" },
	["wammo|WEAPON_APPISTOL"] = { index = "m-vp9", nome = "Munição de Koch VP9" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-tazer", nome = "Munição de Tazer" },
	["wammo|WEAPON_SNSPISTOL"] = { index = "m-hkp7m10", nome = "Munição de HK P7M10" },
	["wammo|WEAPON_VINTAGEPISTOL"] = { index = "m-m1922", nome = "Munição de M1922" },
	["wammo|WEAPON_REVOLVER"] = { index = "m-magnum44", nome = "Munição de Magnum 44" },
	["wammo|WEAPON_MUSKET"] = { index = "m-winchester22", nome = "Munição de Winchester 22" },
	["wammo|WEAPON_FLARE"] = { index = "m-sinalizador", nome = "Munição de Sinalizador" },
	["wammo|GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "Munição de Paraquedas" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "Munição de Extintor" },
	["wammo|WEAPON_MICROSMG"] = { index = "m-uzi", nome = "Munição de Uzi" },
	["wammo|WEAPON_SMG"] = { index = "m-mp5", nome = "Munição de MP5" },
	["wammo|WEAPON_ASSAULTSMG"] = { index = "m-mtar21", nome = "Munição de MTAR-21" },
	["wammo|WEAPON_COMBATPDW"] = { index = "m-sigsauer", nome = "Munição de Sig Sauer MPX" },
	["wammo|WEAPON_PUMPSHOTGUN"] = { index = "m-remington", nome = "Munição de Remington 870" },
	["wammo|WEAPON_CARBINERIFLE"] = { index = "m-m4a1", nome = "Munição de M4A1" },
	["wammo|WEAPON_ASSAULTRIFLE"] = { index = "m-ak103", nome = "Munição de AK-103" },
	["wammo|WEAPON_GUSENBERG"] = { index = "m-thompson", nome = "Munição de Thompson" },
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Combustível" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Galão de Gasolina" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('item',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] and itemlist[args[1]] ~= nil then
			vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS ONLINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('players',function(source,args,rawCommand)
	local onlinePlayers = GetNumPlayerIndices()
	TriggerClientEvent("Notify",source,"importante","<b>Jogadores Online: "..onlinePlayers.."</b>")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /REVISTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('revistar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(user_id)
		local weapons = vRPclient.getWeapons(nplayer)
		local money = vRP.getMoney(nuser_id)
		local data = vRP.getUserDataTable(nuser_id)
		TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
		if data and data.inventory then
			for k,v in pairs(data.inventory) do
				TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome)
			end
		end
		TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
		for k,v in pairs(weapons) do
			if v.ammo < 1 then
				TriggerClientEvent('chatMessage',source,"",{},"     1x "..itemlist["wbody|"..k].nome)
			else
				TriggerClientEvent('chatMessage',source,"",{},"     1x "..itemlist["wbody|"..k].nome.." | "..vRP.format(parseInt(v.ammo)).."x Munições")
			end
		end
		TriggerClientEvent('chatMessage',source,"",{},"     $"..vRP.format(parseInt(money)).." Dólares")
		TriggerClientEvent("Notify",nplayer,"aviso","Revistado por <b>"..identity.name.." "..identity.firstname.."</b>.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALÁRIO
-----------------------------------------------------------------------------------------------------------------------------------------
local salarios = {
	{ ['permissao'] = "bronze.permissao", ['nome'] = "BRONZE", ['payment'] = 300 },
	{ ['permissao'] = "prata.permissao", ['nome'] = "PRATA", ['payment'] = 500 },
	{ ['permissao'] = "ouro.permissao", ['nome'] = "OURO", ['payment'] = 600 },
	{ ['permissao'] = "platina.permissao", ['nome'] = "PLATINA", ['payment'] = 700 },
	{ ['permissao'] = "policia.permissao", ['nome'] = "POLICIA", ['payment'] = 2100 },
	{ ['permissao'] = "paramedico.permissao", ['nome'] = "PARAMEDICO", ['payment'] = 2100 },
	{ ['permissao'] = "conce.permissao", ['nome'] = "Concessionaria", ['payment'] = 1900 },
	{ ['permissao'] = "news.permissao", ['nome'] = "RoyaleNews", ['payment'] = 1900 },
	{ ['permissao'] = "mecanico.permissao", ['nome'] = "MECANICO", ['payment'] = 1900 },
	{ ['permissao'] = "judiciario.permissao", ['nome'] = "JUDICIARIO", ['payment'] = 1900 },
	
}

RegisterServerEvent('salario:pagamento')
AddEventHandler('salario:pagamento',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(salarios) do
			if vRP.hasPermission(user_id,v.permissao) then
				TriggerClientEvent("Notify",source,"importante","Obrigado por colaborar com a cidade, sua recompensa foi depositada.")
				vRP.giveBankMoney(user_id,parseInt(v.payment))
				vRP.logs("savedata/salario.txt","[ID]: "..user_id)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("kickAFK")
AddEventHandler("kickAFK",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if not vRP.hasPermission(user_id,"admin.permissao") then
		DropPlayer(source,"Voce foi desconectado por ficar ausente.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /SEQUESTRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sequestro',function(source,args,rawCommand)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALERTAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('alertas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"alertas.permissao") then
		vRP.removeUserGroup(user_id,"Alertas")
		TriggerClientEvent("Notify",source,"importante","Você removeu as notificações.")
	else
		vRP.addUserGroup(user_id,"Alertas")
		TriggerClientEvent("Notify",source,"sucesso","Você ativou as notificações.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRATAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tratamento',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"paramedico.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,3)
		if nplayer then
			TriggerClientEvent('tratamento',nplayer)
			TriggerClientEvent("Notify",nplayer,"sucesso","Tratamento iniciado, aguarde a liberação do paramédico.")
			TriggerClientEvent("Notify",source,"sucesso","Tratamento no paciente iniciado com sucesso.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CASAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('casas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if args[1] and vRP.hasPermission(user_id,"policia.permissao") then
		local nplayer = vRP.getUserSource(parseInt(args[1]))
		if nplayer == nil then
			return
		end
		user_id = vRP.getUserId(nplayer)
	end
	if user_id then
		local address = vRP.getUserAddress(user_id)
		local casas = ""
		if args[1] then
			if #address > 0 then
				for k,v in pairs(address) do
					casas = casas..v.home.." - Nº"..v.number
					if k ~= #address then
						casas = casas..", "
					end
				end
				TriggerClientEvent("Notify",source,"importante","Residências possuidas pelo passaporte <b>"..vRP.format(parseInt(args[1])).."</b>: "..casas)
			else
				TriggerClientEvent("Notify",source,"negado","Passaporte <b>"..vRP.format(parseInt(args[1])).."</b> não possui residências.")
			end
		else
			if #address > 0 then
				for k,v in pairs(address) do
					casas = casas..v.home.." - Nº"..v.number
					if k ~= #address then
						casas = casas..", "
					end
				end
				TriggerClientEvent("Notify",source,"importante","Residências possuidas: "..casas)
			else
				TriggerClientEvent("Notify",source,"importante","Não possui residências em seu nome.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RG2 -- BY HENRIQUE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rg', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local groupv = vRP.getUserGroupByType(user_id,"job") or "Desempregado"
    local groupname = vRP.getGroupTitle(groupv)
    local firstname = identity.firstname
    local name = identity.name
    local registration = identity.registration
    local age = identity.age
    local money = vRP.getMoney(user_id)
    local bank = vRP.getBankMoney(user_id)
    local phone = identity.phone
    local idplayer = identity.user_id
    local multas = vRP.getUData(user_id, "vRP:Multas") 
    local mymultas = json.decode(multas) or 0
    local paypal = vRP.getUData(user_id,"vRP:paypal")
    local mypaypal = json.decode(paypal) or 0

    vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 20%; right: 0.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #99cc00; }","<div class=\"local\"><b>Nome:</b> "..firstname.." "..name.." (ID: "..idplayer..")</div><div class=\"local2\"><b>Paypal:</b> $"..mypaypal.."</div><div class=\"local\"><b>Idade:</b> "..age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..phone.."</div><div class=\"local\"><b>Multas:</b> $"..mymultas.."</div><div class=\"local2\"><b>Carteira:</b> $"..money.."</div><div class=\"local\"><b>Emprego:</b> "..groupname.."</div><div class=\"local2\"><b>Banco:</b> $"..bank.."</div>")
    if vRP.request(source,"Deseja fechar o seu RG?",900) then
        vRPclient.removeDiv(source, "completerg")
    else
        vRPclient.removeDiv(source, "completerg")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MULTAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('multa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local value = vRP.getUData(parseInt(user_id),"vRP:Multas")
	local multas = json.decode(value) or 0
	if args[1] then
		if parseInt(multas) > 0 and parseInt(args[1]) > 0 and parseInt(args[1]) <= parseInt(multas) then
			if vRP.tryFullPayment(user_id,parseInt(args[1])) then
				vRP.setUData(user_id,"vRP:Multas",json.encode(parseInt(multas)-parseInt(args[1])))
				TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>$"..parseInt(args[1]).."</b> em multas")
			else
				TriggerClientEvent("Notify",source,"aviso","<b>Dinheiro Insuficiente</b>")
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Valor inválido, verifique suas <b>multas pendentes</b>")
		end
	else
		if parseInt(multas) == 0 then
			TriggerClientEvent("Notify",source,"aviso","Você não tem <b>multas</b> para pagar")
		else
			TriggerClientEvent("Notify",source,"sucesso","Você tem <b>$"..parseInt(multas).."</b> em multas para pagar")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('motor',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if not vRPclient.isInVehicle(source) then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vRP.hasPermission(user_id,"mecanico.permissao") then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
			TriggerClientEvent("progress",source,30000,"reparando")
			SetTimeout(30000,function()
				TriggerClientEvent('cancelando',source,false)
				TriggerClientEvent('repararmotor',source,vehicle)
				vRPclient._stopAnim(source,false)
			end)
		else
			if vRP.tryGetInventoryItem(user_id,"militec",1) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
				TriggerClientEvent("progress",source,30000,"reparando")
				SetTimeout(30000,function()
					TriggerClientEvent('cancelando',source,false)
					TriggerClientEvent('repararmotor',source,vehicle)
					vRPclient._stopAnim(source,false)
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Precisa de um <b>Militec-1</b> para reparar o motor.")
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Precisa estar próximo ou fora do veículo para efetuar os reparos.")
	end
end)

RegisterServerEvent("trymotor")
AddEventHandler("trymotor",function(nveh)
	TriggerClientEvent("syncmotor",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reparar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if not vRPclient.isInVehicle(source) then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vRP.hasPermission(user_id,"mecanico.permissao") then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
			TriggerClientEvent("progress",source,30000,"reparando")
			SetTimeout(30000,function()
				TriggerClientEvent('cancelando',source,false)
				TriggerClientEvent('reparar',source,vehicle)
				vRPclient._stopAnim(source,false)
			end)
		else
			if vRP.tryGetInventoryItem(user_id,"repairkit",1) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
				TriggerClientEvent("progress",source,30000,"reparando")
				SetTimeout(30000,function()
					TriggerClientEvent('cancelando',source,false)
					TriggerClientEvent('reparar',source,vehicle)
					vRPclient._stopAnim(source,false)
				end)
			else
				TriggerClientEvent("Notify",source,"negado","Precisa de um <b>Kit de Reparos</b> para reparar o veículo.")
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Precisa estar próximo ou fora do veículo para efetuar os reparos.")
	end
end)

RegisterServerEvent("tryreparar")
AddEventHandler("tryreparar",function(nveh)
	TriggerClientEvent("syncreparar",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENVIAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('enviar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id and parseInt(args[1]) > 0 then
		if vRP.tryPayment(user_id,parseInt(args[1])) then
			vRP.giveMoney(nuser_id,parseInt(args[1]))
			vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",source,"sucesso","Enviou <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.")
			TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.")
			vRP.logs("savedata/enviar.txt","[ID]: "..user_id.." / [NID]: "..nuser_id.." / [VALOR]: "..parseInt(args[1]))
		else
			TriggerClientEvent("Notify",source,"negado","Não tem a quantia que deseja enviar.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLONEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cloneplate',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.isInVehicle(source) and vRP.tryGetInventoryItem(user_id,"placa",1) then
			TriggerClientEvent("cloneplates",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('roubar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia >= 1 then
			if vRP.request(nplayer,"Você está sendo roubado, deseja passar tudo?",30) then
				local vida = vRPclient.getHealth(nplayer)
				if vida <= 100 then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
					TriggerClientEvent("progress",source,30000,"roubando")
					SetTimeout(30000,function()
						local ndata = vRP.getUserDataTable(nuser_id)
						if ndata ~= nil then
							if ndata.inventory ~= nil then
								for k,v in pairs(ndata.inventory) do
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
										if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
											vRP.giveInventoryItem(user_id,k,v.amount)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome.."</b> por causa do peso.")
									end
								end
							end
						end
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
									vRP.giveInventoryItem(user_id,"wbody|"..k,1)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..itemlist["wbody"..k].nome.."</b> por causa do peso.")
							end
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
										vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..itemlist["wammo|"..k].nome.."</b> por causa do peso.")
								end
							end
						end
						local nmoney = vRP.getMoney(nuser_id)
						if vRP.tryPayment(nuser_id,nmoney) then
							vRP.giveMoney(user_id,nmoney)
						end
						vRPclient.setStandBY(source,parseInt(600))
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
					end)
				else
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
										vRP.giveInventoryItem(user_id,k,v.amount)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome.."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody|"..k,1)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..itemlist["wbody|"..k].nome.."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..itemlist["wammo|"..k].nome.."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveMoney(user_id,nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
				end
			else
				TriggerClientEvent("Notify",source,"aviso","A pessoa está resistindo ao roubo.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Número insuficiente de policiais no momento.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytow")
AddEventHandler("trytow",function(nveh,rveh)
	TriggerClientEvent("synctow",-1,nveh,rveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trywins")
AddEventHandler("trywins",function(nveh)
	TriggerClientEvent("syncwins",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALL
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
RegisterCommand('call',function(source,args,rawCommand)
	local source = source
	local answered = false
	local user_id = vRP.getUserId(source)
	if user_id then
		local players = {}
		if args[1] == "911" then
			players = vRP.getUsersByPermission("policia.permissao")
		elseif args[1] == "112" then
			players = vRP.getUsersByPermission("paramedico.permissao")
		elseif args[1] == "mec" then
			players = vRP.getUsersByPermission("mecanico.permissao")
		elseif args[1] == "adm" then
			players = vRP.getUsersByPermission("wl.permissao")
		elseif args[1] == "css" then
			players = vRP.getUsersByPermission("conce.permissao")
		elseif args[1] == "juiz" then
			players = vRP.getUsersByPermission("juiz.permissao")
		elseif args[1] == "taxi" then
			players = vRP.getUsersByPermission("taxista.permissao")
		else
			TriggerClientEvent("Notify",source,"negado","Serviço inexistente.")
			return
		end

		local descricao = vRP.prompt(source,"Descrição:","")
		if descricao == "" then
			return
		end

		local identitys = vRP.getUserIdentity(user_id)
		TriggerClientEvent("Notify",source,"sucesso","Chamado enviado com sucesso.")
		for l,w in pairs(players) do
			local player = vRP.getUserSource(parseInt(w))
			local nuser_id = vRP.getUserId(player)
			local x,y,z = vRPclient.getPosition(source)
			local uplayer = vRP.getUserSource(user_id)
			if player and player ~= uplayer then
				async(function()
					vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
					TriggerClientEvent('chatMessage',player,"CHAMADO",{19,197,43},"Enviado por ^1"..identitys.name.." "..identitys.firstname.." - "..identitys.user_id.."^0, "..descricao)
					local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."  ("..identitys.user_id..")</b>?",30)
					if ok then
						if not answered then
							answered = true
							local identity = vRP.getUserIdentity(nuser_id)
							TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
							vRPclient._setGPS(player,x,y)
						else
							TriggerClientEvent("Notify",player,"negado","Chamado ja foi atendido por outra pessoa.")
							vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
						end
					end
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,358,71,"Chamado",0.6,false)
					SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
	TriggerClientEvent('mascara',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de calça.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
	TriggerClientEvent('oculos',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de calça.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('chapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
	TriggerClientEvent('chapeu',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de calça.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
	TriggerClientEvent('maos',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de calça.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACESSORIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('acessorios',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
		TriggerClientEvent('acessorios',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de acessórios.")
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- SAPATO
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sapatos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 then
		TriggerClientEvent('sapatos',source,args[1],args[2])
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de sapatos.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- P
-----------------------------------------------------------------------------------------------------------------------------------------
local policia = {}
RegisterCommand('p',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if vRPclient.getHealth(source) > 100 then
		if vRP.hasPermission(user_id,"policia.permissao") then
			local soldado = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player and player ~= uplayer then
					async(function()
						local id = idgens:gen()
						policia[id] = vRPclient.addBlip(player,x,y,z,153,84,"Localização de "..identity.name.." "..identity.firstname,0.5,false)
						TriggerClientEvent("Notify",player,"importante","Localização recebida de <b>"..identity.name.." "..identity.firstname.."</b>.")
						vRPclient._playSound(player,"Place_Prop_Fail","DLC_Dmod_Prop_Editor_Sounds")
						SetTimeout(60000,function() vRPclient.removeBlip(player,policia[id]) idgens:free(id) end)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('911',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			TriggerClientEvent('chatMessage',-1,identity.name.." "..identity.firstname,{65,130,255},rawCommand:sub(4))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('112',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			TriggerClientEvent('chatMessage',-1,identity.name.." "..identity.firstname,{255,70,135},rawCommand:sub(4))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- css
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('css',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			TriggerClientEvent('chatMessage',-1,identity.name.." "..identity.firstname,{255,225,135},rawCommand:sub(4))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Mec
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mec',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			TriggerClientEvent('chatMessage',-1,identity.name.." "..identity.firstname,{255,255,0},rawCommand:sub(4))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "policia.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "paramedico.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('me',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatME',-1,source,identity.name,rawCommand:sub(3))
		vRP.logs("savedata/me.txt","[ID]: "..user_id.." / [MENSAGEM]: "..rawCommand:sub(3))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARTAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('card',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local cd = math.random(1,13)
		local naipe = math.random(1,4)
		TriggerClientEvent('CartasMe',-1,source,identity.name,cd,naipe)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GUARDAR COLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('gcolete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local armour = vRPclient.getArmour(player)
	if armour > 95 then
       vRPclient.setArmour(source,0)
       vRP.giveInventoryItem(user_id,"colete",1,true)
       TriggerClientEvent("tirandocolete",player)
       TriggerClientEvent("Notify",source,"sucesso","Você guardou o seu <b>Colete</b>.")
    else
       TriggerClientEvent("Notify",source,"negado","<b>Coletes</b> danificados não podem ser <b>Guardados</b>.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JOGAR FORA O COLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jcolete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local armour = vRPclient.getArmour(player)
	if armour < 95 then
       vRPclient.setArmour(source,0)
       TriggerClientEvent("tirandocolete",player)
       TriggerClientEvent("Notify",source,"sucesso","Você jogou fora o seu <b>Colete</b>.")
       vRPclient._playAnim(player,true,{{"pickup_object","pickup_low",1}},false)
    else
       TriggerClientEvent("Notify",source,"negado","Seu <b>Colete</b> nao está <b>Danificado</b>.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
local bandagem = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(bandagem) do
			if v > 0 then
				bandagem[k] = v - 1
			end
		end
	end
end)

RegisterCommand('usar',function(source,args,rawCommand)
	if args[1] == nil then
		return
	end
	local user_id = vRP.getUserId(source)
	if args[1] == "capuz" then
		if vRP.getInventoryItemAmount(user_id,"capuz") >= 1 then
			local nplayer = vRPclient.getNearestPlayer(source,2)
			if nplayer then
				vRPclient.setCapuz(nplayer)
				vRP.closeMenu(nplayer)
				TriggerClientEvent("Notify",source,"sucesso","Capuz utilizado com Sucesso.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Capuz não encontrado na Mochila.")
		end
	elseif args[1] == "masterpick" then
		local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(source,7)
		local mPlacaUser = vRP.getUserByRegistration(mPlaca)
		if vRP.getInventoryItemAmount(user_id,"masterpick") >= 1 and mName then
			if vRP.hasPermission(user_id,"policiasalario.permissao") then
				TriggerClientEvent("syncLock",-1,mNet)
				return
			end

			TriggerClientEvent('cancelando',source,true)
			vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
			TriggerClientEvent("progress",source,30000,"roubando")
			SetTimeout(30000,function()
				TriggerClientEvent('cancelando',source,false)
				vRPclient._stopAnim(source,false)

				if not mPlacaUser then
					TriggerClientEvent("syncLock",-1,mNet)
					TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
				else
					if math.random(100) >= 60 then
						TriggerClientEvent("syncLock",-1,mNet)
						TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
					else
						TriggerClientEvent("Notify",source,"negado","Roubo do veículo falhou e as autoridades foram acionadas.")
						local policia = vRP.getUsersByPermission("policiasalario.permissao")
						for k,v in pairs(policia) do
							local player = vRP.getUserSource(parseInt(v))
							if player then
								async(function()
									local id = idgens:gen()
									TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Roubo na ^1"..mStreet.."^0 do veículo ^1"..mModel.."^0 de placa ^1"..mPlaca.."^0 verifique o ocorrido.")
									pick[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
									SetTimeout(60000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
								end)
							end
						end
					end
				end
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Precisa de uma <b>Masterpick</b> para iniciar o roubo do veículo.")
		end
	elseif args[1] == "lockpick" then
		local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(source,7)
		local mPlacaUser = vRP.getUserByRegistration(mPlaca)
		if vRP.tryGetInventoryItem(user_id,"lockpick",1) and mName then

			if vRP.hasPermission(user_id,"policiasalario.permissao") then
				TriggerClientEvent("syncLock",-1,mNet)
				return
			end

			TriggerClientEvent('cancelando',source,true)
			vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
			TriggerClientEvent("progress",source,60000,"roubando")

			SetTimeout(60000,function()
				TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
				TriggerClientEvent('cancelando',source,false)
				TriggerClientEvent("syncLock",-1,mNet)
				vRPclient._stopAnim(source,false)

				local policia = vRP.getUsersByPermission("policiasalario.permissao")
				for k,v in pairs(policia) do
					local player = vRP.getUserSource(parseInt(v))
					if player then
						async(function()
							local id = idgens:gen()
							TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Roubo na ^1"..mStreet.."^0 do veículo ^1"..mModel.."^0 de placa ^1"..mPlaca.."^0 verifique o ocorrido.")
							pick[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
							SetTimeout(60000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
						end)
					end
				end
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Precisa de uma <b>Lockpick</b> para iniciar o roubo do veículo.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
local roupas = {
	["mergulho"] = {
		[1885233650] = {
			[1] = { 122,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 31,0 },
			[4] = { 94,0 },
			[8] = { 123,0 },
			[6] = { 67,0 },
			[11] = { 243,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 },
			["p1"] = { 26,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 122,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 18,0 },
			[4] = { 97,0 },
			[8] = { 153,0 },
			[6] = { 70,0 },
			[11] = { 251,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { -1,0 },
			["p1"] = { 28,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["paciente"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 61,0 },
			[8] = { 15,0 },
			[6] = { 16,0 },
			[11] = { 104,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { 28,1 },
			["p1"] = { 7,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[5] = { -1,0 },
			[7] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 15,3 },
			[8] = { 7,0 },
			[6] = { 5,0 },
			[11] = { 5,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			["p0"] = { 29,1 },
			["p1"] = { 15,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	}
}

RegisterCommand('roupas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getStandBY(source) == 0 then
		if args[1] then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._playAnim(source,false,{{"missfbi3_camcrew","final_loop_guy"}},true)
			TriggerClientEvent("progress",source,15000,"colocando roupa")
			SetTimeout(15000,function()
				vRPclient._stopAnim(source,false)
				TriggerClientEvent('cancelando',source,false)
				local custom = roupas[tostring(args[1])]
				if custom then
					local old_custom = vRPclient.getCustomization(source)
					local idle_copy = {}

					idle_copy = vRP.save_idle_custom(source,old_custom)
					idle_copy.modelhash = nil

					for l,w in pairs(custom[old_custom.modelhash]) do
						idle_copy[l] = w
					end
					vRPclient._setCustomization(source,idle_copy)
				end
			end)
		else
			TriggerClientEvent('cancelando',source,true)
			vRPclient._playAnim(source,false,{{"missfbi3_camcrew","final_loop_guy"}},true)
			TriggerClientEvent("progress",source,15000,"retirando roupa")
			SetTimeout(15000,function()
				vRPclient._stopAnim(source,false)
				TriggerClientEvent('cancelando',source,false)
				vRP.removeCloak(source)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /PAYPAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('paypal',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] == "sacar" and parseInt(args[2]) > 0 then
			local consulta = vRP.getUData(user_id,"vRP:paypal")
			local resultado = json.decode(consulta) or ""
			if resultado >= parseInt(args[2]) then
				vRP.giveBankMoney(user_id,parseInt(args[2]))
				vRP.setUData(user_id,"vRP:paypal",json.encode(parseInt(resultado-args[2])))
				TriggerClientEvent("Notify",source,"sucesso","Efetuou o saque de <b>$"..vRP.format(parseInt(args[2])).." dólares</b> da sua conta paypal.")
				vRP.logs("savedata/paypal.txt","[ID]: "..user_id.." / [SACAR]: "..parseInt(args[2]))
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente em sua conta paypal.")
			end
		elseif args[1] == "trans" and parseInt(args[2]) > 0 and parseInt(args[3]) > 0 then
			local consulta = vRP.getUData(args[2],"vRP:paypal")
			local resultado = json.decode(consulta) or 0
			local banco = vRP.getBankMoney(user_id)
			if banco >= parseInt(args[3]) then
				vRP.setBankMoney(user_id,parseInt(banco-args[3]))
				vRP.setUData(parseInt(args[2]),"vRP:paypal",json.encode(parseInt(resultado+args[3])))
				vRP.logs("savedata/paypal.txt","[ID]: "..user_id.." / [NID]: "..parseInt(args[2]).." / [TRANSFERENCIA]: "..parseInt(args[3]))
				TriggerClientEvent("Notify",source,"sucesso","Enviou <b>$"..vRP.format(parseInt(args[3])).." dólares</b> ao passaporte <b>"..vRP.format(parseInt(args[2])).."</b>.")
				local player = vRP.getUserSource(parseInt(args[2]))
				if player == nil then
					return
				else
					local identity = vRP.getUserIdentity(user_id)
					TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> transferiu <b>$"..vRP.format(parseInt(args[3])).." dólares</b> para sua conta do paypal.")
				end
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
			end
		end
	end
end)
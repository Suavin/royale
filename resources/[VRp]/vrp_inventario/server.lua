local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_inventario")
-- Dclient = Tunnel.getInterface("vrp_inventario")
-- RESOURCE TUNNEL/PROXY
src = {}
Tunnel.bindInterface("vrp_inventario",src)
Proxy.addInterface("vrp_inventario",src)
IClient = Tunnel.getInterface("vrp_inventario")


local coldowngArmas = {}

RegisterServerEvent("vrp_inventario:openGui")
AddEventHandler("vrp_inventario:openGui",function()
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data and data.inventory then
        local inventory = {}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Pega itens equipados
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------           
        local equipado = {}
        local weapons = vRPclient.getWeapons(source)
        for k,v in pairs(weapons) do
            local item_name = vRP.getItemName("wbody|"..k)
            table.insert(equipado,
                {
                    id = item_name,
                    icon = items["wbody|"..k][5],
                    nome = vRP.getItemName("wbody|"..k),
                    municao = parseInt(v.ammo)
                }
            )                        
        end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Pega itens do inventory
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------           
        for data_k, data_v in pairs(data.inventory) do
            for items_k, items_v in pairs(items) do
                if data_k == items_k then
                    -- print(data_k)
                    local item_name = vRP.getItemName(data_k)
                    -- print(item_name)
                    local itemWeight = vRP.getItemWeight(data_k)
                        if item_name then
                            table.insert(inventory,
                                {
                                    name = item_name,
                                    amount = data_v.amount,
                                    item_peso = itemWeight,
                                    idname = data_k,
                                    icon = items_v[5],
                                    type = items_v[6]
                                }
                            )
                    end
                end
            end
        end
        local weight = vRP.getInventoryWeight(user_id)
        local maxWeight = vRP.getInventoryMaxWeight(user_id)
        TriggerClientEvent("vrp_inventario:updateInventory", source, inventory, weight, maxWeight,equipado)
    end
end)

RegisterServerEvent("vrp_inventario:useItem")
AddEventHandler("vrp_inventario:useItem",function(args)
        local data = args
        local user_id = vRP.getUserId(source)
        local player = vRP.getUserSource(user_id)

        if data.idname then
            for k, v in pairs(items) do
                if data.idname == k then
                    useItem(user_id, player, k, v[1], v[2], v[3], v[4], data.amount)
                end
            end
        end
end)

RegisterServerEvent("vrp_inventario:garmas")
AddEventHandler("vrp_inventario:garmas",function()
local source = source
local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        if coldowngArmas[user_id] == false or coldowngArmas[user_id] == nil then
          coldowngArmas[user_id] = true
          local weapons = vRPclient.getWeapons(source)
          for k,v in pairs(weapons) do
            -- convert weapons to parametric weapon items
            vRP.giveInventoryItem(user_id, "wbody|"..k, 1, true)
            if v.ammo > 0 then
              vRP.giveInventoryItem(user_id, "wammo|"..k, v.ammo, true)
            end
          end
          -- clear all weapons
          vRPclient.giveWeapons(source,{},true)
          Wait(15000)
          coldowngArmas[user_id] = false
        end
    end
end)
RegisterServerEvent("vrp_inventario:dropItem")
AddEventHandler("vrp_inventario:dropItem",function(data)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local amount = parseInt(data.amount)
    local idname = data.idname
    if vRPclient.isInComa(player) then
        TriggerClientEvent("Notify",player,"negado","Você está em coma.",1)
    else
        if vRP.tryGetInventoryItem(user_id, data.idname, amount, false) then
            TriggerClientEvent("vrp_inventario:closeGui", player)
            TriggerClientEvent("DropSystem:drop", player, idname, amount) 
            vRPclient.playAnim(player, true, {{"pickup_object", "pickup_low", 1}}, false)
        else
            TriggerClientEvent("vrp_inventario:UINotification",player,
                "warning",
                Config.Language.WarningTitle,
                Config.Language.Error
            )
        end
    end    
end)

function split(str, sep)
    local array = {}
    local reg = string.format("([^%s]+)", sep)
    for mem in string.gmatch(str, reg) do
        table.insert(array, mem)
    end
    return array
end

function useItem(user_id, player, idname, type, varyhealth, varyThirst, varyHunger, amount)
    if vRPclient.isInComa(player) then
        TriggerClientEvent("Notify",player,"negado","Você está em coma.",1)
    else
        if type == "drink" or type == "food" or type == "heal" or type == "weapon" or type == "ammo" or type == "mochila" or type == "armor" or type == "maconha" or type == "cocaina"or type == "metanfetamina" or type == "alcool" or type == "money" or type == "energetico" or type == "capuz" or type == "bandagem" or type == "documento" then
            if type == "bandagem" then
                vida = vRPclient.getHealth(player)
                if vida > 100 and vida < 400 then
                    if bandagem[user_id] == 0 or not bandagem[user_id] then
                        if vRP.tryGetInventoryItem(user_id,"bandagem",1) then
                            TriggerClientEvent('cancelando',player,true)
                            TriggerClientEvent("progress",player,10000,"bandagem")
                            SetTimeout(10000,function()
                                bandagem[user_id] = 60
                                TriggerClientEvent('bandagem',player)
                                TriggerClientEvent('cancelando',player,false)
                                -- vRPclient.newNotify(player,210,{"~u~Capuz utilizado com sucesso."},1)
                            end)
                        else
                            TriggerClientEvent("Notify",player,"negado","Bandagem não encontrada na mochila.",1)
                        end
                    else
                        TriggerClientEvent("Notify",player,"negado","Você precisa aguardar <b>"..bandagem[user_id].." segundos</b> para utilizar outra Bandagem.",1)
                    end
                else
                    TriggerClientEvent("Notify",player,"negado","Você não pode utilizar de vida cheia ou nocauteado.",1)
                end
            end
            if type == "drink" then
                if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount), false) then
                    TriggerClientEvent("vrp_inventario:objectForAnimation", player, "prop_ld_flow_bottle")
                    play_drink(player)
                    for i = 1, tonumber(amount) do
                        vRP.varyThirst(user_id, varyThirst)
                        vRP.varyHunger(user_id, varyHunger)
                    end
                end
            end
            if type == "capuz" then
                if vRP.getInventoryItemAmount(user_id,"capuz") >= 1 then
                    local nplayer = vRPclient.getNearestPlayer(player,2)
                    if nplayer then
                        vRPclient.setCapuz(nplayer)
                        vRP.closeMenu(nplayer)
                        TriggerClientEvent("Notify",player,"sucesso","Capuz utilizado com sucesso.")
                    else
                        TriggerClientEvent("Notify",player,"negado","Nenhum Cidadão Próximo.",1)
                    end
                end
            end
            if type == "energetico" then
                if vRP.tryGetInventoryItem(user_id,"redbull",1,false) then
                    TriggerClientEvent('cancelando',player,true)
                    vRPclient._CarregarObjeto(player,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
                    TriggerClientEvent("progress",player,10000,"bebendo")
                    SetTimeout(10000,function()
                        TriggerClientEvent('energeticos',player,true)
                        TriggerClientEvent('cancelando',player,false)
                        vRPclient._DeletarObjeto(player)
                        -- vRPclient.newNotify(player,210,{"~u~Energético utilizado com sucesso."},0)
                    end)
                    SetTimeout(60000,function()
                        TriggerClientEvent('energeticos',player,false)
                        TriggerClientEvent("Notify",player,"aviso","O efeito do energético passou!",1)     
                    end)
                else
                    TriggerClientEvent("Notify",player,"negado","Energético não encontrado na mochila.",1)
                   
                end
            end
            if type == "food" then
                if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount), false) then
                    TriggerClientEvent("vrp_inventario:objectForAnimation", player, "prop_cs_burger_01")
                    play_eat(player)
                    for i = 1, tonumber(amount) do
                        vRP.varyThirst(user_id, varyThirst)
                        vRP.varyHunger(user_id, varyHunger)
                    end
                end
            end
            if type == "heal" then
                if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount), false) then
                    for i = 1, tonumber(amount) do
                        vRPclient.varyHealth(player, varyhealth)
                    end
                end
            end
            if type == "weapon" then
                if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount), false) then
                    local fullidname = string.sub(idname, 7)
                
                    vRPclient.giveWeapons(player,{[fullidname] = {ammo=0}})
                end
            end
            if type == "ammo" then
                local fullidname = string.sub(idname, 7)
              
                local exists = false
                local weapons =  vRPclient.getWeapons(player)
                if weapons then
                    for k, v in pairs(weapons) do
                        -- print(k)
                        if k == fullidname then
                            exists = true
                        end
                    end
                    if exists == true then
                        if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount), false) then
                            vRPclient.giveWeapons(player,{[fullidname] = {ammo = tonumber(amount)}})
                        end
                    else
                        TriggerClientEvent("Notify",player,"negado",Config.Language.WeaponNotEquipped,1)
                    end
                end
            end
            if type == "mochila" then
                local user_id = vRP.getUserId(player)
                
                if vRP.tryGetInventoryItem(user_id,"mochila",1,false) then
                    vRP.varyExp(user_id,"physical","strength",600)

                end
            end
            if type == "armor" then
                local user_id = vRP.getUserId(player)
                if user_id then
                    if vRP.tryGetInventoryItem(user_id, idname, 1, false) then -- take vest
                        vRPclient._setArmour(player, 100)
                    end
                end
            end
            
            if type == "maconha" then
                if vRP.tryGetInventoryItem(user_id,idname,1,false) then
                    TriggerClientEvent("Notify",player,"aviso","Fumando "..vRP.getItemName(idname)..".")
                    play_f1(player)

                    SetTimeout(10000,function()
                    vRPclient._stopAnim(player,true) -- upper
                    vRPclient._stopAnim(player,false) -- full
                    IClient.playMovement(player,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
                    IClient.playScreenEffect(player, "DMT_flight", 120)
                    TriggerClientEvent("vrp_sound:source",'is-this-love',0.5)
                   
                    --vRPclient.varyHealth(player,25)
                    vRP.varyHunger(user_id,20)
                    vRP.varyThirst(user_id,10)
                    end)
                    SetTimeout(120000,function()
                    IClient.resetMovement(player,false)
                  
                    end)
                end
            end
            if type == "cocaina" then
                if vRP.tryGetInventoryItem(user_id,idname,1,false) then
                    TriggerClientEvent("Notify",player,"aviso","Cheirando Cocaina.")
                    play_drink(player)
                    SetTimeout(10000,function()
                      IClient.playMovement(player,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
                      IClient.playScreenEffect(player, "DMT_flight", 120)
                      vRP.varyHunger(user_id,-50)
                    end)
                    SetTimeout(120000,function()
                      IClient.resetMovement(player,false)
                    end)
                end
            end
            if type == "metanfetamina" then
                if vRP.tryGetInventoryItem(user_id,idname,1,false) then
                    TriggerClientEvent("Notify",player,"aviso","Injetando Metanfetamina.")
                    play_drink(player)
                    SetTimeout(10000,function()
                      IClient.playMovement(player,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
                      IClient.playScreenEffect(player, "DMT_flight", 120)
                      vRP.varyHunger(user_id,-50)
                    end)
                    SetTimeout(120000,function()
                      IClient.resetMovement(player,{false})
                    end)
                  end
            end
            if type == "alcool" then 
                if vRP.tryGetInventoryItem(user_id,idname,1,false) then
                    TriggerClientEvent("Notify",player,"aviso","Bebendo Smirnoff.")
                    play_drink(player)
                    SetTimeout(5000,function()
                      IClient.playMovement(player,"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false)
                      IClient.playScreenEffect(player, "Rampage", 120)
                      vRP.varyHunger(user_id,30)
                      vRP.varyThirst(user_id,-70)
                      SetTimeout(120000,function()
                        IClient.resetMovement(player,false)
                      end)
                    end)
                    vRP.closeMenu(player)
                  end
            end
            if type == "money" then 
                if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount), false) then
                    vRP.giveMoney(user_id, tonumber(amount))
                end
            end
        end
        if type == "none" then
            TriggerClientEvent("Notify",player,"negado",Config.Language.CannotBeUsed,1)
        end
    end    
end

RegisterServerEvent("vrp_inventario:giveItem")
AddEventHandler("vrp_inventario:giveItem",function(data)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if vRPclient.isInComa(player) then
        TriggerClientEvent("Notify",player,"negado","Você está em coma.",1)
    else
        if user_id ~= nil then
            local nplayer = vRPclient.getNearestPlayer(player,10)
            if nplayer ~= nil then
                local nuser_id = vRP.getUserId(nplayer)
                if nuser_id ~= nil then
                    local amount = parseInt(data.amount)
                    if amount > 0 then
                        if vRP.getInventoryWeight(nuser_id)+vRP.getItemWeight(data.idname)*amount <= vRP.getInventoryMaxWeight(nuser_id) then
                            if vRP.tryGetInventoryItem(user_id, data.idname, amount, false) then
                                vRP.giveInventoryItem(nuser_id, data.idname, amount, true)
                                vRPclient.playAnim(player, true, {{"mp_common", "givetake1_a", 1}}, false)
                                vRPclient.playAnim(nplayer, true, {{"mp_common", "givetake2_a", 1}}, false)
                            else
                                TriggerClientEvent("Notify",player,"negado", Config.Language.Error,1)
                            end
                        else
                            TriggerClientEvent("Notify",nplayer,"negado",Config.Language.NotEnoughtSpace,1)
                            TriggerClientEvent("Notify",player,"negado",Config.Language.NotEnoughtSpace,1)
                        end
                    end
                else
                    TriggerClientEvent("Notify",source,"negado", Config.Language.NoNearby,1)
                end
            else
                TriggerClientEvent("Notify",source,"negado", Config.Language.NoNearby,1)
            end
        end
    end
end)

function play_eat(player)
    local seq = {
        {"mp_player_inteat@burger", "mp_player_int_eat_burger_enter",1},
        {"mp_player_inteat@burger", "mp_player_int_eat_burger",1},
        {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp",1},
        {"mp_player_inteat@burger", "mp_player_int_eat_exit_burger",1}
    }

    vRPclient.playAnim(player,true,seq,false)
end

function play_drink(player)
    local seq = {
        {"mp_player_intdrink","intro_bottle",1},
        {"mp_player_intdrink","loop_bottle",1},
        {"mp_player_intdrink","outro_bottle",1}
    }

    vRPclient.playAnim(player,true,seq,false)
end
function play_f1(player)
    vRPclient._playAnim(player, true, {task="WORLD_HUMAN_SMOKING_POT"}, false)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Trunk e Chests
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------           
local chests = {}
local chestOpen = {}
RegisterServerEvent("vrp_inventario:openChest")
AddEventHandler("vrp_inventario:openChest",function(chestName,chestMaxWeight,idOwner,idDestino)
   
    local sourceDestino = vRP.getUserSource(idDestino)
    local sourceOwner = vRP.getUserSource(idOwner)
        
    local data = vRP.getUserDataTable(idDestino)
    local cdata = vRP.getSData("chest:"..chestName)
    local chestitems = json.decode(cdata) or {}
    local chest = {}
    chestOpen[idDestino] = { ["chestName"] = chestName, ["maxWeight"] = chestMaxWeight }
    local chestWeight = 0 
        if chestitems then
            for k,v in pairs(chestitems) do
                local item_name = vRP.getItemName(k)
                local itemWeight = vRP.getItemWeight(k)
                chestWeight = chestWeight + itemWeight*v.amount
                table.insert(chest,
                    {
                        name = item_name,
                        amount = v.amount,
                        icon = items[k][5],
                        item_peso = itemWeight,
                        idname = k,
                        type = items[k][6],
                    }
                )  
            end
        end    

    if data and data.inventory then
        local inventory = {}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Pega itens do inventory
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------           
        for data_k, data_v in pairs(data.inventory) do
            for items_k, items_v in pairs(items) do
                if data_k == items_k then
                    local inventory_item_name = vRP.getItemName(data_k)
                    local inventory_itemWeight = vRP.getItemWeight(data_k)
                        if inventory_item_name then
                            table.insert(inventory,
                                {
                                    name = inventory_item_name,
                                    amount = data_v.amount,
                                    item_peso = inventory_itemWeight,
                                    idname = data_k,
                                    icon = items_v[5],
                                    type = items_v[6]
                                }
                            )
                    end
                end
            end
        end
        local weight = vRP.getInventoryWeight(idDestino)
        local maxWeight = vRP.getInventoryMaxWeight(idDestino)
        IClient.openChest( sourceDestino, inventory, weight, maxWeight, chest, chestWeight, chestMaxWeight)
    end
end)

function src.closeChest()
    local source = source
    local user_id = vRP.getUserId(source)
    chestOpen[user_id] = nil
    TriggerClientEvent("vrp:inventario:chestclose",source)
end


function src.putItem(data)
    local source = source
    local user_id = vRP.getUserId(source)
    local amount = parseInt(data.amount)
    local idname = data.idname
    local chestName = chestOpen[user_id]["chestName"]
    local chestMaxWeight = chestOpen[user_id]["maxWeight"]
    local cdata = vRP.getSData("chest:"..chestName)
    local chestitems = json.decode(cdata) or {}
    if idname and amount then
        local new_weight = vRP.computeItemsWeight(chestitems)+vRP.getItemWeight(idname)*amount
        if new_weight <= chestOpen[user_id]["maxWeight"] then         
            if amount > 0 and vRP.tryGetInventoryItem(user_id,idname,amount) then
                vRP.log("ingame.txt","[ID]: "..user_id.." / [FUNÇÃO]: Colocar / [ITEM]: "..idname.." / [QTD]: "..amount)
                if chestitems[idname] then
                    chestitems[idname].amount = chestitems[idname].amount + amount
                else
                    chestitems[idname] = { amount = amount }
                end
            end
        end
    end 
    vRP.setSData("chest:"..chestName,json.encode(chestitems))
    src.update(source,user_id,chestName,chestMaxWeight)
end

function src.takeItem(data)
    local source = source
    local user_id = vRP.getUserId(source)
    local amount = parseInt(data.amount)
    local idname = data.idname
    local chestName = chestOpen[user_id]["chestName"]
    local chestMaxWeight = chestOpen[user_id]["maxWeight"]
    local cdata = vRP.getSData("chest:"..chestName)
    local chestitems = json.decode(cdata) or {}
    if idname and amount then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(idname)*amount
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
            if amount > 0 and chestitems[idname].amount >= amount then
                vRP.giveInventoryItem(user_id,idname,amount)
                vRP.log("ingame.txt","[ID]: "..user_id.." / [FUNÇÃO]: Retirar / [ITEM]: "..idname.." / [QTD]: "..amount)
                if chestitems[idname].amount > amount then
                    chestitems[idname].amount = chestitems[idname].amount - amount
                elseif chestitems[idname].amount == amount then
                    chestitems[idname] = nil
                end
            end
        end
    end 
    vRP.setSData("chest:"..chestName,json.encode(chestitems))
    src.update(source,user_id,chestName,chestMaxWeight)
end

function src.update(source,user_id,chestName,chestMaxWeight)
    local data = vRP.getUserDataTable(user_id)
    local cdata = vRP.getSData("chest:"..chestName)
    local chestitems = json.decode(cdata) or {}
    local chest = {}
    chestOpen[user_id] = {["chestName"] = chestName, ["maxWeight"] = chestMaxWeight}
    local chestWeight = 0 
        if chestitems then
            for k,v in pairs(chestitems) do
                local item_name = vRP.getItemName(k)
                local itemWeight = vRP.getItemWeight(k)

                chestWeight = chestWeight + itemWeight*v.amount
                table.insert(chest,
                    {
                        name = item_name,
                        amount = v.amount,
                        icon = items[k][5],
                        item_peso = itemWeight,
                        idname = k,
                        type = items[k][6],
                    }
                )  
            end
        end    

    if data and data.inventory then
        local inventory = {}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Pega itens do inventory
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------           
        for data_k, data_v in pairs(data.inventory) do
            for items_k, items_v in pairs(items) do
                if data_k == items_k then
                    local item_name = vRP.getItemName(data_k)
                    local itemWeight = vRP.getItemWeight(data_k)
                        if item_name then
                            table.insert(inventory,
                                {
                                    name = item_name,
                                    amount = data_v.amount,
                                    item_peso = itemWeight,
                                    idname = data_k,
                                    icon = items_v[5],
                                    type = items_v[6]
                                }
                            )
                    end
                end
            end
        end
        local weight = vRP.getInventoryWeight(user_id)
        local maxWeight = vRP.getInventoryMaxWeight(user_id)
        IClient.updateGui( source, inventory, weight, maxWeight, chest, chestWeight, chestMaxWeight)
    end
end


local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
burglary = Tunnel.getInterface("vrp_robhome")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local DoingBreak = false                
local stealing = false                     
local roubando = false 
local text = "~g~[G]~w~ DESTRANCAR" 
local insideText = "~g~[G]~w~ SAIR" 
local searchText = "~g~[G]~w~ PROCURAR" 
local emptyMessage3D = "VAZIO" 
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS CASAS
-----------------------------------------------------------------------------------------------------------------------------------------
local burglaryPlaces = {
    ["Casa 1"] = {
        pos = { x = 1229.1, y = -725.47, z = 60.80, h = 89.98 },  
        locked = true,
        inside = { x = 346.52 , y = -1013.19 , z = -99.2, h = 357.81 }, 
        animPos = { x = 1229.53, y = -724.81, z = 60.96, h = 277.96 },   
    }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS ITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local burglaryInside = {
    ["Maquiagem"] = { x = 342.23, y = -1003.29, z = -99.0, item = 'maquiagemroubada', amount = math.random(1,2)},
    ["Carregador"]  = {x = 338.14, y = -997.69, z = -99.2, item = 'carregadorroubado', amount = math.random(1,2)},
    ["Aliança"] = { x = 350.91 , y = -999.26 , z = -99.2, item = 'alianca', amount = math.random(1,2)},
    ["Isca"] = { x = 349.19, y = -994.83, z = -99.2, item = 'isca', amount = math.random(1,2)},
    ["Tablet"]  = { x = 345.3, y = -995.76, z = -99.2, item = 'tabletroubado', amount = math.random(1,2)},
    ["Kit de Reparo"] = { x = 346.14, y = -1001.55, z = -99.2, item = 'repairkit', amount = math.random(1,2)},
    ["Taco de Beisebol"] = { x = 347.23, y = -994.09, z = -99.2, item = 'wbody|WEAPON_BAT', amount = math.random(1,2)},
    ["Vibrador"] = { x = 339.23, y = -1003.35, z = -99.2, item = 'vibradorroubado', amount = math.random(1,2)}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBO ANDAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------                                   
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(5)
        for k,v in pairs(burglaryPlaces) do
            local playerPed = PlayerPedId()
            local house = k
            local coords = GetEntityCoords(playerPed)
            local dist   = GetDistanceBetweenCoords(v.pos.x, v.pos.y, v.pos.z, coords.x, coords.y, coords.z, false)
            if dist <= 1.2 and not DoingBreak then
                if v.locked then
                	DrawText3D(v.pos.x, v.pos.y, v.pos.z+0.5, text) 
                	if IsControlJustPressed(0, 58) then
                        burglary.Timer(house)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while stealing == false do
      Citizen.Wait(5)
        for k,v in pairs(burglaryInside) do
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local dist   = GetDistanceBetweenCoords(v.x, v.y, v.z, coords.x, coords.y, coords.z, false)
            if dist <= 1.2 and v.amount > 0 and roubando then
                DrawText3D(v.x, v.y, v.z+0.5, searchText)
                if dist <= 0.5 and IsControlJustPressed(0, 58) then
                    PlayerRoubando(k)
                end
                elseif v.amount < 1 and dist <= 1.2 and roubando then
                DrawText3D(v.x, v.y, v.z+0.5, emptyMessage3D)
                if IsControlJustPressed(0, 58) and dist <= 0.5 then 
                    TriggerEvent("Notify","aviso","Este compartimento está <b>Vazio</b>!")
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(5)
        for k,v in pairs(burglaryPlaces) do
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local house = k
            if GetDistanceBetweenCoords(v.inside.x, v.inside.y, v.inside.z, coords.x, coords.y, coords.z, false) <= 3.0 and roubando then
                DrawText3D(v.inside.x, v.inside.y, v.inside.z+0.5, insideText)
                if GetDistanceBetweenCoords(v.inside.x, v.inside.y, v.inside.z, coords.x, coords.y, coords.z, false) <= 1.2 and IsControlJustPressed(0, 58) and roubando then
                    Fade()
                    Teleport(house)
                    v.locked = true
                    roubando = false 
                    VisiblePlayer()
                end
            end
        end 
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇOES
-----------------------------------------------------------------------------------------------------------------------------------------
function PlayerRoubando(k)
	RequestAnimSet("move_ped_crouched")
    RequestAnimSet("move_ped_crouched_strafing")
    local values = GetHouseValues(k, burglaryInside)
    local playerPed = PlayerPedId()
    vRP._playAnim(false,{{"oddjobs@shop_robbery@rob_till", "loop"}},true)
    stealing = true
    FreezeEntityPosition(playerPed, true)
    TriggerEvent("cancelando",true)
    Citizen.Wait(1000)
    Procent(5,"roubando")
    if values.amount >= 2 then
        TriggerServerEvent('robhome:getitem', values.item, values.amount)
        TriggerEvent("Notify","sucesso","Voce roubou <b>"..values.amount.."x "..k.."</b>!")
        values.amount = values.amount - values.amount
    else
        TriggerServerEvent('robhome:getitem', values.item, 1)
        TriggerEvent("Notify","sucesso","Voce roubou <b>1x "..k.."</b>!")
        values.amount = values.amount - 1
    end
    Wait(300)
    vRP._stopAnim(false)
    TriggerEvent("cancelando",false)
    ResetPedMovementClipset(playerPed,0.55)
    FreezeEntityPosition(playerPed, false)
    stealing = false
end

RegisterNetEvent('Burglary:HouseBreak')
AddEventHandler('Burglary:HouseBreak', function(house,segundos)
	local random = math.random(100)
	local random2 = math.random(100)
	local random3 = math.random(100)
    local v = GetHouseValues(house, burglaryPlaces)
    local playerPed = PlayerPedId()
    Fade()
    DoingBreak = true
    TriggerEvent("cancelando",true)
    FreezeEntityPosition(playerPed, true)
    SetEntityCoords(playerPed, v.animPos.x, v.animPos.y, v.animPos.z - 0.98)
    SetEntityHeading(playerPed, v.animPos.h)
    LoadDict("mini@safe_cracking")
    TaskPlayAnim(playerPed, "mini@safe_cracking", "idle_base", 3.5, -8, -1, 2, 0, 0, 0, 0, 0)
    TriggerEvent("vrp_sound:source",'lockpick',0.7)
    Procent(8,"invadindo")
    if random > 40 then
        Fade()
        TriggerEvent("Notify","sucesso","Voce <b>destrancou</b>, a porta e conseguiu <b>invadir</b> a residencia!")
        ClearPedTasks(playerPed)
        FreezeEntityPosition(playerPed, false)
        SetCoords(playerPed, v.inside.x, v.inside.y, v.inside.z - 0.98)
        SetEntityHeading(playerPed, v.inside.h)
        DontVisiblePlayer()
        TriggerEvent("cancelando",false)
        v.locked = false
        segundos = 300
        roubando = true
        if random3 < 20 then
        	TriggerServerEvent('robhome:tryitem', 'lockpick', 1)
        	TriggerEvent("Notify","aviso","No processo de <b>destrancar</b>, voce acabou perdendo a sua <b>LockPick</b>!")
        end
        SetTimeout(30000,function()
        	if random2 < 30 then
        	    burglary.callPoliceBank(v.pos.x, v.pos.y, v.pos.z)
        	    TriggerEvent("Notify","importante","O morador da casa descobriu e ligou para a <b>Polícia</b>, roube os itens e <b>fuja</b> o quanto antes!")
        	end
        end)
    else
    	burglary.callPoliceBank(v.pos.x, v.pos.y, v.pos.z)
    	TriggerServerEvent('robhome:tryitem', 'lockpick', 1)
    	TriggerEvent("Notify","aviso","Voce nao conseguiu <b>destrancar</b> a porta, a <b>Polícia</b> foi acionada, <b>fuja</b> o quanto antes!!")
    	ClearPedTasks(playerPed)
        FreezeEntityPosition(playerPed, false)
        TriggerEvent("cancelando",false)
    	v.locked = true
        segundos = 0
        roubando = false
    end
end)

function SetCoords(playerPed, x, y, z)
    SetEntityCoords(playerPed, x, y, z)
    Citizen.Wait(100)
    SetEntityCoords(playerPed, x, y, z)
end

function Fade()
    DoScreenFadeOut(1000)
    Citizen.Wait(2000)
    DoScreenFadeIn(1000)
end

function LoadDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end
  
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.37, 0.37)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 88)
end

function Procent(time,texto)
    TriggerEvent("progress",time*1000,texto)      
    Citizen.Wait(time*1000)
end

function Teleport(house)
    local values = GetHouseValues(house, burglaryPlaces)
    local playerPed = PlayerPedId()
    SetCoords(playerPed, values.pos.x, values.pos.y, values.pos.z - 0.98)
    SetEntityHeading(playerPed, values.pos.h)
    DoingBreak = false
end

function GetHouseValues(house, pair)
    for k,v in pairs(pair) do
        if k == house then
            return v
        end
    end
end

function DontVisiblePlayer()
    for _, player in ipairs(GetActivePlayers()) do
        local playerId = PlayerPedId()
        local playersIds = GetPlayerPed(player)
        if playerId ~= playersIds then
            SetEntityVisible(playersIds, false)
            SetEntityNoCollisionEntity(playerId, playersIds, true)
        end
    end
end

function VisiblePlayer()
    for _, player in ipairs(GetActivePlayers()) do
        local playerId = PlayerPedId()
        local playersIds = GetPlayerPed(player)
        if playerId ~= playersIds then
            SetEntityVisible(playersIds, true)
            SetEntityCollision(playerId, true)
        end
    end
end
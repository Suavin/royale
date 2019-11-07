local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_inventario")

src = {}
Tunnel.bindInterface("vrp_inventario",src)
Proxy.addInterface("vrp_inventario",src)
IServer = Tunnel.getInterface("vrp_inventario")

local show = false
local temp_inventory = nil
local temp_weight = nil
local temp_maxWeight = nil
local cooldown = 0

function openGui(inventory, weight, maxWeight,equipado)
  if show == false then
    show = true
    local progressinv = weight/maxWeight*100
    TriggerEvent("status:inventario",true)
    Wait(80)
    SetNuiFocus(true, true)
    SendNUIMessage(
      {
        show = true,
        inventory = inventory,
        weight = weight,
        maxWeight = maxWeight,
        progressinv = progressinv,
        equipado = equipado
      }
    )
    StartScreenEffect("MenuMGSelectionIn", 0, true)
  end
end

function closeGui()
  TriggerEvent("status:inventario",false)
  StopScreenEffect("MenuMGSelectionIn")
  show = false
  SetNuiFocus(false)
  SendNUIMessage({show = false})
  IServer.closeChest()
end

RegisterNetEvent("vrp_inventario:openGui")
AddEventHandler("vrp_inventario:openGui",function()
  if cooldown > 0 and temp_inventory ~= nil and temp_weight ~= nil and temp_maxWeight ~= nil then
    openGui(temp_inventory, temp_weight, temp_maxWeight)
  else
    TriggerServerEvent("vrp_inventario:openGui")
  end
end)

RegisterNetEvent("vrp_inventario:updateInventory")
AddEventHandler("vrp_inventario:updateInventory",function(inventory, weight, maxWeight, equipado)
    cooldown = Config.AntiSpamCooldown
    temp_inventory = inventory
    temp_weight = weight
    temp_maxWeight = maxWeight
    temp_equipado = equipado
    openGui(temp_inventory, temp_weight, temp_maxWeight,temp_equipado)
end)

RegisterNetEvent("vrp_inventario:UINotification")
AddEventHandler("vrp_inventario:UINotification",function(type, title, message)
    show = true
    SetNuiFocus(true, true)
    SendNUIMessage(
      {
        show = true,
        notification = true,
        type = type,
        title = title,
        message = message
      }
    )
end)

RegisterNetEvent("vrp_inventario:closeGui")
AddEventHandler("vrp_inventario:closeGui",function()
  closeGui()
end)

RegisterNetEvent("vrp_inventario:objectForAnimation")
AddEventHandler("vrp_inventario:objectForAnimation",function(type)
    local ped = PlayerPedId()
    DeleteObject(object)
    bone = GetPedBoneIndex(ped, 60309)
    coords = GetEntityCoords(ped)
    modelHash = GetHashKey(type)

    RequestModel(modelHash)
    object = CreateObject(modelHash, coords.x, coords.y, coords.z, true, true, false)
    AttachEntityToEntity(object, ped, bone, 0.1, 0.0, 0.0, 1.0, 1.0, 1.0, 1, 1, 0, 0, 2, 1)
    Citizen.Wait(2500)
    DeleteObject(object)
end)

RegisterNUICallback("close",function()
    closeGui()
end)

RegisterNUICallback("useItem",function(data)
    cooldown = 0
    closeGui()
    TriggerServerEvent("vrp_inventario:useItem", data)
end)

RegisterNUICallback("dropItem",function(data)
    cooldown = 0
    closeGui()
    TriggerServerEvent("vrp_inventario:dropItem", data)
end)

RegisterNUICallback("garmas",function(data)
    cooldown = 0
    closeGui()
    TriggerServerEvent("vrp_inventario:garmas")
end)

RegisterNUICallback("giveItem",function(data)
    cooldown = 0
    closeGui()
    TriggerServerEvent("vrp_inventario:giveItem", data)
end)

RegisterCommand("inventory",function(source, args)
    TriggerEvent("vrp_inventario:openGui")
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlPressed(0, Config.OpenMenu) then
      TriggerEvent("vrp_inventario:openGui")
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if cooldown > 0 then 
      cooldown = cooldown - 1
    end
  end
end)



AddEventHandler("onResourceStop",function(resource)
    if resource == GetCurrentResourceName() then
      closeGui()
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- BEBIDAS ENERGETICAS
-----------------------------------------------------------------------------------------------------------------------------------------
local energetico = false
RegisterNetEvent('energeticos')
AddEventHandler('energeticos',function(status)
  energetico = status
  if energetico then
    SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
  else
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if energetico then
      RestorePlayerStamina(PlayerId(),1.0)
    end
  end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- Chests
-----------------------------------------------------------------------------------------------------------------------------------------
function src.openChest(inventory, weight, maxWeight, chest, chestWeight, chestMaxWeight)
  if show == false then
    show = true
    TriggerEvent("status:inventario",true)
    Wait(80)
    local progresschest = chestWeight/chestMaxWeight*100
    local progressinv = weight/maxWeight*100
    SetNuiFocus(true, true)
    SendNUIMessage(
      {
        show = "chest",
        inventory = inventory,
        weight = weight,
        maxWeight = maxWeight,
        progressinv = progressinv,
        chest = chest,
        chestWeight = chestWeight,
        chestMaxWeight = chestMaxWeight,
        progresschest = progresschest

      }
    )
    StartScreenEffect("MenuMGSelectionIn", 0, true)
  end
end

function src.updateGui(inventory, weight, maxWeight, chest, chestWeight, chestMaxWeight)
  show = true
  local progresschest = chestWeight/chestMaxWeight*100
  local progressinv = weight/maxWeight*100

  SetNuiFocus(true, true)
  SendNUIMessage(
    {
      show = "chest",
      inventory = inventory,
      weight = weight,
      maxWeight = maxWeight,
      progressinv = progressinv,
      chest = chest,
      chestWeight = chestWeight,
      chestMaxWeight = chestMaxWeight,
      progresschest = progresschest

    }
  )
end

RegisterNUICallback("takeItem",function(data)
    cooldown = 0
    IServer.takeItem(data)
end)

RegisterNUICallback("putItem",function(data)
    cooldown = 0
    IServer.putItem(data)
end)



function Draw3DText(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = 0.25
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(1, 1, 0, 0, 255)
        SetTextEdge(0, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(2)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end


-----------------------------------------------------------------------------------------------------------------------------------------
--Dorgas
-----------------------------------------------------------------------------------------------------------------------------------------
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
function src.playScreenEffect(name, duration)
  if duration < 0 then -- loop
    StartScreenEffect(name, 0, true)
  else
    StartScreenEffect(name, 0, true)

    Citizen.CreateThread(function() -- force stop the screen effect after duration+1 seconds
      Citizen.Wait(math.floor((duration+1)*1000))
      StopScreenEffect(name)
    end)
  end
end

-- stop a screen effect
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
function src.stopScreenEffect(name)
  StopScreenEffect(name)
end

-- MOVEMENT CLIPSET
function src.playMovement(clipset,blur,drunk,fade,clear)
  --request anim
  RequestAnimSet(clipset)
  while not HasAnimSetLoaded(clipset) do
    Citizen.Wait(0)
  end
  -- fade out
  if fade then
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
  end
  -- clear tasks
  if clear then
    ClearPedTasksImmediately(PlayerPedId())
  end
  -- set timecycle
  SetTimecycleModifier("spectator5")
  -- set blur
  if blur then 
    SetPedMotionBlur(PlayerPedId(), true) 
  end
  -- set movement
  SetPedMovementClipset(PlayerPedId(), clipset, true)
  -- set drunk
  if drunk then
    SetPedIsDrunk(PlayerPedId(), true)
  end
  -- fade in
  if fade then
    DoScreenFadeIn(1000)
  end
  
end

function src.resetMovement(fade)
  -- fade
  if fade then
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
  end
  -- reset all
  ClearTimecycleModifier()
  ResetScenarioTypesEnabled()
  ResetPedMovementClipset(PlayerPedId(), 0)
  SetPedIsDrunk(PlayerPedId(), false)
  SetPedMotionBlur(PlayerPedId(), false)
end


-----------------------------------------------------------------------------------------------------------------------------------------
--Mochila
-----------------------------------------------------------------------------------------------------------------------------------------

local prop 
function src.vestirMochila(mochila)
 
end

function src.tirarMochila(mochila)

end

RegisterNetEvent("vrp_inventario:tiraMochila")
AddEventHandler("vrp_inventario:tiraMochila",function(mochila)

end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('bandagem')
AddEventHandler('bandagem',function()
  repeat
    SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())+1)
    Citizen.Wait(600)
  until GetEntityHealth(PlayerPedId()) >= 400 or GetEntityHealth(PlayerPedId()) <= 100
    TriggerEvent("Notify","sucesso","Tratamento concluido.")
end)
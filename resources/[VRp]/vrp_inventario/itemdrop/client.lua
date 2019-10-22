--[[-----------------
	vRP_itemdrop By XanderWP from Ukraine with <3
------------------------]]--

local KeyMarker = {1, 38}

local text_take = 'Pegar Item no chão ~INPUT_PICKUP~'


local dropList = {}
local Bagcoords = {}
local Bagitem = {}
function scenrionahoi(text)
	SetTextComponentFormat('STRING')
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, false, false, -1)
end


RegisterNetEvent('DropSystem:drop')
AddEventHandler('DropSystem:drop', function(item, amount)
  local bag , coords = SetBagOnGround()
  TriggerServerEvent('DropSystem:create', bag, item, amount,coords)
end)

RegisterNetEvent('DropSystem:remove')
AddEventHandler('DropSystem:remove', function(bag)
  if dropList[bag] ~= nil then
    dropList[bag] = nil
    Bagcoords[bag] = nil
    Bagitem[bag] = nil
  end
  DeleteBag(Bag)
end)

RegisterNetEvent('DropSystem:createForAll')
AddEventHandler('DropSystem:createForAll', function(bag,coords,item)
  dropList[bag] = true
  Bagcoords[bag] = {coords , item} 


end)

function SetBagOnGround()
  x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
  Bag = GetHashKey("prop_paper_bag_small")
  RequestModel(Bag)
  while not HasModelLoaded(Bag) do
    Citizen.Wait(1)
  end
  local object = CreateObject(Bag, x, y, z-2, true, true, true) -- x+1
  PlaceObjectOnGroundProperly(object)
  local network = NetworkGetNetworkIdFromEntity(object)
  local coords = table.pack(x, y, z)
  return network, coords
end

local cooldown = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local ped = PlayerPedId()
    local pedCoord = GetEntityCoords(ped)

    for k,v in pairs(dropList) do
      if DoesObjectOfTypeExistAtCoords(pedCoord["x"], pedCoord["y"], pedCoord["z"], 1.3, GetHashKey("prop_paper_bag_small"), true) then
        Bag = GetClosestObjectOfType(pedCoord["x"], pedCoord["y"], pedCoord["z"], 1.3, GetHashKey("prop_paper_bag_small"), false, false, false)
        if NetworkGetNetworkIdFromEntity(Bag) == k then
          scenrionahoi(text_take)
          if IsControlJustPressed(table.unpack(KeyMarker)) and not cooldown then
             cooldown = true
             TriggerServerEvent('DropSystem:take', k)
             PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
             SetTimeout(3000,function()
              cooldown = false
            end)
          end
        end
      end
    end
  end
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    for k,v in pairs(Bagcoords) do
      local ped = PlayerPedId()
      local pedCoord = GetEntityCoords(ped)
      local gix, giy, giz = table.unpack(v[1])
      local item = v[2]
      local opacidade = math.floor(255 - (GetDistanceBetweenCoords(gix, giy, giz-1.6,GetEntityCoords(ped),true) * 40))
      local opacidade2 = math.floor(255 - (GetDistanceBetweenCoords(gix, giy, giz-0.15,GetEntityCoords(ped),true) * 2))

      if GetDistanceBetweenCoords(pedCoord, gix, giy, giz, true) < 80 then
         DrawMarker(21, gix, giy, giz-0.15, 0, 0, 0, 0, 180.00, 0, 0.5, 0.5, 0.5, 255, 255, 255, opacidade2, 1, 1, 2, 0, 0, 0, 0)
      end
      if GetDistanceBetweenCoords(pedCoord, gix, giy, giz, true) < 6 then
         draw3DText(gix, giy, giz-1.6,item, 4, 0.12, 0.12, 255, 255, 255, opacidade)
      end
    end
  end
end)

function DeleteBag(Bag)
  SetEntityAsMissionEntity(Bag, true, true)
  DeleteObject(Bag)
end

function draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, opacidade)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

  local scale = (1/dist)*10
  local fov = (1/GetGameplayCamFov())*100
  local scale = scale*fov

  SetTextScale(scaleX*scale, scaleY*scale)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(r, g, b, opacidade)
  SetTextDropshadow(0, 0, 0, 0, 5)
  SetTextEdge(2, 0, 0, 0, 150)
  SetTextDropShadow()
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(textInput)
  SetDrawOrigin(x,y,z+2, 0)
  DrawText(0.0, 0.0)
  ClearDrawOrigin()
end
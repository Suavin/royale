-- Made by FAXES, Based off HRC
AddEventHandler('onClientMapStart', function()
  Citizen.CreateThread(function()
    local display = true

    TriggerEvent('logo:display', true)
  end)
end)

RegisterNetEvent('logo:display')
AddEventHandler('logo:display', function(value)
  SendNUIMessage({
    type = "logo",
    display = value
  })
end)

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, state, 0, -1)
end


Citizen.CreateThread(function()
  while true do
      Citizen.Wait(100)
      if IsPauseMenuActive() then
         value = false
      else
         value = true
      end
      SendNUIMessage({
        type = "logo",
        display = value
      })
  end
end)

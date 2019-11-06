inMenu			= true
local showblips	= true
local atbank	= false
local bankMenu	= false
local banks = {
	{name="Banco", id=108, x=150.0858001709, y=-1040.8828125, z=29.374099731445},
	{name="Banco", id=108, x=-1212.980, y=-330.841, z=37.787},
	{name="Banco", id=108, x=-2962.582, y=482.627, z=15.703},
	{name="Banco", id=108, x=-112.202, y=6469.295, z=31.626},
	{name="Banco", id=108, x=314.36166381836, y=-279.14218139648, z=54.170803070068},
	{name="Banco", id=108, x=-350.8317565918, y=-49.933055877686, z=49.042591094971},
	{name="Banco", id=108, x=236.8239440918, y=217.51049804688, z=106.28676605225},
	{name="Banco", id=108, x=1175.0643310547, y=2706.6435546875, z=38.094036102295},
	{name="Banco", id=108, x=-1075.2326660156, y=-2558.51171875, z=3.967668533325}
}	

local atms = {
	{name="ATM", id=277, x=-386.733, y=6045.953, z=31.501}
	
}

--===============================================
--==             Core Threading                ==
--===============================================
if bankMenu then
	Citizen.CreateThread(function()
	while true do
	Wait(0)
	if nearBank() or nearATM() then
	DisplayHelpText("Pressione ~INPUT_PICKUP~ para acessar o Banco")
	if IsControlJustPressed(1, 38) then
	inMenu = true
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openGeneral'})
	TriggerServerEvent('bank:balance')
	local ped = GetPlayerPed(-1)
	end
	end
	if IsControlJustPressed(1, 322) then
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'close'})
	end
	end
	end)
end

--===============================================
--==             Map Blips	                   ==
--===============================================
Citizen.CreateThread(function()
	if showblips then
	for k,v in ipairs(banks)do
	local blip = AddBlipForCoord(v.x, v.y, v.z)
	SetBlipSprite(blip, v.id)
	SetBlipScale(blip, 0.4)
	SetBlipAsShortRange(blip, true)
	if v.principal ~= nil and v.principal then
	SetBlipColour(blip, 77)
	end
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(tostring(v.name))
	EndTextCommandSetBlipName(blip)
	end
	end
end)

--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance)
	local id = PlayerId()
	local playerName = GetPlayerName(id)
	
	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName
		})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('bank:deposit', tonumber(data.amount))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('bank:withdraw', tonumber(data.amountw))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('bank:transfer', data.to, data.amountt)
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Result   Event                    ==
--===============================================
RegisterNetEvent('bank:result')
AddEventHandler('bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)


--===============================================
--==            Capture Bank Distance          ==
--===============================================
function nearBank()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(banks) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 1.5 then
			return true
		end
	end
end

function nearATM()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(atms) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 0.4 then
			return true
		end
	end
end


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
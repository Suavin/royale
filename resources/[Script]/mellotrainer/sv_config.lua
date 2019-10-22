
local localSaving = false

local steamOnly = false

local adminOnlyTrainer = true

local adminOnlyNoclip = true

local admins = {
	"license:2f6fd549d134eb59613691b01402db8e7b365b28",  -- Doug
    "license:c0e783684eab2dba07b09f3de9e81d93da659b29",  -- Bigode
	"license:8c561ef385cecc526b23e6e5aa3df03fe20b73b0",  -- Koolf
	"license:3fdbed16c06ec9cb3d37168f3779c6b25deb195e",  -- Nay
	"license:3a47bd4f197fa9f6102d044672c258366d27a0b2",  -- Snop
	"license:12389ef5a855a69380ae7d9f5502507d7ea4de77",	-- Hertz
	"license:48571c9b0ed07960b925b1301dabcd8f5bb11071",	-- Andrei
    "license:45d18fa2d3541cde4bc32cb1a2d4b8495ffef1e7"  -- PK
}

--local pvpEnabled = true
--local maxPlayers = 32

Config = {}
Config.settings = {
	--pvpEnabled = pvpEnabled,
	--maxPlayers = maxPlayers,

	adminOnlyTrainer = adminOnlyTrainer,
	admins = admins,
	localSaving = localSaving, 
	steamOnly = steamOnly,
	adminOnlyNoclip = adminOnlyNoclip
}


-- Get Setting from Config.settings
RegisterServerEvent("mellotrainer:getConfigSetting")
AddEventHandler("mellotrainer:getConfigSetting",function(stringname)
	local value = Config.settings[stringname]
	TriggerClientEvent("mellotrainer:receiveConfigSetting", source, stringname, value)
end)

local Users = {}
-- Called whenever someone loads into the server. Users created in variables.lua
RegisterServerEvent('mellotrainer:firstJoinProper')
AddEventHandler('mellotrainer:firstJoinProper', function(id)
	local identifiers = GetPlayerIdentifiers(source)
	for i = 1, #identifiers do
		if(Users[source] == nil)then
			Users[source] = {
				name = GetPlayerName(source),
				source = id
			}
		end
	end

	TriggerClientEvent('mellotrainer:playerJoined', -1, id)
	TriggerClientEvent("mellotrainer:receiveConfigSetting", source, "adminOnlyTrainer", Config.settings.adminOnlyTrainer)
	TriggerClientEvent( "mellotrainer:receiveConfigSetting", source, "localSaving", Config.settings.localSaving )
	TriggerClientEvent( "mellotrainer:receiveConfigSetting", source, "adminOnlyNoclip", Config.settings.adminOnlyNoclip )


	-- If local saving is turned on then ensure files are created for this person.
	if(Config.settings.localSaving)then
		DATASAVE:AddPlayerToDataSave(source)
	end
end)


-- Remove User on playerDropped.
AddEventHandler('playerDropped', function()
	if(Users[source])then
		TriggerClientEvent('mellotrainer:playerLeft', -1, Users[source])
		Users[source] = nil
	end
end)

-- Admin Managment
local adminList = Config.settings.admins


-- Is identifier in admin list?
function isAdmin(identifier)
	local adminList = {}
	for _,v in pairs(admins) do
		adminList[v] = true
	end
	identifier = string.lower(identifier)
	identifier2 = string.upper(identifier)

	if(adminList[identifier] or adminList[identifier2])then
		return true
	else
		return false
	end
end

RegisterServerEvent("mellotrainer:isAdmin")
AddEventHandler("mellotrainer:isAdmin",function()
	local identifiers = GetPlayerIdentifiers(source)
	local found = false
	for i=1,#identifiers,1 do
		if(isAdmin(identifiers[i]))then
			TriggerClientEvent("mellotrainer:adminstatus",source,true)
			found = true
			break
		end
	end
	if(not found)then
		TriggerClientEvent("mellotrainer:adminstatus",source,false)
	end
end)

RegisterServerEvent("mellotrainer:getAdminStatus")
AddEventHandler("mellotrainer:getAdminStatus",function()
	local identifiers = GetPlayerIdentifiers(source)
	local found = false
	for i=1,#identifiers,1 do
		if(isAdmin(identifiers[i]))then
			found = true
			break
		end
	end
	TriggerClientEvent("mellotrainer:adminStatusReceived",source,found)
end)


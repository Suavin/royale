local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
RadarL = {}
Tunnel.bindInterface("vrp_radar",RadarL)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADAR
-----------------------------------------------------------------------------------------------------------------------------------------
local tempo = false
function RadarL.checarMulta(valor)
	local user_id = vRP.getUserId(source)
	if not tempo then
	    local value = vRP.getUData(user_id,"vRP:multas")
	    local multas = json.decode(value) or 0
	    vRP.setUData(user_id,"vRP:multas",json.encode(parseInt(multas)+parseInt(valor)))
	    tempo = true
	    SetTimeout(1000,function()
			tempo = false
		end)
	end
end

function RadarL.checarOrgs()
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,"Paramedico") then
        return true
    elseif vRP.hasGroup(user_id,"Policia") then
        return true
    end
    elseif vRP.hasGroup(user_id,"PoliciaNorte") then
        return true
    end
    return false
end


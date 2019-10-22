--[[--------------------------------------------------------------------------
	*
	* Mello Trainer
	* (C) Michael Goodwin 2017
	* http://github.com/thestonedturtle/mellotrainer/releases
	*
	* This menu used the Scorpion Trainer as a framework to build off of.
	* https://github.com/pongo1231/ScorpionTrainer
	* (C) Emre Cürgül 2017
	* 
	* A lot of useful functionality has been converted from the lambda menu.
	* https://lambda.menu
	* (C) Oui 2017
	*
	* Additional Contributors:
	* WolfKnight (https://forum.fivem.net/u/WolfKnight)
	*
---------------------------------------------------------------------------]]

_VERSION = '0.5.5'

--[[------------------------------------------------------------------------
	Version Check 
	Credits to EssentialMode 
------------------------------------------------------------------------]]--
PerformHttpRequest( "https://thestonedturtle.github.io/mellotrainer/version", function( err, text, headers )
	Citizen.Wait( 1000 ) -- just to reduce clutter in the console on startup 
	RconPrint( "\nVersão atual do CHICAGOADMIN:" .. _VERSION)
	RconPrint( "\nVersão mais recente do CHICAGOADMIN: " .. text)
	
	if ( text ~= _VERSION ) then
		RconPrint( "\n\n\t|||||||||||||||||||||||||||||||||\n\t||  O CHICAGOADMIN está desatualizado   ||\n\t|| Baixe a última versão ||\n\t||    Dos fóruns da FiveM    ||\n\t|||||||||||||||||||||||||||||||||\n\n" )
	else
		RconPrint( "\nO CHICAGOADMIN está atualizado!\n" )
	end
end, "GET", "", { what = 'this' } )


--[[------------------------------------------------------------------------
	Steam Only Connection 
------------------------------------------------------------------------]]--
AddEventHandler( 'playerConnecting', function( name, cb )
	if ( Config.settings.steamOnly ) then 
		local id = DATASAVE:GetIdentifier( source, "steam" )

		if ( id == nil ) then 
			cb( "Este servidor requer que você esteja logado no cliente Steam." )
			CancelEvent()
		end 
	end 
end )
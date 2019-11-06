-------------- DISCORD  -----------------------------
-----------------------------------------------------
local randomPlayers = math.random(10,40)

Citizen.CreateThread(function()
    while true do
        SetDiscordAppId(574411587759374338)
        SetDiscordRichPresenceAsset('logodiscordsnn')
        SetDiscordRichPresenceAssetText('ROYALE ROLEPLAY')
        SetDiscordRichPresenceAssetSmallText('ROYALE ROLEPLAY')
        Citizen.Wait(30000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(25000)
        players = {}
        for i = 0, 256 do
            if NetworkIsPlayerActive( i ) then
                table.insert( players, i )
            end
        end
        SetRichPresence("Jogadores : "..#players.."/64")
       -- SetRichPresence(GetPlayerName(PlayerId()) .. " - ".. math.random(10,40) .. " / 128")
    end
end)
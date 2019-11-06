local weatherType = "CLOUDS"

Citizen.CreateThread(function()
    while true 
    do        
    	SetWeatherTypePersist(weatherType)
    	SetWeatherTypeNowPersist(weatherType)
    	SetWeatherTypeNow(weatherType)
    	SetOverrideWeather(weatherType)
    	NetworkOverrideClockTime(0, 00, 00)
    	SetClockTime(0, 0, 0)
    	PauseClock(false)
    	Citizen.Wait(0)
    end
end)
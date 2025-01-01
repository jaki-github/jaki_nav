Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)

            local streetHash, crossingHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            local streetName = GetStreetNameFromHashKey(streetHash)
            local crossingName = GetStreetNameFromHashKey(crossingHash)
            local zoneName = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))

            if streetName == "" then
                streetName = "Unknown"
            end

            if crossingName == "" then
                crossingName = "Unknown"
            end

            local directions = {"N", "NE", "E", "SE", "S", "SW", "W", "NW"}
            local directionIndex = math.floor((heading + 22.5) / 45.0) % 8 + 1
            local direction = directions[directionIndex]
            SendNUIMessage({
                street = streetName,
                crossing = crossingName,
                zone = zoneName,
                direction = direction,
                show = true 
            })
        else
            SendNUIMessage({
                show = false
            })
        end
    end
end)

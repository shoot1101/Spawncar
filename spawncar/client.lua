
Citizen.CreateThread(function()
    -- Parked vehicles.
    local vehicles = {
        -- ETAGE1
        {Model= "scheisser", X= -333.45, Y= -1357.66, Z= 31.8, A= 228.15, Color = {255, 0, 0}}, -- Red color
        {Model= "sunrise1", X= -319.5, Y= -1360.24, Z= 31.8, A= 144.94, Color = {0, 255, 0}},  -- Green color
        {Model= "arias", X= -319.77, Y= -1381.86, Z= 31.8, A= 41.59, Color = {0, 0, 255}},    -- Blue color
        {Model= "jestgpr", X= -332.19, Y= -1380.43, Z= 31.8, A= 331.52, Color = {255, 255, 0}}, -- Yellow color
    }

    -- Load models
    for _, item in pairs(vehicles) do
        RequestModel(GetHashKey(item.Model))
    end

    -- Wait for models to load
    local waiting = true
    while waiting do
        waiting = false
        for _, item in pairs(vehicles) do
            if not HasModelLoaded(GetHashKey(item.Model)) then
                waiting = true
                Wait(50)
                break
            end
        end
    end

    -- Spawn vehicles
    for _, item in pairs(vehicles) do
        local vehicle = CreateVehicle(GetHashKey(item.Model), item.X, item.Y, item.Z, item.A, false, false)
        SetVehicleOnGroundProperly(vehicle)
        SetVehicleDoorsLocked(vehicle, 2)
        SetVehicleWheelSize(vehicle, 0.5)
        SetVehicleLights(vehicle, 2)
        SetVehicleNumberPlateText(vehicle, "IMPORT")
        SetVehicleDirtLevel(vehicle)
        SetVehicleEngineOn(vehicle, false, false, false)

        -- Set custom colors if provided
        if item.Color then
            SetVehicleCustomPrimaryColour(vehicle, item.Color[1], item.Color[2], item.Color[3])
            SetVehicleCustomSecondaryColour(vehicle, item.Color[1], item.Color[2], item.Color[3])
        end

        -- Enable neon lights
        for i = 0, 3 do
            SetVehicleNeonLightEnabled(vehicle, i, true)
        end
    end
end)
local animationDict = "pickup_object"
local animation = "pickup_low"

local function LoadModel(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end

local function LoadAnimationDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

local function RequestNetworkControlOfObject(netId, itemEntity)
    if NetworkDoesNetworkIdExist(netId) then
        NetworkRequestControlOfNetworkId(netId)
        while not NetworkHasControlOfNetworkId(netId) do
            Wait(100)
            NetworkRequestControlOfNetworkId(netId)
        end
    end

    if DoesEntityExist(itemEntity) then
        NetworkRequestControlOfEntity(itemEntity)
        while not NetworkHasControlOfEntity(itemEntity) do
            Wait(100)
            NetworkRequestControlOfEntity(itemEntity)
        end
    end
end

-- Returns a table containing the metadata for the given bike entity
---@param bikeEntity - The entity of the bike to get the metadata for
---@return table - The metadata of the bike {plate, colorPrimary, colorSecondary, pearlescentColor, wheelColor, xenonColor}
local function getBikeMetadata(bikeEntity)
    local bikePlate = GetVehicleNumberPlateText(bikeEntity)
    local colorPrimary, colorSecondary = GetVehicleColours(bikeEntity)
    local pearlescentColor, wheelColor = GetVehicleExtraColours(bikeEntity)
    local xenonColor = GetVehicleXenonLightsColour(bikeEntity)

    return {
        plate = bikePlate,
        colorPrimary = colorPrimary,
        colorSecondary = colorSecondary,
        pearlescentColor = pearlescentColor,
        wheelColor = wheelColor,
        xenonColor = xenonColor,
    }
end

-- Sets the bike properties based on the given metadata
---@param bike - The bike entity to set the properties on
---@param bikeMetadata - The metadata of the bike {plate, colorPrimary, colorSecondary, pearlescentColor, wheelColor, xenonColor}
local function setBikeProperties(bike, bikeMetadata)
    local plate = bikeMetadata.plate
    local colorPrimary = bikeMetadata.colorPrimary
    local colorSecondary = bikeMetadata.colorSecondary
    local pearlescentColor = bikeMetadata.pearlescentColor
    local wheelColor = bikeMetadata.wheelColor
    local xenonColor = bikeMetadata.xenonColor

    -- If the bike item info already has a plate, use that otherwise create a new plate. This is important to handle owned bikes.
    if not bikePlate then
        bikePlate = "BICYCLE".. math.random(1000, 9999)
    end
    SetVehicleNumberPlateText(bike, bikePlate)

    SetVehicleColours(bike, colorPrimary, colorSecondary)
    SetVehicleExtraColours(bike, pearlescentColor, wheelColor)

    -- Xenon color is 0-12 if set or 255 if no color set
    if xenonColor ~= 255 then
        ToggleVehicleMod(bike, 22, true)
        SetVehicleXenonLightsColour(bike, xenonColor)
    end
end

-- Handles creating and placing the bike in the world
-- Adds a plate to the bike (either from the item metadata or a random plate) and sets the player as the owner/gives keys
---@param bikeModel string The model of the bike to spawn
---@param bikeItem table The item data of the bike to spawn
RegisterNetEvent('wp-pocketbikes:client:place', function(bikeModel, bikeItem)
    local ped = PlayerPedId()
    local bikePlate = bikeItem.info.plate

    -- Request model and wait until its loaded
    LoadModel(bikeModel)

    ClearPedTasks(ped)
    TaskPlayAnim(ped, animationDict, animation , 8.0, -8.0, -1, 0, 0, false, false, false)

    -- Wait so the animation can play before immediately spawning the bike
    Wait(500)

    -- Spawn the bike in the world with an offset in front of the player and set it on the ground
    local offsetCoords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
    local bike = CreateVehicle(bikeModel, offsetCoords, GetEntityHeading(ped), true, false)
    SetVehicleOnGroundProperly(bike)

    TriggerServerEvent("wp-pocketbikes:server:RemoveItem", bikeModel)

    setBikeProperties(bike, bikeItem.info)
    
    SetModelAsNoLongerNeeded(bikeModel)

    SetPlayerAsOwnerOfVehicleWithPlate(bikePlate)
end)

-- Handles picking up the bike and giving the player the item back
-- Applies metadata onto the item to store the plate and color
---@param data table The data of the bike entity to pick up provided from the target event
RegisterNetEvent('wp-pocketbikes:client:pickup', function(data)
    local ped = PlayerPedId()
    local bikeEntity = data.entity
    local bikeItem = data.itemName
    
    if bikeEntity then
        local bikeEntityModelId = GetEntityModel(bikeEntity)
        local bikeNetId = NetworkGetNetworkIdFromEntity(bikeEntity)
        local bikeMetadata = getBikeMetadata(bikeEntity)

        LoadAnimationDict(animationDict)

        ClearPedTasks(ped)
        TaskPlayAnim(ped, animationDict, animation , 8.0, -8.0, -1, 0, 0, false, false, false)

        TriggerServerEvent("wp-pocketbikes:server:AddItem", bikeItem, bikeMetadata)

        -- Must have network control of entity before being able to delete it
        RequestNetworkControlOfObject(bikeNetId, bikeEntity)

        DeleteEntity(bikeEntity)
    end
end)


-- Setup each bike to be targettable
-- Itemname is in the options so we know which item to give back when picked up
for _, bike in pairs(Config.Bikes) do
    local targetOptions = {
        {
            type = 'client',
            event = "wp-pocketbikes:client:pickup",
            icon = "fas fa-bicycle",
            label = "Pick up bike",
            itemName = bike,
        },
    }

    -- A model can only have one set of options, so if the model is defined twice, only the last one will be used
    -- NOTE: If you have another script that adds target onto these bike models, this may conflict with it.
    --  It can be resolved by combining the targetOptions and calling AddTargetModel one time (either in this script or the other one)
    AddTargetModel(bike, {
        options = targetOptions,
        distance = 2.0
    })
end

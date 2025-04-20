-- IsDuplicityVersion - is used to determine if the function is called by the server or the client (true == from server)

--------------------- SHARED FUNCTIONS ---------------------
local Core = nil
--- @return table Core The core object of the framework
function GetCoreObject()
    if not Core then
        if Config.Framework == "esx" then
            Core = exports["es_extended"]:getSharedObject()
        elseif Config.Framework == "qb" or Config.Framework == "qbx" then
            Core = exports["qb-core"]:GetCoreObject()
        end
    end
    return Core
end

Core = Config.Framework ~= "none" and GetCoreObject() or nil

--- @param text string The text to show in the notification
--- @param notificationType string The type of notification to show ex: 'success', 'error', 'info'
--- @param src - number|nil The source of the player - only required when called from server side
function Notify(text, notificationType, src)
    if IsDuplicityVersion() then
        if Config.Notify == "esx" then
            TriggerClientEvent("esx:showNotification", src, text)
        elseif Config.Notify == "qb" then
            TriggerClientEvent("QBCore:Notify", src, text, notificationType)
        elseif Config.Notify == "ox" then
            TriggerClientEvent("ox_lib:notify", src, {
                description = text,
                type = notificationType,
            })
        end
    else
        if Config.Notify == "esx" then
            Core.ShowNotification(text)
        elseif Config.Notify == "qb" then
            Core.Functions.Notify(text, notificationType)
        elseif Config.Notify == "ox" then
            lib.notify({
                description = text,
                type = notificationType,
            })
        end
    end
end

--- @param source number|nil The source of the player
--- @return table PlayerData The player data of the player
function GetPlayerData(source)
    local Core = GetCoreObject()
    if IsDuplicityVersion() then
        if Config.Framework == "esx" then
            return Core.GetPlayerFromId(source)
        elseif Config.Framework == "qb" then
            return Core.Functions.GetPlayer(source).PlayerData
        elseif Config.Framework == "qbx" then
            return exports.qbx_core:GetPlayer(source).PlayerData
        end
    else
        if Config.Framework == "esx" then
            return Core.GetPlayerData()
        elseif Config.Framework == "qb" then
            return Core.Functions.GetPlayerData()
        elseif Config.Framework == "qbx" then
            return exports.qbx_core:GetPlayerData()
        end
    end
end

-- Takes a prop model and the targetOptions and adds it to the target script so that this prop model is targetable
--- @param modelName string The name of the prop model to target
--- @param targetOptions table The options to pass to the target script
---        ex: targetOptions = { distance = num, options: { offset = { x = 0.0, y = 0.0, z = 0.0 }, rotation = { x = 0.0, y = 0.0, z = 0.0 } , animationDict = "", animationName = "" } }
function AddTargetModel(modelName, targetOptions)
    if IsDuplicityVersion() then return end
    if Config.Target == "qb" then
        exports["qb-target"]:AddTargetModel(modelName, targetOptions)
    elseif Config.Target == "ox" then
        -- ox target expects each option to have a distance on it,
        -- Append the distance value to each option
        for _, option in pairs(targetOptions.options) do
            option.distance = targetOptions.distance
        end
        exports.ox_target:addModel(modelName, targetOptions.options)
    else
        warn("Invalid Config.Target: <" .. tostring(Config.Target) .. ">. Update AddTargetModel in framework.lua.")
    end
end

--------------------- CLIENT FUNCTIONS ---------------------

-- Returns the item metadata
--- @param itemData table The item data from using the item
--- @return table The metadata of the item
function GetItemMetadata(itemData)
    if Config.Inventory == "esx" then
        -- ESX inventory does not support metadata by default, recommended to use ox_inventory instead
        print("GetItemMetadata is missing an implementation in the framework file for esx")
    elseif Config.Inventory == "qb" then
        return itemData.info
    elseif Config.Inventory == "ox" then
        return itemData.metadata
    else
        warn("Invalid Config.Inventory: <" .. tostring(Config.Inventory) .. ">. Update GetItemMetadata in framework.lua.")
    end
end

-- Gives the player keys and sets them as the "owner" of the vehicle
--- @param plate string The plate of the vehicle to give keys to
function SetPlayerAsOwnerOfVehicleWithPlate(plate)
    if IsDuplicityVersion() then return end

    if Config.Framework == "esx" then
        -- TODO: Implement ESX version
        print("ERROR: SetPlayerAsOwnerOfVehicleWithPlate is not yet implemented for ESX")
        return
    elseif Config.Framework == "qb" or Config.Framework == "qbx" then
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
    end
end

--------------------- SERVER FUNCTIONS ---------------------

-- Registers a useable item
--- @param itemName string The name of the item to register
--- @param callbackFn function The function to call when the item is used
function CreateUseableItem(itemName, callbackFn)
    if not IsDuplicityVersion() then return end
    if Config.Framework == "esx" then
        -- ESX returns the itemName as the second parameter, itemdata as the third parameter when calling the callback function
        -- We are interested in the itemData for our callback
        local function ESXCallback(source, itemName, itemData)
            callbackFn(source, itemData)
        end

        return Core.RegisterUsableItem(itemName, ESXCallback)
    elseif Config.Framework == "qb" then
        return Core.Functions.CreateUseableItem(itemName, callbackFn)
    elseif Config.Framework == "qbx" then
        return exports.qbx_core:CreateUseableItem(itemName, callbackFn)
    else
        warn("Invalid Config.Framework: <" .. tostring(Config.Framework) .. ">. Update CreateUseableItem in framework.lua.")
    end
end

-- Adds item to the players inventory
--- @param source number The source of the player
--- @param itemName string The name of the item to add
--- @param amount number The amount of the item to add
--- @param info table Metadata to add to the item
function AddItem(source, itemName, amount, info)
    if not IsDuplicityVersion() then return end
    if Config.Inventory == "esx" then
        local xPlayer = Core.GetPlayerFromId(source)
        return xPlayer.addInventoryItem(itemName, amount)
    elseif Config.Inventory == "qb" then
        local Player = Core.Functions.GetPlayer(source)
        TriggerClientEvent("inventory:client:ItemBox", source, Core.Shared.Items[itemName], "add")
        return Player.Functions.AddItem(itemName, amount, nil, info)
    elseif Config.Inventory == "ox" then
        exports.ox_inventory:AddItem(source, itemName, amount, info)
    else
        warn("Invalid Config.Inventory: <" .. tostring(Config.Inventory) .. ">. Update AddItem in framework.lua.")
    end
end

-- Removes item from the players inventory
--- @param source number The source of the player
--- @param itemName string The name of the item to remove
--- @param amount number The number of items to remove
--- @param slot number The slot of the item to remove from
function RemoveItem(source, itemName, amount, slot)
    if not IsDuplicityVersion() then return end
    if Config.Inventory == "esx" then
        local xPlayer = Core.GetPlayerFromId(source)
        return xPlayer.removeInventoryItem(itemName, amount)
    elseif Config.Inventory == "qb" then
        local Player = Core.Functions.GetPlayer(source)
        TriggerClientEvent("inventory:client:ItemBox", source, Core.Shared.Items[itemName], "remove")
        return Player.Functions.RemoveItem(itemName, amount, slot)
    elseif Config.Inventory == "ox" then
        exports.ox_inventory:RemoveItem(source, itemName, amount, nil, slot)
    else
        warn("Invalid Config.Inventory: <" .. tostring(Config.Inventory) .. ">. Update RemoveItem in framework.lua.")
    end
end

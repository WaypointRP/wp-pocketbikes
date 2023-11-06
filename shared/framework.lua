-- IsDuplicityVersion - is used to determine if the function is called by the server or the client (true == from server)

--------------------- SHARED FUNCTIONS ---------------------
Core = nil
---@return table Core The core object of the framework
function GetCoreObject()
    if not Core then
        if Config.Framework == 'esx' then
            Core = exports['es_extended']:getSharedObject()
        elseif Config.Framework == 'qb' then
            Core = exports['qb-core']:GetCoreObject()
        end
    end
    return Core
end

Core = Config.Framework ~= 'none' and GetCoreObject() or nil

---@param text string The text to show in the notification
---@param notificationType string The type of notification to show ex: 'success', 'error', 'info'
---@param src - number|nil The source of the player - only required when called from server side
function Notify(text, notificationType, src)
    if IsDuplicityVersion() then
        if Config.Notify == 'esx' then
            TriggerClientEvent("esx:showNotification", src, text)
        elseif Config.Notify == 'qb' then
            TriggerClientEvent('QBCore:Notify', src, text, notificationType)
        elseif Config.Notify == 'ox' then
            TriggerClientEvent("ox_lib:notify", src, {
                description = text,
                type = notificationType
            })
        end
    else
        if Config.Notify == 'esx' then
            Core.ShowNotification(text)
        elseif Config.Notify == 'qb' then
            Core.Functions.Notify(text, notificationType)
        elseif Config.Notify == 'ox' then
            lib.notify({
                description = text,
                type = notificationType
            })
        end
    end
end

---@param source number|nil The source of the player
---@return table PlayerData The player data of the player
function GetPlayerData(source)
    local Core = GetCoreObject()
    if IsDuplicityVersion() then
        if Config.Framework == 'esx' then
            return Core.GetPlayerFromId(source)
        elseif Config.Framework == 'qb' then
            return Core.Functions.GetPlayer(source)
        end
    else
        if Config.Framework == 'esx' then
            return Core.GetPlayerData()
        elseif Config.Framework == 'qb' then
            return Core.Functions.GetPlayerData()
        end
    end
end

-- Takes a prop model and the targetOptions and adds it to the target script so that this prop model is targetable
---@param model string The name of the prop model to target
---@param targetOptions table The options to pass to the target script
---        ex: options: { offset = { x = 0.0, y = 0.0, z = 0.0 }, rotation = { x = 0.0, y = 0.0, z = 0.0 } , animationDict = "", animationName = "" }
function AddTargetModel(modelName, targetOptions)
    if IsDuplicityVersion() then return end
    if Config.Target == 'qb' then
        exports['qb-target']:AddTargetModel(modelName, targetOptions)
    else
        -- TODO: Implement support for other target scripts
        print("ERROR: AddTargetModel is not yet implemented for this framework")
    end
end

--------------------- CLIENT FUNCTIONS ---------------------

-- Gives the player keys and sets them as the "owner" of the vehicle
---@param plate string The plate of the vehicle to give keys to
function SetPlayerAsOwnerOfVehicleWithPlate(plate)
    if IsDuplicityVersion() then return end

    if Config.Framework == 'esx' then
        -- TODO: Implement ESX version
        print("ERROR: SetPlayerAsOwnerOfVehicleWithPlate is not yet implemented for ESX")
        return
    elseif Config.Framework == 'qb' then
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
    end
end

--------------------- SERVER FUNCTIONS ---------------------

function CreateUseableItem(...)
    if not IsDuplicityVersion() then return end
    if Config.Framework == 'esx' then
        return Core.RegisterUsableItem(...)
    elseif Config.Framework == 'qb' then
        return Core.Functions.CreateUseableItem(...)
    end
end

-- Adds item to the players inventory
function AddItem(source, name, amount, itemInfo)
    if not IsDuplicityVersion() then return end
    if Config.Framework == 'esx' then
        local xPlayer = Core.GetPlayerFromId(source)
        return xPlayer.addInventoryItem(name, amount)
    elseif Config.Framework == 'qb' then
        local Player = Core.Functions.GetPlayer(source)
        TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[name], "add")
        return Player.Functions.AddItem(name, amount, nil, itemInfo) 
    end
end

-- Removes item from the players inventory
function RemoveItem(source, name, amount)
    if not IsDuplicityVersion() then return end
    if Config.Framework == 'esx' then
        local xPlayer = Core.GetPlayerFromId(source)
        return xPlayer.removeInventoryItem(name, amount)
    elseif Config.Framework == 'qb' then
        local Player = Core.Functions.GetPlayer(source)
        TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[name], "remove")
        return Player.Functions.RemoveItem(name, amount)
    end
end

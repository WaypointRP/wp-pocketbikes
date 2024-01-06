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
---        ex: targetOptions = { distance = num, options: { offset = { x = 0.0, y = 0.0, z = 0.0 }, rotation = { x = 0.0, y = 0.0, z = 0.0 } , animationDict = "", animationName = "" } }
function AddTargetModel(modelName, targetOptions)
    if IsDuplicityVersion() then return end
    if Config.Target == 'qb' then
        exports['qb-target']:AddTargetModel(modelName, targetOptions)
    elseif Config.Target == 'ox' then
        -- ox target expects each option to have a distance on it,
        -- Append the distance value to each option
        for _, option in pairs(targetOptions.options) do
            option.distance = targetOptions.distance
        end
        exports.ox_target:addModel(modelName, targetOptions.options)
    else
        print('ERROR: AddTargetModel is not yet implemented for this framework')
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

-- Registers a useable item
---@param itemName string The name of the item to register
---@param callbackFn function The function to call when the item is used
function CreateUseableItem(itemName, callbackFn)
    if not IsDuplicityVersion() then return end
    if Config.Framework == 'esx' then
        -- ESX returns the itemName as the second parameter, itemdata as the third parameter when calling the callback function
        -- We are interested in the itemData for our callback
        local function ESXCallback(source, itemName, itemData) 
            callbackFn(source, itemData)
        end

        return Core.RegisterUsableItem(itemName, ESXCallback)
    elseif Config.Framework == 'qb' then
        return Core.Functions.CreateUseableItem(itemName, callbackFn)
    end
end

-- Adds item to the players inventory
---@param source number The source of the player
---@param itemName string The name of the item to add
---@param amount number The amount of the item to add
function AddItem(source, itemName, amount)
    if not IsDuplicityVersion() then return end
    if Config.Inventory == 'esx' then
        local xPlayer = Core.GetPlayerFromId(source)
        return xPlayer.addInventoryItem(itemName, amount)
    elseif Config.Inventory == 'qb' then
        local Player = Core.Functions.GetPlayer(source)
        TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[itemName], "add")
        return Player.Functions.AddItem(itemName, amount) 
    elseif Config.Inventory == 'ox' then
        exports.ox_inventory:AddItem(source, itemName, amount)
    end
end

-- Removes item from the players inventory
---@param source number The source of the player
---@param itemName string The name of the item to remove
---@param amount number The number of items to remove
function RemoveItem(source, itemName, amount)
    if not IsDuplicityVersion() then return end
    if Config.Inventory == 'esx' then
        local xPlayer = Core.GetPlayerFromId(source)
        return xPlayer.removeInventoryItem(itemName, amount)
    elseif Config.Inventory == 'qb' then
        local Player = Core.Functions.GetPlayer(source)
        TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[itemName], "remove")
        return Player.Functions.RemoveItem(itemName, amount)
    elseif Config.Inventory == 'ox' then
        exports.ox_inventory:RemoveItem(source, itemName, amount)
    end
end

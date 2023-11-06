-- Setup all the bikes as useable items
for _, v in pairs(Config.Bikes) do
    CreateUseableItem(v, function(source, item)
        TriggerClientEvent('wp-pocketbikes:client:place', source, item.name, item)
    end)
end

RegisterNetEvent("wp-pocketbikes:server:RemoveItem", function(itemName)
    local src = source
    RemoveItem(src, itemName, 1)
end)

RegisterNetEvent("wp-pocketbikes:server:AddItem", function(itemName, itemInfo)
    local src = source
    AddItem(src, itemName, 1, itemInfo)
end)

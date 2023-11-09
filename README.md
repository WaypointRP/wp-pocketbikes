# Waypoint Pocket Bikes

This is a simple script that adds bikes as an item, that when used places them into the world. The player can then ride the bike like normal and when done pick the bike back up and receive the item. 

## Setup

1. Enable the script in your server.cfg

2. Modify the `config.lua` to use the framework you are using

3. Add these items to your items.lua:
    ```lua
    ["bmx"] = {["name"] = "bmx", ["label"] = "BMX Bike", ["weight"] = 500, ["type"] = "item", ["image"] = "bmx.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A BMX bike"},
    ["cruiser"] = {["name"] = "cruiser", ["label"] = "Cruiser Bike", ["weight"] = 500, ["type"] = "item", ["image"] = "cruiser.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A Cruiser bike"},
    ["fixter"] = {["name"] = "fixter", ["label"] = "Fixter Bike", ["weight"] = 500, ["type"] = "item", ["image"] = "fixter.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A Fixter bike"},
    ["scorcher"] = {["name"] = "scorcher", ["label"] = "Scorcher Bike", ["weight"] = 500, ["type"] = "item", ["image"] = "scorcher.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A Scorcher bike"},
    ["tribike"] = {["name"] = "tribike", ["label"] = "Yellow TriBike", ["weight"] = 500, ["type"] = "item", ["image"] = "tribike.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A yellow Tribike"},
    ["tribike2"] = {["name"] = "tribike2", ["label"] = "Red TriBike", ["weight"] = 500, ["type"] = "item", ["image"] = "tribike2.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A red Tribike"},
    ["tribike3"] = {["name"] = "tribike3", ["label"] = "Blue TriBike", ["weight"] = 500, ["type"] = "item", ["image"] = "tribike3.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A blue Tribike"},
    ```

4. Add the images from `images/` to your inventory script images folder

## Dependencies
- QBCore / ESX / Or other frameworks (must implement framework specific solutions in framework.lua)
- QBCore / ESX / OX for Notifications

## Credit
Authored by: BackSH00TER - Waypoint Scripts

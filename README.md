# Waypoint Pocket Bikes

![wp-pocketbikes](https://github.com/WaypointRP/wp-pocketbikes/assets/18689469/b7ed3143-870b-4ad3-b091-f8f4f655b66e)

This is a simple script that adds bikes as an item, that when used places them into the world. The player can then ride the bike like normal and when done pick the bike back up and receive the item.

When picking up a bike, all of the metadata (primaryColor, secondaryColor, pearlescentColor, wheelColor, xenonColor) is saved to the item so that it can be placed back into the world with the same state it was in when picked up. 

![wp-pocketbike](https://github.com/WaypointRP/wp-pocketbikes/assets/18689469/656c17d6-213f-4bd2-ad4b-de1603f6ce99)

![image](https://github.com/WaypointRP/wp-pocketbikes/assets/18689469/a76a9792-d365-4ded-a8d8-7b7ff3bc3da3)


## Setup

1. Enable the script in your server.cfg

2. Modify the `config.lua` to use the framework you are using

3. Add these items to your items.lua:
    ```lua
    bmx = {name = "bmx", label = "BMX Bike", weight = 500, type = "item", image = "bmx.png", unique = true, useable = true, shouldClose = true, combinable = nil, description = "A BMX bike"},
    cruiser = {name = "cruiser", label = "Cruiser Bike", weight = 500, type = "item", image = "cruiser.png", unique = true, useable = true, shouldClose = true, combinable = nil, description = "A Cruiser bike"},
    fixter = {name = "fixter", label = "Fixter Bike", weight = 500, type = "item", image = "fixter.png", unique = true, useable = true, shouldClose = true, combinable = nil, description = "A Fixter bike"},
    scorcher = {name = "scorcher", label = "Scorcher Bike", weight = 500, type = "item", image = "scorcher.png", unique = true, useable = true, shouldClose = true, combinable = nil, description = "A Scorcher bike"},
    tribike = {name = "tribike", label = "Yellow TriBike", weight = 500, type = "item", image = "tribike.png", unique = true, useable = true, shouldClose = true, combinable = nil, description = "A yellow Tribike"},
    tribike2 = {name = "tribike2", label = "Red TriBike", weight = 500, type = "item", image = "tribike2.png", unique = true, useable = true, shouldClose = true, combinable = nil, description = "A red Tribike"},
    tribike3 = {name = "tribike3", label = "Blue TriBike", weight = 500, type = "item", image = "tribike3.png", unique = true, useable = true, shouldClose = true, combinable = nil, description = "A blue Tribike"},
    ```

4. Add the images from `images/` to your inventory script images folder

5. Add a way for players to acquire bikes, whether that be a bike shop that sells the items or a vehicle store is up to you.

> Note: If you are using `ox` for any of the Framework options you need to uncomment `@ox_lib/init.lua` in the fxmanifest.lua.

## Dependencies
- QBCore / ESX / Or other frameworks (must implement framework specific solutions in framework.lua)

## Performance
This script is very lightweight and has no impact on performance.

Resouce monitor results: 0.0ms

## Credit
Authored by: BackSH00TER - Waypoint Scripts

@DonHulieo for providing insipiration and examples for structuring the framework.lua file.

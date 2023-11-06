
ensure that the itemname for the bikes matches the model name of the bikes 

add the items.lua
```lua
["bmx"]							= {["name"] = "bmx",						["label"] = "BMX Bike",					["weight"] = 500,		["type"] = "item",		["image"] = "bmx.png",			["unique"] = true,		["useable"] = true,		["shouldClose"] = true,    ["combinable"] = nil, ["description"] = "A BMX bike"},
["cruiser"]						= {["name"] = "cruiser",					["label"] = "Cruiser Bike",				["weight"] = 500,		["type"] = "item",		["image"] = "cruiser.png",			["unique"] = true,		["useable"] = true,		["shouldClose"] = true,    ["combinable"] = nil, ["description"] = "A Cruiser bike"},
["fixter"]						= {["name"] = "fixter",						["label"] = "Fixter Bike",				["weight"] = 500,		["type"] = "item",		["image"] = "fixter.png",			["unique"] = true,		["useable"] = true,		["shouldClose"] = true,    ["combinable"] = nil, ["description"] = "A Fixter bike"},
["scorcher"]					= {["name"] = "scorcher",					["label"] = "Scorcher Bike",			["weight"] = 500,		["type"] = "item",		["image"] = "scorcher.png",			["unique"] = true,		["useable"] = true,		["shouldClose"] = true,    ["combinable"] = nil, ["description"] = "A Scorcher bike"},
["tribike"]						= {["name"] = "tribike",					["label"] = "Yellow TriBike",			["weight"] = 500,		["type"] = "item",		["image"] = "tribike.png",			["unique"] = true,		["useable"] = true,		["shouldClose"] = true,    ["combinable"] = nil, ["description"] = "A yellow Tribike"},
["tribike2"]					= {["name"] = "tribike2",					["label"] = "Red TriBike",				["weight"] = 500,		["type"] = "item",		["image"] = "tribike2.png",			["unique"] = true,		["useable"] = true,		["shouldClose"] = true,    ["combinable"] = nil, ["description"] = "A red Tribike"},
["tribike3"]					= {["name"] = "tribike3",					["label"] = "Blue TriBike",				["weight"] = 500,		["type"] = "item",		["image"] = "tribike3.png",			["unique"] = true,		["useable"] = true,		["shouldClose"] = true,    ["combinable"] = nil, ["description"] = "A blue Tribike"},
	
```

add pics

-- This script uses the assumption that the bike model name is the same as the item name
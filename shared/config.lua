Config = {}

-- Frameworks
-- Supported framework options are listed next to each option
-- If the framework you are using is not listed, you will need to modify the framework.lua code to work with your framework
-- Note: If using ox for any option, enable @ox_lib/init.lua in the manifest!

Config.Framework = 'qb'     -- 'qb', 'esx'
Config.Notify = 'qb'        -- 'qb', 'esx', 'ox' 
Config.Target = 'qb'        -- 'qb', 'ox'
Config.Inventory = 'qb'     -- 'qb', 'esx', 'ox'

-- Add the bike models you want to be able to use as pocket bikes here
-- This script uses the assumption that the bike model name is the same as the item name
Config.Bikes = { 
	"bmx", 
	"cruiser", 
	"fixter", 
	"scorcher", 
	"tribike", 
	"tribike2", 
	"tribike3",
}

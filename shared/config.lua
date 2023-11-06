Config = {}

Config.Framework = 'qb' -- supports 'qb' or 'esx'
Config.Notify = 'qb' -- supports 'qb', 'esx', 'ox' (if using ox enable @ox_lib/init.lua in the manifest)
Config.Target = 'qb' 

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
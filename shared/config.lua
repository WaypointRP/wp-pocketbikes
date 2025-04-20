Config = {}

------------------------------------
-- FRAMEWORK / SCRIPT CONFIGURATION
-- Adjust these settings to match the framework and scripts you are using
-- Note: If using ox for any option, enable @ox_lib/init.lua in the manifest!
------------------------------------

--- @type "qb" | "qbx" | "esx"
Config.Framework = "qb"

-- The notification script you are using.
--- @type "qb" | "esx" | "ox" | "none"
Config.Notify = "qb"

-- The target script you are using.
--- @type "qb" | "ox"
Config.Target = "qb"

-- The inventory script you are using.
--- @type "qb" | "esx" | "ox"
Config.Inventory = "qb"

------------------------------------
--- END FRAMEWORK / SCRIPT CONFIGURATION
------------------------------------

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

--[[
    Components Init Module
    Initializes all components for the Rubies admin panel
]]

local componets = {}

-- Export all modules
componets.UI = require(script.ui)
componets.Handler = require(script.handeler)
componets.Notifications = require(script.notifications)
componets.KeySystem = require(script.extra.keysystem)

return componets

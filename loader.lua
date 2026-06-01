--[[
    RUBIES - Universal Admin Panel Launcher
    Main Loader Script v1.0
    
    Usage:
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Prolokmn2/Rubies/main/loader.lua"))()
]]

local CONFIG_URL = "https://raw.githubusercontent.com/Prolokmn2/Rubies/main/config.lua"
local MAIN_URL = "https://raw.githubusercontent.com/Prolokmn2/Rubies/main/main.lua"

print("[RUBIES LOADER v1.0] Loading...")

-- Load configuration
local function LoadConfig()
    print("[CONFIG] Loading configuration...")
    
    local success, configCode = pcall(function()
        return game:HttpGet(CONFIG_URL)
    end)
    
    if not success then
        warn("[WARNING] Config not found, using defaults")
        return {
            Panel = {Key = "auraman", Version = "1.0"},
            GitHub = {BaseURL = "https://raw.githubusercontent.com/Prolokmn2/Rubies/main/"}
        }
    end
    
    local config = loadstring(configCode)()
    return config
end

-- Load and execute main script
local function Initialize()
    local config = LoadConfig()
    
    print("[LOAD] Fetching Rubies from: Prolokmn2/Rubies")
    
    local success, mainCode = pcall(function()
        return game:HttpGet(MAIN_URL)
    end)
    
    if not success then
        error("[ERROR] Failed to download main script: " .. tostring(mainCode))
    end
    
    print("[SUCCESS] Script loaded! Executing...")
    
    local execSuccess, execErr = pcall(function()
        loadstring(mainCode)()
    end)
    
    if execSuccess then
        print("[DONE] Rubies Admin Panel initialized!")
        print("[KEY] Key: " .. config.Panel.Key)
    else
        error("[ERROR] Error executing Rubies: " .. tostring(execErr))
    end
end

Initialize()

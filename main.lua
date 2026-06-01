--[[
    RUBIES - Universal Admin Panel Launcher
    A powerful admin panel system for all games
    Features: Key system, Game detection, Notifications, Advanced UI
]]

-- Prevent running multiple times
if _G.RubiesInitialized then
    print("[RUBIES] Already initialized! Ignoring duplicate execution.")
    return
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Try to load modules - check multiple locations
local componets
local KeySystem, Handler, UI, Notifications

-- Try script parent first (if running from game)
if script and script.Parent and script.Parent:FindFirstChild("componets") then
    print("[RUBIES] Found componets in script.Parent")
    componets = script.Parent:WaitForChild("componets")
    KeySystem = require(componets.extra.keysystem)
    Handler = require(componets.handeler)
    UI = require(componets.ui)
    Notifications = require(componets.notifications)
else
    -- Try common locations
    local searchPaths = {
        game:GetService("ReplicatedStorage"):FindFirstChild("componets"),
        game:GetService("ServerStorage"):FindFirstChild("componets"),
        workspace:FindFirstChild("componets")
    }
    
    local found = false
    for _, path in ipairs(searchPaths) do
        if path then
            print("[RUBIES] Found componets at: " .. path.Parent.Name)
            componets = path
            found = true
            break
        end
    end
    
    if found then
        KeySystem = require(componets.extra.keysystem)
        Handler = require(componets.handeler)
        UI = require(componets.ui)
        Notifications = require(componets.notifications)
    else
        -- Fallback: Create dummy modules for testing
        print("[WARNING] Could not find componets - using test mode")
        KeySystem = {KeyVerified = Instance.new("BindableEvent"), CreateKeyPrompt = function() return Instance.new("ScreenGui") end}
        Handler = {DetectGame = function() return "universal" end, GetGameList = function() return {} end}
        UI = {CreateLauncherPanel = function() return {} end}
        Notifications = {Create = function() end}
    end
end

-- Global state
local Rubies = {
    Initialized = false,
    CurrentGame = nil,
    AdminActive = false,
    Scripts = {},
    Settings = {},
    Handler = Handler
}

-- Initialize key system first
local function InitKeySystem()
    print("[RUBIES] Key System Initializing...")
    
    if not KeySystem.CreateKeyPrompt then
        print("[ERROR] KeySystem not properly loaded")
        return
    end
    
    local keyGUI = KeySystem:CreateKeyPrompt(PlayerGui)
    
    -- Wait for key verification
    local verified = false
    local connection
    connection = KeySystem.KeyVerified:Connect(function()
        verified = true
        connection:Disconnect()
        print("[RUBIES] Key verified!")
        InitMainPanel()
    end)
end

-- Initialize main admin panel
local function InitMainPanel()
    print("[RUBIES] Initializing Main Panel...")
    
    if not Handler.DetectGame then
        print("[ERROR] Handler not properly loaded")
        return
    end
    
    -- Detect current game
    Rubies.CurrentGame = Handler:DetectGame()
    print("[RUBIES] Detected Game: " .. Rubies.CurrentGame)
    
    -- Create main launcher GUI
    if UI.CreateLauncherPanel then
        local launcherGUI = UI:CreateLauncherPanel(PlayerGui, Rubies)
        print("[RUBIES] Main panel created!")
    end
    
    -- Show recommendation notification
    if Rubies.CurrentGame and Rubies.CurrentGame ~= "universal" then
        task.wait(0.5)
        if Notifications.Create then
            Notifications:Create({
                Title = "Recommended Script",
                Message = "Run " .. Rubies.CurrentGame .. " script?",
                Duration = 5,
                Sound = true,
                Callback = function()
                    Handler:LoadGameScript(Rubies.CurrentGame, launcherGUI)
                    Notifications:Create({
                        Title = "Script Loaded",
                        Message = Rubies.CurrentGame .. " script is now active!",
                        Duration = 3,
                        Sound = true
                    })
                end
            })
        end
    end
    
    -- Load universal scripts
    if Handler.LoadUniversalScripts then
        Handler:LoadUniversalScripts(launcherGUI)
    end
    
    Rubies.Initialized = true
    print("[RUBIES] Initialization complete!")
end

-- Start the system
print("[RUBIES] v1.0 Initializing...")
InitKeySystem()

-- Mark as initialized globally (prevent double-run)
_G.RubiesInitialized = true

-- Return global Rubies for debugging
_G.Rubies = Rubies
print("[RUBIES] Access Rubies via _G.Rubies")

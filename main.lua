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

-- Try to load modules from script context (if in game)
local componets
local KeySystem, Handler, UI, Notifications

if script and script.Parent then
    -- Script context available (normal execution)
    componets = script.Parent:WaitForChild("componets")
    KeySystem = require(componets.extra.keysystem)
    Handler = require(componets.handeler)
    UI = require(componets.ui)
    Notifications = require(componets.notifications)
else
    -- Fallback: load from game if available
    componets = game.ReplicatedStorage:FindFirstChild("componets") or game.ServerScriptService:FindFirstChild("componets")
    if componets then
        KeySystem = require(componets.extra.keysystem)
        Handler = require(componets.handeler)
        UI = require(componets.ui)
        Notifications = require(componets.notifications)
    else
        error("[RUBIES] Could not find componets folder!")
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
    
    -- Detect current game
    Rubies.CurrentGame = Handler:DetectGame()
    print("[RUBIES] Detected Game: " .. Rubies.CurrentGame)
    
    -- Create main launcher GUI
    local launcherGUI = UI:CreateLauncherPanel(PlayerGui, Rubies)
    print("[RUBIES] Main panel created!")
    
    -- Show recommendation notification
    if Rubies.CurrentGame and Rubies.CurrentGame ~= "universal" then
        task.wait(0.5)
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
    
    -- Load universal scripts
    Handler:LoadUniversalScripts(launcherGUI)
    
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

--[[
    RUBIES - Universal Admin Panel Launcher
    A powerful admin panel system for all games
    Features: Key system, Game detection, Notifications, Advanced UI
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Load modules
local componets = script.Parent:WaitForChild("componets")
local KeySystem = require(componets.extra.keysystem)
local Handler = require(componets.handeler)
local UI = require(componets.ui)
local Notifications = require(componets.notifications)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

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
    print("🔐 Rubies: Key System Initializing...")
    
    local keyGUI = KeySystem:CreateKeyPrompt(PlayerGui)
    
    -- Wait for key verification
    local verified = false
    local connection
    connection = KeySystem.KeyVerified:Connect(function()
        verified = true
        connection:Disconnect()
        print("✅ Rubies: Key verified!")
        InitMainPanel()
    end)
end

-- Initialize main admin panel
local function InitMainPanel()
    print("🚀 Rubies: Initializing Main Panel...")
    
    -- Detect current game
    Rubies.CurrentGame = Handler:DetectGame()
    print("📍 Detected Game:", Rubies.CurrentGame)
    
    -- Create main launcher GUI
    local launcherGUI = UI:CreateLauncherPanel(PlayerGui, Rubies)
    
    -- Show recommendation notification
    if Rubies.CurrentGame then
        task.wait(0.5)
        Notifications:Create({
            Title = "🎮 Recommended Script",
            Message = "Run " .. Rubies.CurrentGame .. " script?",
            Duration = 5,
            Sound = true,
            Callback = function()
                Handler:LoadGameScript(Rubies.CurrentGame, launcherGUI)
                Notifications:Create({
                    Title = "✅ Script Loaded",
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
end

-- Start the system
print("🌟 Rubies Admin Panel v1.0 Initializing...")
InitKeySystem()

-- Return global Rubies for debugging
_G.Rubies = Rubies
print("ℹ️  Access Rubies via _G.Rubies")

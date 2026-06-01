--[[
    RUBIES - Universal Admin Panel Launcher
    A powerful admin panel system for all games
    Features: Key system, Game detection, Notifications, Advanced UI
]]

-- Prevent running multiple times
if _G.RubiesInitialized then
    print("[RUBIES] Already initialized!")
    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Try to load modules
local KeySystem, Handler, UI, Notifications

local function TryLoadModules()
    local componets
    
    if script and script.Parent and script.Parent:FindFirstChild("componets") then
        componets = script.Parent:FindFirstChild("componets")
        if componets then
            pcall(function()
                KeySystem = require(componets.extra.keysystem)
                Handler = require(componets.handeler)
                UI = require(componets.ui)
                Notifications = require(componets.notifications)
                print("[RUBIES] Modules loaded from script parent!")
                return true
            end)
        end
    end
    
    if not KeySystem then
        local searchPaths = {
            game:GetService("ReplicatedStorage"):FindFirstChild("componets"),
            workspace:FindFirstChild("componets")
        }
        
        for _, path in ipairs(searchPaths) do
            if path then
                pcall(function()
                    KeySystem = require(path.extra.keysystem)
                    Handler = require(path.handeler)
                    UI = require(path.ui)
                    Notifications = require(path.notifications)
                    print("[RUBIES] Modules loaded from: " .. path.Parent.Name)
                    return true
                end)
                if KeySystem then break end
            end
        end
    end
    
    return KeySystem ~= nil
end

-- Create inline versions if needed
local function CreateInlineModules()
    if KeySystem then return end
    
    print("[RUBIES] Creating inline modules...")
    
    -- Simple Key System
    KeySystem = {}
    KeySystem.Verified = false
    
    function KeySystem:CreateKeyPrompt(parent)
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "KeySystemUI"
        screenGui.ResetOnSpawn = false
        screenGui.ZIndex = 999
        screenGui.Parent = parent
        
        -- Background
        local bg = Instance.new("TextButton")
        bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        bg.BackgroundTransparency = 0.5
        bg.BorderSizePixel = 0
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.Text = ""
        bg.ZIndex = 1
        bg.Parent = screenGui
        
        -- Container
        local container = Instance.new("Frame")
        container.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        container.BorderSizePixel = 0
        container.Size = UDim2.new(0, 400, 0, 200)
        container.Position = UDim2.new(0.5, -200, 0.5, -100)
        container.ZIndex = 2
        container.Parent = screenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = container
        
        -- Title
        local title = Instance.new("TextLabel")
        title.BackgroundTransparency = 1
        title.TextSize = 20
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.Font = Enum.Font.GothamBold
        title.Text = "RUBIES KEY"
        title.Size = UDim2.new(1, 0, 0, 50)
        title.Parent = container
        
        -- Input
        local input = Instance.new("TextBox")
        input.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        input.BorderSizePixel = 0
        input.TextSize = 14
        input.TextColor3 = Color3.fromRGB(255, 255, 255)
        input.Font = Enum.Font.Gotham
        input.PlaceholderText = "Enter key..."
        input.Size = UDim2.new(1, -20, 0, 40)
        input.Position = UDim2.new(0, 10, 0, 55)
        input.Parent = container
        
        -- Button
        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        btn.BorderSizePixel = 0
        btn.TextSize = 14
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.Text = "VERIFY"
        btn.Size = UDim2.new(1, -20, 0, 35)
        btn.Position = UDim2.new(0, 10, 0, 100)
        btn.Parent = container
        
        btn.MouseButton1Click:Connect(function()
            if input.Text:lower() == "auraman" then
                self.Verified = true
                screenGui:Destroy()
            else
                input.Text = ""
            end
        end)
        
        input:CaptureFocus()
        return screenGui
    end
    
    -- Simple Handler
    Handler = {}
    function Handler:DetectGame()
        return "universal"
    end
    function Handler:GetGameList()
        return {{name = "universal", displayName = "Universal Scripts", icon = "[UNIVERSAL]", color = {R = 100, G = 200, B = 150}}}
    end
    function Handler:LoadGameScript() end
    function Handler:LoadUniversalScripts() end
    function Handler:GetPlayerData(player)
        return {
            Player = player,
            UserId = player.UserId,
            Username = player.Name,
            DisplayName = player.DisplayName or player.Name,
            Character = player.Character,
            HP = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or 100,
            MaxHP = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.MaxHealth or 100
        }
    end
    
    -- Simple UI
    UI = {}
    function UI:CreateLauncherPanel(parent, rubies)
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "RubiesLauncher"
        screenGui.ResetOnSpawn = false
        screenGui.ZIndex = 50
        screenGui.Parent = parent
        
        -- Main frame
        local frame = Instance.new("Frame")
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        frame.BorderSizePixel = 0
        frame.Size = UDim2.new(0, 500, 0, 400)
        frame.Position = UDim2.new(0.5, -250, 0.5, -200)
        frame.ZIndex = 51
        frame.Parent = screenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 15)
        corner.Parent = frame
        
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(100, 150, 255)
        stroke.Thickness = 2
        stroke.Parent = frame
        
        -- Title
        local title = Instance.new("TextLabel")
        title.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        title.BorderSizePixel = 0
        title.TextSize = 18
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.Font = Enum.Font.GothamBold
        title.Text = "RUBIES LAUNCHER"
        title.Size = UDim2.new(1, 0, 0, 50)
        title.Parent = frame
        
        -- Content
        local content = Instance.new("TextLabel")
        content.BackgroundTransparency = 1
        content.TextSize = 14
        content.TextColor3 = Color3.fromRGB(200, 200, 220)
        content.Font = Enum.Font.Gotham
        content.Text = "Admin Panel Ready!\n\nKey Accepted: auraman\n\nUse this panel to manage scripts."
        content.Size = UDim2.new(1, -20, 1, -70)
        content.Position = UDim2.new(0, 10, 0, 50)
        content.Parent = frame
        
        print("[RUBIES] UI Created!")
        return screenGui
    end
    
    -- Simple Notifications
    Notifications = {}
    function Notifications:Create(config) end
    
    print("[RUBIES] Inline modules created!")
end

-- Main initialization
local function Initialize()
    print("[RUBIES] Starting initialization...")
    
    -- Try to load real modules first
    TryLoadModules()
    
    -- If that failed, use inline versions
    if not KeySystem then
        CreateInlineModules()
    end
    
    -- Show key prompt
    print("[RUBIES] Showing key prompt...")
    KeySystem:CreateKeyPrompt(PlayerGui)
    
    -- Wait for verification
    local maxWait = 60
    local waited = 0
    while not KeySystem.Verified and waited < maxWait do
        task.wait(0.1)
        waited = waited + 0.1
    end
    
    if KeySystem.Verified then
        print("[RUBIES] Key verified! Creating UI...")
        task.wait(0.5)
        
        local Rubies = {
            CurrentGame = Handler:DetectGame(),
            Handler = Handler
        }
        
        UI:CreateLauncherPanel(PlayerGui, Rubies)
        Handler:LoadUniversalScripts()
        
        print("[RUBIES] Ready!")
    else
        print("[RUBIES] Key verification timeout")
    end
end

_G.RubiesInitialized = true
Initialize()

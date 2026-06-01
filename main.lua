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
        screenGui.Parent = parent
        
        -- Container (no background behind it, just the dialog)
        local container = Instance.new("Frame")
        container.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        container.BorderColor3 = Color3.fromRGB(100, 150, 255)
        container.BorderSizePixel = 2
        container.Size = UDim2.new(0, 300, 0, 180)
        container.Position = UDim2.new(0.5, -150, 0.5, -90)
        container.Parent = screenGui
        
        -- Title
        local title = Instance.new("TextLabel")
        title.BackgroundTransparency = 1
        title.TextSize = 18
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        pcall(function() title.Font = Enum.Font.GothamBold end)
        title.Text = "RUBIES"
        title.Size = UDim2.new(1, 0, 0, 40)
        title.Parent = container
        
        -- Input
        local input = Instance.new("TextBox")
        input.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        input.BorderColor3 = Color3.fromRGB(100, 100, 120)
        input.BorderSizePixel = 1
        input.TextSize = 14
        input.TextColor3 = Color3.fromRGB(255, 255, 255)
        pcall(function() input.Font = Enum.Font.Gotham end)
        input.PlaceholderText = "Key..."
        pcall(function() input.PlaceholderColor3 = Color3.fromRGB(150, 150, 150) end)
        input.Size = UDim2.new(1, -20, 0, 35)
        input.Position = UDim2.new(0, 10, 0, 50)
        input.Parent = container
        
        -- Button
        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        btn.BorderSizePixel = 0
        btn.TextSize = 13
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        pcall(function() btn.Font = Enum.Font.GothamBold end)
        btn.Text = "VERIFY"
        btn.Size = UDim2.new(1, -20, 0, 30)
        btn.Position = UDim2.new(0, 10, 0, 95)
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
        screenGui.Parent = parent
        
        -- Main frame
        local frame = Instance.new("Frame")
        frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
        frame.BorderSizePixel = 0
        frame.Size = UDim2.new(0, 600, 0, 500)
        frame.Position = UDim2.new(0.5, -300, 0.5, -250)
        frame.ZIndex = 1
        frame.Parent = screenGui
        
        pcall(function()
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 20)
            corner.Parent = frame
        end)
        
        pcall(function()
            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.fromRGB(100, 150, 255)
            stroke.Thickness = 3
            stroke.Parent = frame
        end)
        
        -- Header
        local header = Instance.new("TextLabel")
        header.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        header.BorderSizePixel = 0
        header.TextSize = 24
        header.TextColor3 = Color3.fromRGB(255, 255, 255)
        pcall(function() header.Font = Enum.Font.GothamBold end)
        header.Text = "RUBIES"
        header.Size = UDim2.new(1, 0, 0, 60)
        header.ZIndex = 2
        header.Parent = frame
        
        -- Player Info
        local playerInfo = Instance.new("TextLabel")
        playerInfo.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        playerInfo.BorderSizePixel = 0
        playerInfo.TextSize = 12
        playerInfo.TextColor3 = Color3.fromRGB(180, 180, 200)
        pcall(function() playerInfo.Font = Enum.Font.Gotham end)
        playerInfo.Text = "Player: " .. LocalPlayer.Name
        playerInfo.Size = UDim2.new(1, 0, 0, 30)
        playerInfo.Position = UDim2.new(0, 0, 1, -30)
        playerInfo.ZIndex = 2
        playerInfo.Parent = frame
        
        -- ScrollingFrame for games
        local scrolling = Instance.new("ScrollingFrame")
        scrolling.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        scrolling.BorderSizePixel = 0
        scrolling.Size = UDim2.new(1, 0, 1, -90)
        scrolling.Position = UDim2.new(0, 0, 0, 60)
        scrolling.ScrollBarThickness = 4
        scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
        scrolling.ZIndex = 1
        scrolling.Parent = frame
        
        -- UIListLayout for vertical stacking
        local listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0, 8)
        listLayout.FillDirection = Enum.FillDirection.Vertical
        pcall(function() listLayout.Parent = scrolling end)
        
        -- Get games list
        local games = rubies.Handler:GetGameList()
        
        if games and #games > 0 then
            for i, game in ipairs(games) do
                local gameBtn = Instance.new("TextButton")
                gameBtn.BackgroundColor3 = Color3.fromRGB(game.color.R or 100, game.color.G or 100, game.color.B or 100)
                gameBtn.BorderSizePixel = 0
                gameBtn.TextSize = 14
                gameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                pcall(function() gameBtn.Font = Enum.Font.GothamBold end)
                gameBtn.Text = game.icon .. " " .. game.displayName
                gameBtn.Size = UDim2.new(1, -16, 0, 50)
                gameBtn.Parent = scrolling
                
                -- Add corner radius
                pcall(function()
                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(0, 10)
                    corner.Parent = gameBtn
                end)
                
                -- Click handler
                gameBtn.MouseButton1Click:Connect(function()
                    print("[RUBIES] Clicked: " .. game.displayName)
                end)
                
                gameBtn.MouseEnter:Connect(function()
                    gameBtn.BackgroundTransparency = 0.2
                end)
                
                gameBtn.MouseLeave:Connect(function()
                    gameBtn.BackgroundTransparency = 0
                end)
            end
        end
        
        -- Update canvas size
        local function updateScroll()
            local totalSize = 0
            for _, child in ipairs(scrolling:GetChildren()) do
                if child:IsA("GuiObject") then
                    totalSize = totalSize + child.Size.Y.Offset + 8
                end
            end
            scrolling.CanvasSize = UDim2.new(0, 0, 0, totalSize)
        end
        
        task.wait(0.1)
        updateScroll()
        
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
        
        pcall(function()
            UI:CreateLauncherPanel(PlayerGui, Rubies)
        end)
        
        pcall(function()
            Handler:LoadUniversalScripts()
        end)
        
        print("[RUBIES] Ready!")
    else
        print("[RUBIES] Key verification timeout")
    end
end

_G.RubiesInitialized = true
pcall(function()
    Initialize()
end)

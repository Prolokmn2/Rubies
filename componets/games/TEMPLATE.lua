--[[
    NEW GAME TEMPLATE
    Copy this file to: componets/games/YourGameName/main.lua
    Update the Metadata and game functions as needed!
]]

local YourGame = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- REQUIRED: Metadata for auto-detection
YourGame.Metadata = {
    displayName = "Your Game Name",      -- Display name in launcher
    icon = "[YOUR_ICON]",               -- Icon/prefix to show
    color = {R = 100, G = 150, B = 200}, -- Button color (RGB 0-255)
    patterns = {"GameFolder", "GamePart"} -- Patterns to auto-detect
}

-- REQUIRED: Initialize function (called when game is loaded)
function YourGame:Initialize(parentUI)
    print("[YourGame] Initializing...")
    self:CreateGameUI(parentUI)
end

-- REQUIRED: UI creation function
function YourGame:CreateGameUI(parentUI)
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Create screen gui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "YourGameUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndex = 40
    screenGui.Parent = playerGui
    
    -- Main window
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "GameFeaturesFrame"
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.Size = UDim2.new(0, 280, 0, 250)
    mainFrame.Position = UDim2.new(1, -600, 0.5, -125)
    mainFrame.ZIndex = 41
    mainFrame.Parent = screenGui
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    -- Border
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 150, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.3
    stroke.Parent = mainFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.TextSize = 16
    title.TextColor3 = Color3.fromRGB(100, 150, 255)
    title.Font = Enum.Font.GothamBold
    title.Text = "[YOUR_ICON] YOUR GAME"
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Parent = mainFrame
    
    -- Scrolling content
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.Size = UDim2.new(1, 0, 1, -40)
    scrollFrame.Position = UDim2.new(0, 0, 0, 40)
    scrollFrame.ScrollBarThickness = 5
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.Parent = mainFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 8)
    listLayout.Parent = scrollFrame
    
    -- Your feature buttons here
    local features = {
        "[FEATURE_1] Feature Name",
        "[FEATURE_2] Another Feature",
        "[FEATURE_3] More Stuff"
    }
    
    for _, featureName in ipairs(features) do
        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        btn.BorderSizePixel = 0
        btn.TextSize = 11
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Gotham
        btn.Text = featureName
        btn.Size = UDim2.new(1, -16, 0, 35)
        btn.Parent = scrollFrame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
    end
    
    -- Update canvas size
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
    end)
end

-- Export the module
return YourGame

--[[
    UntitledGunGame Script
    Game-specific features for the gun game
]]

local UntitledGunGame = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Metadata for auto-detection
UntitledGunGame.Metadata = {
    displayName = "Gun Game",
    icon = "[GUNS]",
    color = {R = 255, G = 100, B = 100},
    patterns = {"Weapon", "Gun", "Ammo", "Damage"}
}

function UntitledGunGame:Initialize(parentUI)
    print("🔫 Initializing UntitledGunGame Features...")
    self:CreateGameUI(parentUI)
end

function UntitledGunGame:CreateGameUI(parentUI)
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Create screen gui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UntitledGunGameUI"
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
    stroke.Color = Color3.fromRGB(255, 100, 100)
    stroke.Thickness = 1
    stroke.Transparency = 0.3
    stroke.Parent = mainFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.TextSize = 16
    title.TextColor3 = Color3.fromRGB(255, 100, 100)
    title.Font = Enum.Font.GothamBold
    title.Text = "🔫 GAME FEATURES"
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
    
    -- Feature buttons
    local features = {
        "🎯 Aimbot",
        "💥 Gun Modifier",
        "🛡️ God Mode",
        "💰 Unlimited Ammo"
    }
    
    for _, featureName in ipairs(features) do
        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        btn.BorderSizePixel = 0
        btn.TextSize = 11
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Gotham
        btn.Text = featureName .. " [COMING SOON]"
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

return UntitledGunGame

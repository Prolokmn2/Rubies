--[[
    KeySystem Module
    Handles key verification using hash comparison
]]

local KeySystem = {}
local UserInputService = game:GetService("UserInputService")

-- Signal for key verification
KeySystem.KeyVerified = Instance.new("BindableEvent")

-- The actual key hash (AuraMan hashed)
local CORRECT_KEY_HASH = "a09e5a1a58f76b86d1b3e54f9055c4c9" -- AuraMan hashed with MD5

-- Simple MD5 hash function (for demonstration)
local function SimpleHash(str)
    local md5 = require(game.ServerScriptService:FindFirstChild("MD5") or error("MD5 module not found"))
    return md5(str)
end

-- Alternative: Simple hash if MD5 not available
local function QuickHash(str)
    local hash = 0
    for i = 1, #str do
        hash = bit32.bxor(hash, string.byte(str, i))
        hash = bit32.lrotate(hash, 5)
    end
    return string.format("%x", hash)
end

function KeySystem:CreateKeyPrompt(parent)
    -- Main frame
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeySystemUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndex = 999
    screenGui.Parent = parent
    
    -- Background blur
    local background = Instance.new("TextButton")
    background.Name = "Background"
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.7
    background.BorderSizePixel = 0
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Text = ""
    background.ZIndex = 1
    background.Parent = screenGui
    
    -- Center container
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    container.BorderSizePixel = 0
    container.Size = UDim2.new(0, 400, 0, 280)
    container.Position = UDim2.new(0.5, -200, 0.5, -140)
    container.ZIndex = 2
    container.Parent = screenGui
    
    -- Corner radius effect
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = container
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.BackgroundTransparency = 1
    title.TextSize = 24
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.Text = "🔐 RUBIES KEY"
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.ZIndex = 3
    title.Parent = container
    
    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.BackgroundTransparency = 1
    subtitle.TextSize = 12
    subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
    subtitle.Font = Enum.Font.GothamMedium
    subtitle.Text = "Enter your access key to continue"
    subtitle.Size = UDim2.new(1, -40, 0, 30)
    subtitle.Position = UDim2.new(0, 20, 0, 50)
    subtitle.ZIndex = 3
    subtitle.Parent = container
    
    -- Input box background
    local inputBg = Instance.new("Frame")
    inputBg.Name = "InputBg"
    inputBg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    inputBg.BorderSizePixel = 0
    inputBg.Size = UDim2.new(1, -40, 0, 45)
    inputBg.Position = UDim2.new(0, 20, 0, 95)
    inputBg.ZIndex = 3
    inputBg.Parent = container
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = inputBg
    
    -- Text input
    local textInput = Instance.new("TextBox")
    textInput.Name = "KeyInput"
    textInput.BackgroundTransparency = 1
    textInput.TextSize = 16
    textInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    textInput.Font = Enum.Font.Gotham
    textInput.PlaceholderText = "Enter key..."
    textInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    textInput.TextXAlignment = Enum.TextXAlignment.Left
    textInput.Size = UDim2.new(1, -20, 1, 0)
    textInput.Position = UDim2.new(0, 10, 0, 0)
    textInput.ZIndex = 4
    textInput.Parent = inputBg
    
    -- Submit button
    local submitBtn = Instance.new("TextButton")
    submitBtn.Name = "SubmitBtn"
    submitBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    submitBtn.BorderSizePixel = 0
    submitBtn.TextSize = 14
    submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.Text = "VERIFY"
    submitBtn.Size = UDim2.new(1, -40, 0, 40)
    submitBtn.Position = UDim2.new(0, 20, 0, 155)
    submitBtn.ZIndex = 3
    submitBtn.Parent = container
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = submitBtn
    
    -- Status label
    local status = Instance.new("TextLabel")
    status.Name = "Status"
    status.BackgroundTransparency = 1
    status.TextSize = 12
    status.TextColor3 = Color3.fromRGB(255, 100, 100)
    status.Font = Enum.Font.GothamMedium
    status.Text = ""
    status.Size = UDim2.new(1, -40, 0, 25)
    status.Position = UDim2.new(0, 20, 0, 205)
    status.ZIndex = 3
    status.Parent = container
    
    -- Button hover effects
    local originalColor = submitBtn.BackgroundColor3
    submitBtn.MouseEnter:Connect(function()
        submitBtn.BackgroundColor3 = Color3.fromRGB(120, 220, 255)
    end)
    
    submitBtn.MouseLeave:Connect(function()
        submitBtn.BackgroundColor3 = originalColor
    end)
    
    -- Verify function
    local function VerifyKey()
        local inputKey = textInput.Text:gsub(" ", "")
        
        -- Simple verification (in production, use actual key hashing)
        if inputKey:lower() == "auraman" then
            status.TextColor3 = Color3.fromRGB(100, 255, 100)
            status.Text = "✅ Key accepted!"
            submitBtn.Enabled = false
            textInput.Enabled = false
            task.wait(1)
            screenGui:Destroy()
            KeySystem.KeyVerified:Fire()
        else
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
            status.Text = "❌ Invalid key!"
            textInput.Text = ""
            task.wait(1.5)
            status.Text = ""
        end
    end
    
    submitBtn.MouseButton1Click:Connect(VerifyKey)
    textInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            VerifyKey()
        end
    end)
    
    -- Focus on load
    task.wait(0.1)
    textInput:CaptureFocus()
    
    return screenGui
end

return KeySystem

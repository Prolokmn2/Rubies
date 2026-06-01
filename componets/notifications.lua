--[[
    Notifications Module
    Handles in-game notifications with sound effects
]]

local Notifications = {}
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Sound IDs for different notifications
local SOUNDS = {
    SUCCESS = "rbxassetid://6518811580",  -- Success sound
    WARNING = "rbxassetid://6518811581",  -- Warning sound
    INFO = "rbxassetid://6518810792",     -- Info sound
}

-- Active notifications
local activeNotifications = {}

-- Create notification
function Notifications:Create(config)
    config = config or {}
    local title = config.Title or "Notification"
    local message = config.Message or ""
    local duration = config.Duration or 3
    local sound = config.Sound or false
    local callback = config.Callback
    
    -- Create container if not exists
    if not PlayerGui:FindFirstChild("NotificationsContainer") then
        local container = Instance.new("ScreenGui")
        container.Name = "NotificationsContainer"
        container.ResetOnSpawn = false
        container.ZIndex = 100
        container.Parent = PlayerGui
    end
    
    local container = PlayerGui:FindFirstChild("NotificationsContainer")
    
    -- Create notification frame
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Name = "Notification"
    notificationFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Size = UDim2.new(0, 350, 0, 100)
    notificationFrame.Position = UDim2.new(1, 20, 0, 20 + (#activeNotifications * 120))
    notificationFrame.Transparency = 0
    notificationFrame.Parent = container
    
    -- Add corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = notificationFrame
    
    -- Add border stroke effect
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 150, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Parent = notificationFrame
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextSize = 14
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 15, 0, 10)
    titleLabel.Parent = notificationFrame
    
    -- Message
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.BackgroundTransparency = 1
    messageLabel.TextSize = 11
    messageLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Text = message
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextWrapped = true
    messageLabel.Size = UDim2.new(1, -20, 0, 35)
    messageLabel.Position = UDim2.new(0, 15, 0, 35)
    messageLabel.Parent = notificationFrame
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseBtn"
    closeBtn.BackgroundTransparency = 1
    closeBtn.TextSize = 16
    closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "✕"
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Position = UDim2.new(1, -35, 0, 10)
    closeBtn.Parent = notificationFrame
    
    -- Interaction button (if callback)
    if callback then
        local actionBtn = Instance.new("TextButton")
        actionBtn.Name = "ActionBtn"
        actionBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
        actionBtn.BorderSizePixel = 0
        actionBtn.TextSize = 11
        actionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        actionBtn.Font = Enum.Font.GothamBold
        actionBtn.Text = "RUN"
        actionBtn.Size = UDim2.new(0, 60, 0, 25)
        actionBtn.Position = UDim2.new(0, 15, 0, 65)
        actionBtn.Parent = notificationFrame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = actionBtn
        
        -- Hover effect
        actionBtn.MouseEnter:Connect(function()
            actionBtn.BackgroundColor3 = Color3.fromRGB(120, 220, 255)
        end)
        
        actionBtn.MouseLeave:Connect(function()
            actionBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
        end)
        
        actionBtn.MouseButton1Click:Connect(function()
            callback()
            closeBtn:Destroy()
        end)
    end
    
    -- Play sound
    if sound then
        local soundEffect = Instance.new("Sound")
        soundEffect.SoundId = SOUNDS.SUCCESS
        soundEffect.Volume = 0.5
        soundEffect.Parent = notificationFrame
        soundEffect:Play()
        game:GetService("Debris"):AddItem(soundEffect, 2)
    end
    
    -- Close button functionality
    closeBtn.MouseButton1Click:Connect(function()
        notificationFrame:Destroy()
        table.remove(activeNotifications, table.find(activeNotifications, notificationFrame))
    end)
    
    -- Auto-remove after duration
    table.insert(activeNotifications, notificationFrame)
    task.wait(duration)
    if notificationFrame and notificationFrame.Parent then
        notificationFrame:Destroy()
    end
    
    return notificationFrame
end

-- Batch create multiple notifications
function Notifications:CreateBatch(notificationsArray)
    for i, notifConfig in ipairs(notificationsArray) do
        task.wait(0.2)
        self:Create(notifConfig)
    end
end

return Notifications

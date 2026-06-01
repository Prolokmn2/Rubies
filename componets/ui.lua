--[[
    UI Module
    Handles all UI creation and management
    Modern Hyper-X style design with draggable windows
]]

local UI = {}
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- Draggable window functionality
local function MakeDraggable(frame)
    local dragging = false
    local dragStart
    local startPos
    
    frame.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
        end
    end)
end

-- Create player info panel (bottom left corner)
local function CreatePlayerInfoPanel(parent, handler)
    local playerInfoPanel = Instance.new("Frame")
    playerInfoPanel.Name = "PlayerInfoPanel"
    playerInfoPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    playerInfoPanel.BorderSizePixel = 0
    playerInfoPanel.Size = UDim2.new(0, 240, 0, 90)
    playerInfoPanel.Position = UDim2.new(0, 20, 1, -110)
    playerInfoPanel.ZIndex = 50
    playerInfoPanel.Parent = parent
    
    -- Add corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = playerInfoPanel
    
    -- Border stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 150, 200)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = playerInfoPanel
    
    -- Player avatar
    local avatarBtn = Instance.new("ImageButton")
    avatarBtn.Name = "Avatar"
    avatarBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    avatarBtn.BorderSizePixel = 0
    avatarBtn.Size = UDim2.new(0, 60, 0, 60)
    avatarBtn.Position = UDim2.new(0, 10, 0, 15)
    avatarBtn.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=60&h=60"
    avatarBtn.Parent = playerInfoPanel
    
    local avatarCorner = Instance.new("UICorner")
    avatarCorner.CornerRadius = UDim.new(0, 8)
    avatarCorner.Parent = avatarBtn
    
    -- Username
    local userLabel = Instance.new("TextLabel")
    userLabel.Name = "Username"
    userLabel.BackgroundTransparency = 1
    userLabel.TextSize = 12
    userLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    userLabel.Font = Enum.Font.GothamBold
    userLabel.Text = LocalPlayer.DisplayName or LocalPlayer.Name
    userLabel.TextXAlignment = Enum.TextXAlignment.Left
    userLabel.Size = UDim2.new(0, 160, 0, 20)
    userLabel.Position = UDim2.new(0, 80, 0, 10)
    userLabel.Parent = playerInfoPanel
    
    -- User ID
    local idLabel = Instance.new("TextLabel")
    idLabel.Name = "UserID"
    idLabel.BackgroundTransparency = 1
    idLabel.TextSize = 10
    idLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    idLabel.Font = Enum.Font.Gotham
    idLabel.Text = "ID: " .. LocalPlayer.UserId
    idLabel.TextXAlignment = Enum.TextXAlignment.Left
    idLabel.Size = UDim2.new(0, 160, 0, 15)
    idLabel.Position = UDim2.new(0, 80, 0, 30)
    idLabel.Parent = playerInfoPanel
    
    -- HP Bar Container
    local hpBarBg = Instance.new("Frame")
    hpBarBg.Name = "HPBarBg"
    hpBarBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    hpBarBg.BorderSizePixel = 0
    hpBarBg.Size = UDim2.new(0, 160, 0, 8)
    hpBarBg.Position = UDim2.new(0, 80, 0, 55)
    hpBarBg.Parent = playerInfoPanel
    
    local hpCorner = Instance.new("UICorner")
    hpCorner.CornerRadius = UDim.new(0, 4)
    hpCorner.Parent = hpBarBg
    
    -- HP Bar Fill (water/liquid effect style)
    local hpBarFill = Instance.new("Frame")
    hpBarFill.Name = "HPBarFill"
    hpBarFill.BackgroundColor3 = Color3.fromRGB(100, 255, 150)
    hpBarFill.BorderSizePixel = 0
    hpBarFill.Size = UDim2.new(1, 0, 1, 0)
    hpBarFill.Parent = hpBarBg
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
    fillCorner.Parent = hpBarFill
    
    -- Update HP bar
    local function UpdateHPBar()
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            local hpPercent = humanoid.Health / humanoid.MaxHealth
            hpBarFill:TweenSize(UDim2.new(hpPercent, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.1, true)
        end
    end
    
    -- Listen for HP changes
    LocalPlayer.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").HealthChanged:Connect(UpdateHPBar)
    end)
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.HealthChanged:Connect(UpdateHPBar)
    end
    
    UpdateHPBar()
    
    return playerInfoPanel
end

-- Create main launcher panel
function UI:CreateLauncherPanel(parent, rubies)
    -- Create screen gui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RubiesLauncher"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndex = 50
    screenGui.Parent = parent
    
    -- Main launcher window
    local launcherFrame = Instance.new("Frame")
    launcherFrame.Name = "LauncherFrame"
    launcherFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    launcherFrame.BorderSizePixel = 0
    launcherFrame.Size = UDim2.new(0, 500, 0, 400)
    launcherFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    launcherFrame.ZIndex = 51
    launcherFrame.Parent = screenGui
    
    -- Add corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = launcherFrame
    
    -- Border stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 150, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Parent = launcherFrame
    
    -- Header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    header.BorderSizePixel = 0
    header.Size = UDim2.new(1, 0, 0, 60)
    header.Parent = launcherFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.BackgroundTransparency = 1
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.Text = "💎 RUBIES LAUNCHER"
    title.Size = UDim2.new(1, -80, 1, 0)
    title.Position = UDim2.new(0, 20, 0, 0)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseBtn"
    closeBtn.BackgroundTransparency = 1
    closeBtn.TextSize = 20
    closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "✕"
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Position = UDim2.new(1, -50, 0, 10)
    closeBtn.Parent = header
    
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Make header draggable
    MakeDraggable(header)
    
    -- Separator line
    local separator = Instance.new("Frame")
    separator.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    separator.BorderSizePixel = 0
    separator.Size = UDim2.new(1, 0, 0, 1)
    separator.Position = UDim2.new(0, 0, 0, 60)
    separator.Transparency = 0.5
    separator.Parent = launcherFrame
    
    -- Content area with scroll
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Name = "Content"
    contentFrame.BackgroundTransparency = 1
    contentFrame.BorderSizePixel = 0
    contentFrame.Size = UDim2.new(1, 0, 1, -140)
    contentFrame.Position = UDim2.new(0, 0, 0, 60)
    contentFrame.ScrollBarThickness = 6
    contentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.Parent = launcherFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 10)
    listLayout.Parent = contentFrame
    
    -- Game detected label
    local gameLabel = Instance.new("TextLabel")
    gameLabel.Name = "GameLabel"
    gameLabel.BackgroundTransparency = 1
    gameLabel.TextSize = 12
    gameLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    gameLabel.Font = Enum.Font.Gotham
    gameLabel.Text = "Detected Game: " .. (rubies.CurrentGame or "Universal")
    gameLabel.Size = UDim2.new(1, -20, 0, 30)
    gameLabel.Position = UDim2.new(0, 10, 0, 10)
    gameLabel.TextXAlignment = Enum.TextXAlignment.Left
    gameLabel.Parent = contentFrame
    
    -- Dynamic game buttons section
    local gameHeader = Instance.new("TextLabel")
    gameHeader.Name = "GamesHeader"
    gameHeader.BackgroundTransparency = 1
    gameHeader.TextSize = 11
    gameHeader.TextColor3 = Color3.fromRGB(200, 200, 220)
    gameHeader.Font = Enum.Font.GothamBold
    gameHeader.Text = "Available Games:"
    gameHeader.Size = UDim2.new(1, -20, 0, 20)
    gameHeader.TextXAlignment = Enum.TextXAlignment.Left
    gameHeader.Parent = contentFrame
    
    -- Get all games and load them dynamically
    local gameList = rubies.Handler:GetGameList()
    for _, gameInfo in ipairs(gameList) do
        local btn = Instance.new("TextButton")
        btn.Name = gameInfo.name .. "Btn"
        btn.BackgroundColor3 = Color3.fromRGB(gameInfo.color.R or 100, gameInfo.color.G or 150, gameInfo.color.B or 255)
        btn.BorderSizePixel = 0
        btn.TextSize = 11
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.Text = gameInfo.icon .. " " .. gameInfo.displayName
        btn.Size = UDim2.new(1, -20, 0, 35)
        btn.Parent = contentFrame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn
        
        -- Store game name for click handler
        local gameName = gameInfo.name
        
        -- Click handler
        btn.MouseButton1Click:Connect(function()
            if gameName ~= "universal" then
                rubies.Handler:LoadGameScript(gameName, btn)
            end
        end)
        
        -- Hover effect
        local originalColor = btn.BackgroundColor3
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = originalColor + Color3.fromRGB(30, 30, 30)
        end)
        
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = originalColor
        end)
    end
    
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
    end)
    
    -- Bottom button area
    local footerFrame = Instance.new("Frame")
    footerFrame.Name = "Footer"
    footerFrame.BackgroundTransparency = 1
    footerFrame.BorderSizePixel = 0
    footerFrame.Size = UDim2.new(1, 0, 0, 80)
    footerFrame.Position = UDim2.new(0, 0, 1, -80)
    footerFrame.Parent = launcherFrame
    
    -- Minimize button
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = "MinimizeBtn"
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.TextSize = 11
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.Text = "_"
    minimizeBtn.Size = UDim2.new(1, -20, 0, 30)
    minimizeBtn.Position = UDim2.new(0, 10, 0, 10)
    minimizeBtn.Parent = footerFrame
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 6)
    minCorner.Parent = minimizeBtn
    
    minimizeBtn.MouseButton1Click:Connect(function()
        local isMinimized = contentFrame.Visible
        contentFrame.Visible = not isMinimized
        header.Visible = not isMinimized
        separator.Visible = not isMinimized
        footerFrame.Visible = not isMinimized
        launcherFrame.Size = isMinimized and UDim2.new(0, 500, 0, 60) or UDim2.new(0, 500, 0, 400)
    end)
    
    -- Update button
    local updateBtn = Instance.new("TextButton")
    updateBtn.Name = "UpdateBtn"
    updateBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    updateBtn.BorderSizePixel = 0
    updateBtn.TextSize = 11
    updateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    updateBtn.Font = Enum.Font.GothamBold
    updateBtn.Text = "REFRESH"
    updateBtn.Size = UDim2.new(1, -20, 0, 30)
    updateBtn.Position = UDim2.new(0, 10, 0, 45)
    updateBtn.Parent = footerFrame
    
    local updateCorner = Instance.new("UICorner")
    updateCorner.CornerRadius = UDim.new(0, 6)
    updateCorner.Parent = updateBtn
    
    -- Create player info panel
    CreatePlayerInfoPanel(parent, nil)
    
    return {
        ScreenGui = screenGui,
        LauncherFrame = launcherFrame,
        ContentFrame = contentFrame,
        CloseBtn = closeBtn
    }
end

return UI

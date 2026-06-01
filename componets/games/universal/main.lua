--[[
    Universal Scripts
    Features: Infinite Jump (with platform), TP Walk, Speed Slider, Highlighter with Player TP
]]

local Universal = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Metadata for auto-detection
Universal.Metadata = {
    displayName = "Universal Scripts",
    icon = "[UNIVERSAL]",
    color = {R = 100, G = 200, B = 150},
    patterns = {"Character", "Humanoid"}
}

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- State variables
local jumpPlatform = nil
local isInfiniteJumpActive = false
local isTPWalkActive = false
local isHighlighterActive = false
local currentSpeed = 16
local tpGuiOpen = false

-- Initialize universal scripts
function Universal:Initialize(parentUI)
    print("🌍 Initializing Universal Scripts...")
    
    self:CreateUniversalUI(parentUI)
    self:SetupCharacterHandling()
end

-- Setup character respawn handling
function Universal:SetupCharacterHandling()
    LocalPlayer.CharacterAdded:Connect(function(newCharacter)
        Character = newCharacter
        Humanoid = Character:WaitForChild("Humanoid")
        isInfiniteJumpActive = false
        isTPWalkActive = false
        if jumpPlatform then jumpPlatform:Destroy() end
        print("✅ Character respawned - scripts reset")
    end)
end

-- Create UI for universal features
function Universal:CreateUniversalUI(parentUI)
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Create screen gui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UniversalFeaturesUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndex = 40
    screenGui.Parent = playerGui
    
    -- Main features window
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "FeaturesFrame"
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.Size = UDim2.new(0, 280, 0, 350)
    mainFrame.Position = UDim2.new(1, -300, 0.5, -175)
    mainFrame.ZIndex = 41
    mainFrame.Parent = screenGui
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    -- Border
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 200, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.3
    stroke.Parent = mainFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.TextSize = 16
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.Text = "🌍 UNIVERSAL"
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
    
    -- Infinite Jump Toggle
    self:CreateToggleButton(scrollFrame, "🦘 Infinite Jump", function(state)
        isInfiniteJumpActive = state
        if state then
            self:StartInfiniteJump()
        end
    end)
    
    -- TP Walk Toggle
    self:CreateToggleButton(scrollFrame, "🚶 TP Walk", function(state)
        isTPWalkActive = state
        if state then
            self:StartTPWalk()
        else
            self:StopTPWalk()
        end
    end)
    
    -- Speed Slider
    self:CreateSpeedSlider(scrollFrame)
    
    -- Highlighter Toggle
    self:CreateToggleButton(scrollFrame, "✨ Highlighter", function(state)
        isHighlighterActive = state
        if state then
            self:StartHighlighter()
        else
            self:StopHighlighter()
        end
    end)
    
    -- Player TP Button
    self:CreateTPPlayerButton(scrollFrame, screenGui)
    
    -- Update canvas size
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
    end)
end

-- Create toggle button
function Universal:CreateToggleButton(parent, text, callback)
    local buttonContainer = Instance.new("Frame")
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Size = UDim2.new(1, -16, 0, 35)
    buttonContainer.Parent = parent
    
    local button = Instance.new("TextButton")
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    button.BorderSizePixel = 0
    button.TextSize = 12
    button.TextColor3 = Color3.fromRGB(200, 200, 220)
    button.Font = Enum.Font.Gotham
    button.Text = text .. " [OFF]"
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Parent = buttonContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = button
    
    local isActive = false
    
    button.MouseButton1Click:Connect(function()
        isActive = not isActive
        button.BackgroundColor3 = isActive and Color3.fromRGB(100, 200, 150) or Color3.fromRGB(50, 50, 70)
        button.TextColor3 = isActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 220)
        button.Text = text .. (isActive and " [ON]" or " [OFF]")
        callback(isActive)
    end)
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = isActive and Color3.fromRGB(120, 220, 170) or Color3.fromRGB(70, 70, 90)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = isActive and Color3.fromRGB(100, 200, 150) or Color3.fromRGB(50, 50, 70)
    end)
    
    return button
end

-- Create speed slider
function Universal:CreateSpeedSlider(parent)
    local sliderContainer = Instance.new("Frame")
    sliderContainer.BackgroundTransparency = 1
    sliderContainer.Size = UDim2.new(1, -16, 0, 50)
    sliderContainer.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.TextSize = 11
    label.TextColor3 = Color3.fromRGB(200, 200, 220)
    label.Font = Enum.Font.Gotham
    label.Text = "⚡ Speed: 16"
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Parent = sliderContainer
    
    local sliderBg = Instance.new("Frame")
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    sliderBg.BorderSizePixel = 0
    sliderBg.Size = UDim2.new(1, 0, 0, 8)
    sliderBg.Position = UDim2.new(0, 0, 0, 25)
    sliderBg.Parent = sliderContainer
    
    local sliderFill = Instance.new("Frame")
    sliderFill.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
    sliderFill.BorderSizePixel = 0
    sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    sliderFill.Parent = sliderBg
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
    sliderButton.BorderSizePixel = 0
    sliderButton.Text = ""
    sliderButton.Size = UDim2.new(0, 12, 1, 6)
    sliderButton.Position = UDim2.new(0.5, -6, 0, -3)
    sliderButton.Parent = sliderBg
    
    local isDragging = false
    
    sliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
        end
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local relativeX = input.Position.X - sliderBg.AbsolutePosition.X
            local percent = math.clamp(relativeX / sliderBg.AbsoluteSize.X, 0, 1)
            
            sliderFill:TweenSize(UDim2.new(percent, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.05, true)
            sliderButton:TweenPosition(UDim2.new(percent, -6, 0, -3), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.05, true)
            
            currentSpeed = math.floor(percent * 100) + 1
            label.Text = "⚡ Speed: " .. currentSpeed
            
            -- Update character speed
            if Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid.WalkSpeed = currentSpeed
            end
        end
    end)
end

-- Create player TP button
function Universal:CreateTPPlayerButton(parent, screenGui)
    local button = Instance.new("TextButton")
    button.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    button.BorderSizePixel = 0
    button.TextSize = 12
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.Text = "👥 Player Teleport"
    button.Size = UDim2.new(1, -16, 0, 35)
    button.Position = UDim2.new(0, 8, 0, 0)
    button.Parent = parent
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        self:CreatePlayerTPWindow(screenGui)
    end)
end

-- Infinite Jump implementation
function Universal:StartInfiniteJump()
    local jumpConnection
    jumpConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.Space then
            if Character and Humanoid then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                
                -- Create platform beneath player
                if not jumpPlatform or not jumpPlatform.Parent then
                    jumpPlatform = Instance.new("Part")
                    jumpPlatform.Shape = Enum.PartType.Block
                    jumpPlatform.Material = Enum.Material.Neon
                    jumpPlatform.CanCollide = true
                    jumpPlatform.Size = Vector3.new(4, 0.5, 4)
                    jumpPlatform.CFrame = Character.HumanoidRootPart.CFrame + Vector3.new(0, -3, 0)
                    jumpPlatform.CanQuery = false
                    jumpPlatform.Parent = workspace
                    
                    game:GetService("Debris"):AddItem(jumpPlatform, 0.3)
                end
            end
        end
    end)
    
    -- Store connection for cleanup
    self._jumpConnection = jumpConnection
end

-- TP Walk implementation
function Universal:StartTPWalk()
    local lastPos = Character.HumanoidRootPart.Position
    
    self._tpWalkConnection = RunService.RenderStepped:Connect(function()
        if not isTPWalkActive or not Character or not Character:FindFirstChild("Humanoid") then return end
        
        local moveDirection = Character.Humanoid.MoveDirection
        if moveDirection.Magnitude > 0 then
            local offset = moveDirection * 0.5
            Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame + offset
        end
    end)
end

function Universal:StopTPWalk()
    if self._tpWalkConnection then
        self._tpWalkConnection:Disconnect()
    end
end

-- Highlighter implementation
function Universal:StartHighlighter()
    self._highlighterConnection = RunService.RenderStepped:Connect(function()
        if not isHighlighterActive then return end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local character = player.Character
                
                -- Add highlight
                if not character:FindFirstChild("Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = character
                    highlight.FillColor = Color3.fromRGB(255, 100, 100)
                    highlight.FillTransparency = 0.3
                    highlight.OutlineColor = Color3.fromRGB(255, 200, 0)
                end
                
                -- Draw line (tracer)
                local from = Character.HumanoidRootPart.Position
                local to = character.HumanoidRootPart.Position
                -- In a real implementation, you'd use debug drawing or client-side rendering
            end
        end
    end)
end

function Universal:StopHighlighter()
    if self._highlighterConnection then
        self._highlighterConnection:Disconnect()
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local highlight = player.Character:FindFirstChild("Highlight")
            if highlight then highlight:Destroy() end
        end
    end
end

-- Create Player TP window
function Universal:CreatePlayerTPWindow(parentGui)
    if tpGuiOpen then return end
    tpGuiOpen = true
    
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PlayerTPWindow"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndex = 45
    screenGui.Parent = playerGui
    
    -- Main window
    local window = Instance.new("Frame")
    window.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    window.BorderSizePixel = 0
    window.Size = UDim2.new(0, 250, 0, 350)
    window.Position = UDim2.new(0.5, -125, 0.5, -175)
    window.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = window
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 150, 255)
    stroke.Thickness = 2
    stroke.Parent = window
    
    -- Title
    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.TextSize = 14
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.Text = "👥 Players"
    title.Size = UDim2.new(1, -40, 0, 35)
    title.Parent = window
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.BackgroundTransparency = 1
    closeBtn.TextSize = 16
    closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "✕"
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.Parent = window
    
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        tpGuiOpen = false
    end)
    
    -- Player list
    local listFrame = Instance.new("ScrollingFrame")
    listFrame.BackgroundTransparency = 1
    listFrame.BorderSizePixel = 0
    listFrame.Size = UDim2.new(1, 0, 1, -35)
    listFrame.Position = UDim2.new(0, 0, 0, 35)
    listFrame.ScrollBarThickness = 5
    listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    listFrame.Parent = window
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 5)
    listLayout.Parent = listFrame
    
    -- Populate player list
    local function UpdatePlayerList()
        listFrame:ClearAllChildren()
        listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0, 5)
        listLayout.Parent = listFrame
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local playerBtn = Instance.new("Frame")
                playerBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
                playerBtn.BorderSizePixel = 0
                playerBtn.Size = UDim2.new(1, -10, 0, 50)
                playerBtn.Parent = listFrame
                
                local playerCorner = Instance.new("UICorner")
                playerCorner.CornerRadius = UDim.new(0, 6)
                playerCorner.Parent = playerBtn
                
                -- Player name
                local nameLabel = Instance.new("TextLabel")
                nameLabel.BackgroundTransparency = 1
                nameLabel.TextSize = 11
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameLabel.Font = Enum.Font.GothamBold
                nameLabel.Text = player.DisplayName or player.Name
                nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                nameLabel.Size = UDim2.new(0.7, 0, 0, 20)
                nameLabel.Position = UDim2.new(0, 8, 0, 5)
                nameLabel.Parent = playerBtn
                
                -- HP Label
                local hpLabel = Instance.new("TextLabel")
                hpLabel.BackgroundTransparency = 1
                hpLabel.TextSize = 10
                hpLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
                hpLabel.Font = Enum.Font.Gotham
                hpLabel.Text = "HP"
                hpLabel.TextXAlignment = Enum.TextXAlignment.Left
                hpLabel.Size = UDim2.new(1, 0, 0, 15)
                hpLabel.Position = UDim2.new(0, 8, 0, 25)
                hpLabel.Parent = playerBtn
                
                -- TP Button
                local tpBtn = Instance.new("TextButton")
                tpBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                tpBtn.BorderSizePixel = 0
                tpBtn.TextSize = 10
                tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                tpBtn.Font = Enum.Font.GothamBold
                tpBtn.Text = "TP"
                tpBtn.Size = UDim2.new(0, 35, 0, 25)
                tpBtn.Position = UDim2.new(1, -43, 0, 5)
                tpBtn.Parent = playerBtn
                
                local tpCorner = Instance.new("UICorner")
                tpCorner.CornerRadius = UDim.new(0, 4)
                tpCorner.Parent = tpBtn
                
                tpBtn.MouseButton1Click:Connect(function()
                    if Character and player.Character then
                        Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                    end
                end)
            end
        end
        
        listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            listFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
        end)
    end
    
    UpdatePlayerList()
    
    -- Refresh when players join/leave
    Players.PlayerAdded:Connect(UpdatePlayerList)
    Players.PlayerRemoving:Connect(UpdatePlayerList)
end

return Universal

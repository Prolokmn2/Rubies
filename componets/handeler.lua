--[[
    Handler Module v2.0
    Auto-detects and loads game scripts dynamically
    No hardcoding needed - adds new games automatically!
]]

local Handler = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Game cache
Handler.GameCache = {}
Handler.DetectedGame = nil

-- Auto-scan games folder and build game signatures
local function ScanGamesFolder()
    local gamesFolder = script.Parent:FindFirstChild("games")
    local signatures = {}
    
    if not gamesFolder then
        warn("Games folder not found!")
        return signatures
    end
    
    -- Scan all subfolders in games/
    for _, gameFolder in pairs(gamesFolder:GetChildren()) do
        if gameFolder:IsA("Folder") and gameFolder:FindFirstChild("main") then
            local gameName = gameFolder.Name
            local mainScript = gameFolder:FindFirstChild("main")
            
            -- Try to load metadata from game script
            local success, gameModule = pcall(function()
                return require(mainScript)
            end)
            
            if success and gameModule then
                local metadata = gameModule.Metadata or {}
                
                signatures[gameName] = {
                    name = gameName,
                    displayName = metadata.displayName or gameName,
                    icon = metadata.icon or "📦",
                    color = metadata.color or {R = 100, G = 150, B = 255},
                    patterns = metadata.patterns or {gameName},
                    module = gameModule,
                    folder = gameFolder
                }
                
                print("Found game: " .. gameName)
            end
        end
    end
    
    return signatures
end

-- Detect current game
function Handler:DetectGame()
    if self.DetectedGame then
        return self.DetectedGame
    end
    
    -- Scan games if not already done
    if not next(self.GameCache) then
        self.GameCache = ScanGamesFolder()
    end
    
    local workspace = game:GetService("Workspace")
    local detectedGame = nil
    
    -- Check for game-specific folders/objects
    for gameName, config in pairs(self.GameCache) do
        if workspace:FindFirstChild(gameName) then
            detectedGame = gameName
            break
        end
    end
    
    -- Check by patterns
    if not detectedGame then
        for gameName, config in pairs(self.GameCache) do
            for _, pattern in pairs(config.patterns) do
                if workspace:FindFirstChild(pattern) then
                    detectedGame = gameName
                    break
                end
            end
            if detectedGame then break end
        end
    end
    
    -- Fallback
    self.DetectedGame = detectedGame or "universal"
    return self.DetectedGame
end

-- Get all available games
function Handler:GetAllGames()
    if not next(self.GameCache) then
        self.GameCache = ScanGamesFolder()
    end
    return self.GameCache
end

-- Get game metadata
function Handler:GetGameMetadata(gameName)
    local allGames = self:GetAllGames()
    return allGames[gameName]
end

-- Load game script with error handling
function Handler:LoadGameScript(gameName, parentUI)
    local metadata = self:GetGameMetadata(gameName)
    
    if not metadata then
        warn("Game not found: " .. gameName)
        return false
    end
    
    if not metadata.module then
        print("Loading game script: " .. gameName)
        local success, module = pcall(function()
            return require(metadata.folder:FindFirstChild("main"))
        end)
        
        if not success then
            warn("Failed to load " .. gameName)
            return false
        end
        
        metadata.module = module
    end
    
    -- Initialize if available
    if metadata.module and metadata.module.Initialize then
        local initSuccess, initErr = pcall(function()
            metadata.module:Initialize(parentUI)
        end)
        
        if not initSuccess then
            warn("Error initializing " .. gameName .. ": " .. tostring(initErr))
            return false
        end
    end
    
    return true
end

-- Load all games except universal
function Handler:LoadAllGameScripts(parentUI)
    local allGames = self:GetAllGames()
    local loaded = {}
    
    for gameName, metadata in pairs(allGames) do
        if gameName ~= "universal" then
            local success = self:LoadGameScript(gameName, parentUI)
            if success then
                table.insert(loaded, gameName)
            end
        end
    end
    
    return loaded
end

-- Load universal scripts
function Handler:LoadUniversalScripts(parentUI)
    return self:LoadGameScript("universal", parentUI)
end

-- Get all game names for UI
function Handler:GetGameList()
    local allGames = self:GetAllGames()
    local gameList = {}
    
    for gameName, metadata in pairs(allGames) do
        table.insert(gameList, {
            name = gameName,
            displayName = metadata.displayName,
            icon = metadata.icon,
            color = metadata.color
        })
    end
    
    table.sort(gameList, function(a, b)
        if a.name == "universal" then return false end
        if b.name == "universal" then return true end
        return a.name < b.name
    end)
    
    return gameList
end

-- Get player data
function Handler:GetPlayerData(player)
    return {
        Player = player,
        UserId = player.UserId,
        Username = player.Name,
        DisplayName = player.DisplayName or player.Name,
        Character = player.Character,
        HP = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or 0,
        MaxHP = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.MaxHealth or 100
    }
end

-- Get all connected players
function Handler:GetAllPlayers()
    return Players:GetPlayers()
end

-- Cache game modules for quick access
function Handler:CacheGameModule(gameName, module)
    local allGames = self:GetAllGames()
    if allGames[gameName] then
        allGames[gameName].module = module
    end
end

return Handler

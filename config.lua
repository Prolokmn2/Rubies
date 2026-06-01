--[[
    RUBIES Config
    Main configuration file for the admin panel
]]

local Config = {
    -- GitHub Configuration
    GitHub = {
        Username = "Prolokmn2",
        Repository = "Rubies",
        Branch = "main",
        BaseURL = "https://raw.githubusercontent.com/Prolokmn2/Rubies/main/"
    },
    
    -- Admin Panel Settings
    Panel = {
        Version = "1.0",
        Title = "RUBIES LAUNCHER",
        Key = "auraman",
        AutoDetectGame = true,
        MinimizeOnLoad = false
    },
    
    -- Notification Settings
    Notifications = {
        DefaultDuration = 3,
        RecommendationDuration = 5,
        SoundEnabled = true,
        StackPosition = "TopRight"
    },
    
    -- Universal Features
    Features = {
        InfiniteJump = true,
        TPWalk = true,
        SpeedSlider = true,
        Highlighter = true,
        PlayerTP = true,
        DebugPanel = true
    },
    
    -- UI Theme (Color3.fromRGB)
    Theme = {
        Primary = {R = 20, G = 20, B = 30},      -- Dark background
        Secondary = {R = 30, G = 30, B = 45},    -- Lighter background
        Accent = {R = 100, G = 150, B = 255},    -- Blue accent
        Success = {R = 100, G = 200, B = 150},   -- Green
        Warning = {R = 255, G = 150, B = 100},   -- Orange
        Danger = {R = 255, G = 100, B = 100}     -- Red
    }
}

return Config

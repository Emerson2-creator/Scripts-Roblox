repeat wait() until game:IsLoaded()
local Starlight = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/starlight"))()  
local NebulaIcons = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/nebula-icon-library-loader"))()

local Window = Starlight:CreateWindow({
    Name = "EmeX Hub",
    Subtitle = "Made by Emerson",
    Icon = 0,

    LoadingSettings = {
        Title = "EmeX Hub",
        Subtitle = "Welcome to EmeX Hub",
    },

    ConfigurationSettings = {
        FolderName = "EmeX-Hub-Config"
    },
})

local PlayerTabSection = Window:CreateTabSection("Player")

local Main = PlayerTabSection:CreateTab({
    Name = "Main",
    Icon = NebulaIcons:GetIcon('user', 'Lucide'),
    Columns = 2,
}, "INDEX")

--
local LocalPlayerGroupbox = Main:CreateGroupbox({
    Name = "Local Player",
    Column = 1,
}, "INDEX")

local WorldGroupbox = Main:CreateGroupbox({
    Name = "World",
    Column = 2,
}, "INDEX")
--

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local lighting = game.Lighting


-- [[ local player groupbox
local defaultWalkSpeed = humanoid.WalkSpeed
local defaultUsingJumpPower = humanoid.UseJumpPower
local defaultJumpPower = humanoid.JumpPower
local defaultJumpHeight = humanoid.JumpHeight
local defaultFieldOfView = workspace.CurrentCamera.FieldOfView
local defaultClockTime = lighting.ClockTime
local defaultUsingShadows = lighting.GlobalShadows

local walkSpeedSlider = LocalPlayerGroupbox:CreateSlider({
    Name = "Walk Speed",
    Tooltip = "Change your walk speed.",
    Icon = NebulaIcons:GetIcon('chevrons-up', 'Lucide'),
    Range = {0,500},
    Increment = 1,
    CurrentValue = defaultWalkSpeed,
    Callback = function(Value)
        _G.GlobalWalkSpeed = Value
        --print(_G.GlobalWalkSpeed)

        humanoid.WalkSpeed = Value
    end,
}, "INDEX")


local usingJumpPowerToggle = LocalPlayerGroupbox:CreateToggle({
    Name = "Using Jump Power",
    Tooltip = "Toggle the use of jump power or jump height.",
    CurrentValue = defaultUsingJumpPower,
    Style = 2,
    Callback = function(Value)
        _G.GlobalUsingJumpPower = Value
        humanoid.UseJumpPower = Value
    end,
}, "INDEX")

local JumpPowerSlider = LocalPlayerGroupbox:CreateSlider({
    Name = "Jump Power",
    Tooltip = "Change your jump power.",
    Icon = NebulaIcons:GetIcon('chevrons-up', 'Lucide'),
    Range = {0,500},
    Increment = 1,
    CurrentValue = defaultJumpPower,
    Callback = function(Value)
        _G.GlobalJumpPowerValue = Value
        --print(_G.GlobalJumpPowerValue)

        humanoid.JumpPower = Value
    end,
}, "INDEX")

local JumpHeightSlider = LocalPlayerGroupbox:CreateSlider({
    Name = "Jump Height",
    Tooltip = "Change your jump height.",
    Icon = NebulaIcons:GetIcon('chevrons-up', 'Lucide'),
    Range = {0,500},
    Increment = 1,
    CurrentValue = defaultJumpHeight,
    Callback = function(Value)
        _G.GlobalJumpHeightValue = Value
        --print(_G.GlobalJumpHeightValue)

        humanoid.JumpHeight = Value
    end,
}, "INDEX")

local FovSlider = LocalPlayerGroupbox:CreateSlider({
    Name = "Field of View",
    Tooltip = "Change your field of view.",
    Icon = NebulaIcons:GetIcon('chevrons-up', 'Lucide'),
    Range = {0,120},
    Increment = 1,
    CurrentValue = defaultFieldOfView,
    Callback = function(Value)
        _G.GlobalFieldOfViewValue = Value
        --print(_G.GlobalFieldOfViewValue)

        workspace.CurrentCamera.FieldOfView = Value
    end,
}, "INDEX")

-- [[ world groupbox
local ClockTimeInput = WorldGroupbox:CreateInput({
    Name = "Clock Time",
    Icon = NebulaIcons:GetIcon('text-cursor-input', 'Lucide'),
    CurrentValue = tostring(defaultClockTime),
    PlaceholderText = "change clock time",
    Numeric = true,
    Callback = function(Text)
        local number = tonumber(Text)
        if number then
            lighting.ClockTime = number
        else
            print("Please enter a valid number.")
        end
    end,
}, "INDEX")

local GravityInput = WorldGroupbox:CreateInput({
    Name = "Gravity",
    Icon = NebulaIcons:GetIcon('text-cursor-input', 'Lucide'),
    CurrentValue = tostring(workspace.Gravity),
    PlaceholderText = "change gravity",
    Numeric = true,
    Callback = function(Text)
        local number = tonumber(Text)
        if number then
            workspace.Gravity = number
        else
            print("Please enter a valid number.")
        end
    end,
}, "INDEX")

local ShadowsToggle = WorldGroupbox:CreateToggle({
    Name = "Global Shadows",
    Tooltip = "Toggle the use of shadows.",
    CurrentValue = defaultUsingShadows,
    Style = 2,
    Callback = function(Value)
        lighting.GlobalShadows = Value
    end,
}, "INDEX")


local function loadSettings()
    if player.Character then
        humanoid = player.Character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = _G.GlobalWalkSpeed
        humanoid.JumpPower = _G.GlobalJumpPowerValue
        humanoid.UseJumpPower = _G.GlobalUsingJumpPower
        humanoid.JumpHeight = _G.GlobalJumpHeightValue
        workspace.CurrentCamera.FieldOfView = _G.GlobalFieldOfViewValue
    else
        error("Humanoid not found or character not loaded")
    end
end loadSettings()

local function onCharacterAdded(character)
    humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = _G.GlobalWalkSpeed
    humanoid.JumpPower = _G.GlobalJumpPowerValue
    humanoid.UseJumpPower = _G.GlobalUsingJumpPower
    humanoid.JumpHeight = _G.GlobalJumpHeightValue
    workspace.CurrentCamera.FieldOfView = _G.GlobalFieldOfViewValue
    print("Tudo reaplicado!")
end

player.CharacterAdded:Connect(onCharacterAdded)


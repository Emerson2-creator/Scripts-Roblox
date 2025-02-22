local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Emerson2-creator/Universal-GUI-Script/refs/heads/main/RealCode'))()

-- Settings GUI

local Window = Rayfield:CreateWindow({
    Name = "Universal GUI",
    Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
    LoadingTitle = "Universal Hub",
    LoadingSubtitle = "By BOITONETO",
    Theme = "DarkBlue", -- Check https://docs.sirius.menu/rayfield/configuration/themes

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Just Hub"
    },

    Discord = {
       Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },

    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})

-- Tab

local MainTab = Window:CreateTab("🏠Home", nil) -- Title, Image

-- Section

local MainSection = MainTab:CreateSection("Basic Settings")

Rayfield:Notify({
    Title = "You executed the script",
    Content = "Very good GUI",
    Duration = 4.5,
    Image = nil,
})

-- Speed

local SpeedSlider = MainTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {0, 500},
    Increment = 5,
    Suffix = "WalkSpeed",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
 })

-- Jump

local JumpSlider = MainTab:CreateSlider({
    Name = "JumpPower",
    Range = {0, 500},
    Increment = 5,
    Suffix = "JumpPower",
    CurrentValue = 50,
    Flag = "JumpPowerSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end,
 })

-- Gravity

local GravitySlider = MainTab:CreateSlider({
    Name = "Gravity",
    Range = {0, 1000},
    Increment = 5,
    Suffix = "Gravity",
    CurrentValue = 196.2,
    Flag = "GravitySlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        game.Workspace.Gravity = Value
    end,
 })

-- No stun

local Input = MainTab:CreateInput({
   Name = "No Stun WalkSpeed (put -1 to decrease)",
   CurrentValue = "",
   PlaceholderText = "No Stun WalkSpeed",
   RemoveTextAfterFocusLost = false,
   Flag = "Input4",
   Callback = function(Text)
       local function isNumber(str)
           return tonumber(str) ~= nil or str == 'inf'
       end
       local tspeed = tonumber(Text)
       local hb = game:GetService("RunService").Heartbeat
       local tpwalking = true
       local player = game:GetService("Players")
       local lplr = player.LocalPlayer
       local chr = lplr.Character
       local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
       while tpwalking and hb:Wait() and chr and hum and hum.Parent do
           if hum.MoveDirection.Magnitude > 0 then
               if tspeed and isNumber(tspeed) then
                   chr:TranslateBy(hum.MoveDirection * tspeed)
               else
                   chr:TranslateBy(hum.MoveDirection)
               end
           end
       end
   end,
})

-- Spin

local spinSpeed = 50  -- Default rotation speed

-- Slider to set spin speed
local SpinSlider = MainTab:CreateSlider({
    Name = "Spin Speed",
    Range = {0, 100},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 50,
    Flag = "SpinSpeedSlider",
    Callback = function(Value)
        spinSpeed = Value
        local plr = game:GetService("Players").LocalPlayer
        repeat task.wait() until plr.Character
        local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
        local humanoid = plr.Character:WaitForChild("Humanoid")

        -- Remove existing spin if any
        for _, child in pairs(humRoot:GetChildren()) do
            if child.Name == "Spinbot" then
                child:Destroy()
            end
        end

        if spinSpeed > 0 then
            -- Enable rotation
            local velocity = Instance.new("AngularVelocity")
            velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
            velocity.MaxTorque = math.huge
            velocity.AngularVelocity = Vector3.new(0, spinSpeed, 0)
            velocity.Parent = humRoot
            velocity.Name = "Spinbot"
            humanoid.AutoRotate = false
        else
            -- Disable rotation
            humanoid.AutoRotate = true -- Re-enable auto rotation
        end
    end,
})

-- Noclip

local Noclip = nil
local Clip = nil

function noclip()
    Clip = false
    local function Nocl()
        if Clip == false and game.Players.LocalPlayer.Character ~= nil then
            for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                    v.CanCollide = false
                end
            end
        end
        wait(0.21) -- basic optimization
    end
    Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
    if Noclip then Noclip:Disconnect() end
    Clip = true
end

-- Toggle to enable/disable noclip
local Toggle = MainTab:CreateToggle({
    Name = "Noclip", -- Toggle name
    CurrentValue = false, -- Initial value
    Flag = "ToggleNoclip", -- Flag is the identifier for the config file
    Callback = function(Value)
        if Value then
            noclip()
        else
            clip()
        end
    end,
})

-- ESP

local player = game.Players.LocalPlayer
local espEnabled = false
local connections = {} -- Stores connections to disconnect later

-- Function to create ESP on a player
local function createESP(plr)
    if plr == player then return end -- Avoid creating ESP on self

    local character = plr.Character or plr.CharacterAdded:Wait()
    local highlight = Instance.new("Highlight")
    highlight.Parent = character
    highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Red color
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0

    -- Store connection to remove later
    local conn = plr.CharacterAdded:Connect(function(newChar)
        highlight.Parent = newChar
    end)
    table.insert(connections, {plr, highlight, conn})
end

-- Function to toggle ESP
local function toggleESP(state)
    espEnabled = state

    if espEnabled then
        -- Enable ESP for all players
        for _, plr in pairs(game.Players:GetPlayers()) do
            createESP(plr)
        end

        -- Connection for new players joining the game
        local newPlayerConn = game.Players.PlayerAdded:Connect(function(plr)
            createESP(plr)
        end)
        table.insert(connections, {nil, nil, newPlayerConn})
    else
        -- Remove ESP from all players
        for _, data in pairs(connections) do
            if data[2] then data[2]:Destroy() end -- Remove Highlight
            if data[3] then data[3]:Disconnect() end -- Disconnect events
        end
        connections = {} -- Reset connection list
    end
end

-- Toggle to enable/disable ESP
local Toggle = MainTab:CreateToggle({
    Name = "ESP", -- Toggle name
    CurrentValue = false, -- Initial value
    Flag = "Toggle2", -- Flag is the identifier for the config file
    Callback = function(Value)
        toggleESP(Value) -- Call function to enable/disable ESP
    end,
})

-- Xray

local player = game.Players.LocalPlayer
local xrayEnabled = false
local connections = {} -- Stores connections to disconnect later

-- Function to toggle Xray effect
local function toggleXray(state)
    xrayEnabled = state

    if xrayEnabled then
        -- Enable Xray for all objects (except character)
        for _, part in pairs(game.Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Parent ~= player.Character then
                part.CanCollide = true -- Remove collision to "see" through walls
                part.Transparency = 0.5 -- Make objects partially transparent
            end
        end

        -- Connection for new objects added to the game
        local newPartConn = game.Workspace.DescendantAdded:Connect(function(part)
            if part:IsA("BasePart") and part.Parent ~= player.Character then
                part.CanCollide = true
                part.Transparency = 0.5
            end
        end)
        table.insert(connections, {newPartConn})
    else
        -- Disable Xray by restoring transparency and collision of objects
        for _, part in pairs(game.Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Parent ~= player.Character then
                part.CanCollide = true
                part.Transparency = 0 -- Restore original transparency
            end
        end

        -- Disconnect function for new objects
        for _, conn in pairs(connections) do
            conn[1]:Disconnect()
        end
        connections = {} -- Reset connection list
    end
end

-- Toggle to enable/disable Xray
local Toggle = MainTab:CreateToggle({
    Name = "Xray", -- Toggle name
    CurrentValue = false, -- Initial value
    Flag = "ToggleXray", -- Flag is the identifier for the config file
    Callback = function(Value)
        toggleXray(Value) -- Call function to enable/disable Xray
    end,
})

-- Fly

local Button = MainTab:CreateButton({
    Name = "Fly",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Emerson2-creator/UniversalGuiScript/refs/heads/main/Code/Scripts/GUI-Scripts/FlyGui.lua"))()
    end,
})

-- Walk on walls

local Button = MainTab:CreateButton({
    Name = "Walk on walls (Don't use with noclip)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/wallwalker.lua"))()
    end,
})

-- Função para obter a raiz do personagem
local function getRoot(char)
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
end

-- Toggle to enable/disable fling
local flingEnabled = false
local flingConnection

local function activateFling(player)
    flingEnabled = true
    for _, child in pairs(player.Character:GetDescendants()) do
        if child:IsA("BasePart") then
            child.CustomPhysicalProperties = PhysicalProperties.new(math.huge, 0.3, 0.5)
        end
    end

    -- Ativa o modo noclip
    local noclipConnection
    noclipConnection = game:GetService("RunService").Stepped:Connect(function()
        if not flingEnabled then
            noclipConnection:Disconnect()
        end
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end)

    wait(.1)
    local bambam = Instance.new("BodyAngularVelocity")
    bambam.Name = "FlingVelocity"
    bambam.Parent = getRoot(player.Character)
    bambam.AngularVelocity = Vector3.new(0, 99999, 0)
    bambam.MaxTorque = Vector3.new(0, math.huge, 0)
    bambam.P = math.huge
    local Char = player.Character:GetChildren()
    for i, v in next, Char do
        if v:IsA("BasePart") then
            v.CanCollide = false
            v.Massless = true
            v.Velocity = Vector3.new(0, 0, 0)
        end
    end
    flingConnection = game:GetService("RunService").Stepped:Connect(function()
        if not flingEnabled then
            flingConnection:Disconnect()
        end
        bambam.AngularVelocity = Vector3.new(0, 99999, 0)
        wait(.2)
        bambam.AngularVelocity = Vector3.new(0, 0, 0)
        wait(.1)
    end)
end

local function deactivateFling(player)
    flingEnabled = false
    wait(.1)
    local playerChar = player.Character
    if not playerChar or not getRoot(playerChar) then return end
    for i, v in pairs(getRoot(playerChar):GetChildren()) do
        if v.ClassName == 'BodyAngularVelocity' then
            v:Destroy()
        end
    end
    for _, child in pairs(playerChar:GetDescendants()) do
        if child.ClassName == "Part" or child.ClassName == "MeshPart" then
            child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
        end
    end
end

local Toggle = MainTab:CreateToggle({
    Name = "Fling", -- Toggle name
    CurrentValue = false, -- Initial value
    Flag = "ToggleFling", -- Flag is the identifier for the config file
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if Value then
            activateFling(player)
        else
            deactivateFling(player)
        end
    end,
})



-- SUS Scripts

local function isNumber(str)
    return tonumber(str) ~= nil or str == 'inf'
end

--New Tab

local SusTab = Window:CreateTab("🔥Sus", nil) -- Title, Image

local SusSection = SusTab:CreateSection("SUS Script")

-- Button to load the "Jerk" script
local jerkButton = SusTab:CreateButton({
    Name = "Jerk (R6, Not by me)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))("Spider Script")
    end,
})

-- Button to load the "Sus GUI" script
local susGuiButton = SusTab:CreateButton({
    Name = "Sus GUI (Not by me)",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/FWwdST5Y"))()
    end,
})

-- Button to load the "Freaky GUI" script
local freakyGuiButton = SusTab:CreateButton({
    Name = "Freaky GUI (R6, Not by me)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ShutUpJamesTheLoser/freaky/refs/heads/main/fe", true))()
    end,
})

-- Tool Tab

local ToolTab = Window:CreateTab("🛠️Tools", nil) -- Title, Image

-- Section

local MainSection = ToolTab:CreateSection("Tools")

local Button = ToolTab:CreateButton({
    Name = "Run Tool",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Emerson2-creator/UniversalGuiScript/refs/heads/main/Code/Scripts/runtool.lua'))()
    end,
})

-- Button to load the "Tp Tool" script

local tpToolButton = ToolTab:CreateButton({
    Name = "Tp Tool",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Emerson2-creator/UniversalGuiScript/refs/heads/main/Code/Scripts/tptool.lua'))()
    end,
})

--Section 2

local MainSection = ToolTab:CreateSection("Comming Soon...")

--Scripts Tab

local ScriptTab = Window:CreateTab("📜Scripts", nil) -- Title, Image
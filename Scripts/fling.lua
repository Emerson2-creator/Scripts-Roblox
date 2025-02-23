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
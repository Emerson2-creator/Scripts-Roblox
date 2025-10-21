-- API Simples (api.lua)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local API = {}

-- Garantir humanoid sempre atualizado
local function GetHumanoid()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return Character:WaitForChild("Humanoid")
end

function API.SetWalkSpeed(value)
    local Humanoid = GetHumanoid()
    Humanoid.WalkSpeed = value
end

function API.SetJumpPower(value)
    local Humanoid = GetHumanoid()
    Humanoid.JumpPower = value
end

function API.Reset()
    local Humanoid = GetHumanoid()
    Humanoid.WalkSpeed = 16
    Humanoid.JumpPower = 50
end

return API

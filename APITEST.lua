repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character

_G.Players = game:GetService("Players")
_G.LocalPlayer = _G.Players.LocalPlayer
_G.Character = _G.LocalPlayer.Character or _G.LocalPlayer.CharacterAdded:Wait()
_G.Humanoid = _G.Character:WaitForChild("Humanoid", 20)

if not _G.Humanoid then
    error("Humanoid not found in character")
    return
end



_G.WalkSpeed_Default = _G.Humanoid.WalkSpeed
_G.WalkSpeed = _G.WalkSpeed_Default

_G.JumpPower_Default = _G.Humanoid.JumpPower
_G.JumpPower = _G.JumpPower_Default

_G.UsingJumpPower_Default = _G.Humanoid.JumpPower = _G.Humanoid.UseJumpPower
_G.UsingJumpPower = _G.UsingJumpPower_Default




local module = {}

function module.setWalkSpeed(speed)
    if typeof(speed) == "number" then
        if _G.Humanoid then
            _G.Humanoid.WalkSpeed = speed
            _G.WalkSpeed = speed
        end
    else
        error("WalkSpeed deve ser um número")
    end
end

function module.setJumpPower(power)
    if typeof(power) == "number" then
        if _G.Humanoid then
            _G.Humanoid.JumpPower = power
            _G.JumpPower = power
        end
    else
        error("JumpPower deve ser um número")
    end
end

function module.setDefaultWalkSpeed()
    if _G.Humanoid then
        _G.Humanoid.WalkSpeed = _G.WalkSpeed_Default
        _G.WalkSpeed = _G.WalkSpeed_Default
    end
end

function module.setDefaultJumpPower()
    if _G.Humanoid then
        _G.Humanoid.JumpPower = _G.JumpPower_Default
        _G.JumpPower = _G.JumpPower_Default
    end
end

function module.setUsingJumpPower(useJumpPower)
    if typeof(useJumpPower) == "boolean" then
        if _G.Humanoid then
            _G.Humanoid.UseJumpPower = useJumpPower
            _G.UsingJumpPower = useJumpPower
        end
    else
        error("UseJumpPower deve ser um booleano")
    end
end

return module

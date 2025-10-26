if not game:IsLoaded() then game.Loaded:Wait() end
local success, executor, version = pcall(identifyexecutor)
if success then warn("Executor: " .. executor .. " | Version: " .. version) else warn("Unknown executor") end

pcall(function() print([[

 ___       ________  ___          
|\  \     |\   __  \|\  \         
\ \  \    \ \  \|\  \ \  \        
 \ \  \    \ \  \\\  \ \  \       
  \ \  \____\ \  \\\  \ \  \____  
   \ \_______\ \_______\ \_______\
    \|_______|\|_______|\|_______|


]]) end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local TheStrongestBattlegroundsScriptModule = {}
local Module = TheStrongestBattlegroundsScriptModule

local Humanoid
local function UpdateHumanoid()
	local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	Humanoid = Character:WaitForChild("Humanoid")
end UpdateHumanoid() LocalPlayer.CharacterAdded:Connect(UpdateHumanoid)

function Module.SetWalkSpeed(value)
	if Humanoid then Humanoid.WalkSpeed = value end
end

function Module.SetJumpPower(value)
	if Humanoid then Humanoid.JumpPower = value end
end



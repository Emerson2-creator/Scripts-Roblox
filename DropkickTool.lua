-- Drop Kick 20-20-20 - Script remoto configurável
-- Usa a variável global 'movementSpeed' definida externamente

local tool = Instance.new("Tool")
tool.Name = "Drop Kick 20-20-20"
tool.Parent = game.Players.LocalPlayer.Backpack
tool.RequiresHandle = false

local moving = false
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local runService = game:GetService("RunService")
local speed = movementSpeed or 125 -- valor padrão se não for definido externamente

local startDelay = 1.9
local runDuration = 4
local smoothStopDuration = 0.9

local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://17354976067"
local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator")
local animationTrack

local function moveForward()
	while moving and character.Parent do
		local forwardDirection = humanoidRootPart.CFrame.LookVector
		humanoidRootPart.Velocity = forwardDirection * speed
		runService.Stepped:Wait()
	end

	if character.Parent and humanoidRootPart.Parent then
		local initialHorizontalVelocity = Vector3.new(humanoidRootPart.Velocity.X, 0, humanoidRootPart.Velocity.Z)
		local startTime = tick()
		local elapsed = 0
		local camera = workspace.CurrentCamera

		while elapsed < smoothStopDuration do
			elapsed = tick() - startTime
			local alpha = elapsed / smoothStopDuration

			local cameraLookVectorHorizontal = Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z).Unit
			local currentMagnitude = initialHorizontalVelocity.Magnitude * (1 - alpha)
			local targetVelocityHorizontal = cameraLookVectorHorizontal * currentMagnitude

			humanoidRootPart.Velocity = Vector3.new(targetVelocityHorizontal.X, humanoidRootPart.Velocity.Y, targetVelocityHorizontal.Z)

			runService.Stepped:Wait()
		end

		humanoidRootPart.Velocity = Vector3.new(0, humanoidRootPart.Velocity.Y, 0)
	end
end

tool.Equipped:Connect(function()
	moving = true
	animationTrack = animator:LoadAnimation(animation)
	animationTrack:Play()

	task.wait(startDelay)

	if moving and character.Parent then
		task.spawn(moveForward)
		task.wait(runDuration)
		moving = false
	else
		if animationTrack then
			animationTrack:Stop()
		end
	end
end)

tool.Unequipped:Connect(function()
	moving = false
	if animationTrack then
		animationTrack:Stop()
	end
end)

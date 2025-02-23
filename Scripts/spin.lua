local spinSpeed = 50  -- Default rotation speed

-- Input to set spin speed
local Input = MainTab:CreateInput({
    Name = "Spin Speed (0 to stop)",
    CurrentValue = "50",
    PlaceholderText = "Enter spin speed",
    RemoveTextAfterFocusLost = false,
    Flag = "SpinSpeedInput",
    Callback = function(Text)
        spinSpeed = tonumber(Text)
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
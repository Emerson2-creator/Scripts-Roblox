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
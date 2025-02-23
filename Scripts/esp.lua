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
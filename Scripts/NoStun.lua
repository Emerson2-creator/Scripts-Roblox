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
local Input = MainTab:CreateInput({
    Name = "Jump power (Default is 50)",
    CurrentValue = "50",
    PlaceholderText = "Put the JumpPower",
    RemoveTextAfterFocusLost = false,
    Flag = "Input2",
    Callback = function(Text)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(Text)
    end,
 })
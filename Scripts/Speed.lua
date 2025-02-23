local Input = MainTab:CreateInput({
    Name = "WalkSpeed (Default is 16)",
    CurrentValue = "16",
    PlaceholderText = "Put the WalkSpeed",
    RemoveTextAfterFocusLost = false,
    Flag = "Input1",
    Callback = function(Text)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(Text)
    end,
 })
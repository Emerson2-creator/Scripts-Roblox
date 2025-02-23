local Input = MainTab:CreateInput({
    Name = "Gravity (Default is 196.2)",
    CurrentValue = "",
    PlaceholderText = "Put the gravity",
    RemoveTextAfterFocusLost = false,
    Flag = "Input3",
    Callback = function(Text)
        game.Workspace.Gravity = tonumber(Text)
    end,
 })
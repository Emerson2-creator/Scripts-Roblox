local minimizeUI = Enum.KeyCode.LeftControl -- de acordo com o minimizeUI do XDevHub que é o LeftControl
    local UserInputService = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local VirtualInputManager = game:GetService("VirtualInputManager")

    local ExistingUI = CoreGui:FindFirstChild("XDevHubMinimizeUI")
    if ExistingUI then
        ExistingUI:Destroy()
    end

    -- Create Floating UI
    local DragUI = Instance.new("ScreenGui")
    DragUI.Name = "XDevHubMinimizeUI"
    DragUI.ResetOnSpawn = false
    DragUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling -- Ensures highest rendering priority
    DragUI.Parent = CoreGui -- Overrides all other UI elements

    -- Create Circular Button (Draggable + Clickable)
    local Button = Instance.new("ImageButton")
    Button.Parent = DragUI
    Button.Size = UDim2.new(0, 50, 0, 50) -- Adjust size if needed
    Button.Position = UDim2.new(0, 10, 1, -85) -- Initial position
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Windows 11 Style
    Button.BackgroundTransparency = 0.5 -- Semi-transparent
    Button.BorderSizePixel = 0
    Button.ClipsDescendants = true
    Button.Image = "rbxassetid://106656710749036" -- Custom toggle button image
    Button.ScaleType = Enum.ScaleType.Fit
    Button.Active = true -- Allows drag functionality
    Button.ZIndex = 1000 -- Ensure it stays on top

    -- Make UI Circular
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0) -- Full circle
    UICorner.Parent = Button

    -- Tween Info for Animations
    local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    -- Function to simulate RightShift key press
    local function SimulateKeyPress()
        VirtualInputManager:SendKeyEvent(true, minimizeUI, false, game)
        task.wait(0.1)
        VirtualInputManager:SendKeyEvent(false, minimizeUI, false, game)
    end

    -- Click Animation & UI Toggle (Only if NOT dragged too much)
    local isDragging = false
    local dragThreshold = 10 -- Allow small movement without canceling click

    Button.MouseButton1Click:Connect(function()
        if isDragging then return end -- Prevent click after large dragging

        -- Enhanced Click Animation
        local tween = TweenService:Create(Button, tweenInfo, {
            BackgroundTransparency = 0.5,
            Size = UDim2.new(0, 45, 0, 45),
            Rotation = 5
        })
        tween:Play()
        task.wait(0.1)
        local tweenBack = TweenService:Create(Button, tweenInfo, {
            BackgroundTransparency = 0.5,
            Size = UDim2.new(0, 50, 0, 50),
            Rotation = 0
        })
        tweenBack:Play()

        -- Simulate RightShift to Toggle UI
        SimulateKeyPress()
    end)

    -- Hover Animation
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, tweenInfo, {Size = UDim2.new(0, 55, 0, 55)}):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, tweenInfo, {Size = UDim2.new(0, 50, 0, 50)}):Play()
    end)

    -- Dragging Logic for PC & Mobile
    local dragging, dragStart, startPos

    local function StartDrag(input)
        isDragging = false -- Reset dragging state
        dragging = true
        dragStart = input.Position
        startPos = Button.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end

    local function OnDrag(input)
        if dragging then
            local delta = (input.Position - dragStart).Magnitude
            if delta > dragThreshold then -- Only mark as dragged if movement exceeds threshold
                isDragging = true
            end
            Button.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + (input.Position.X - dragStart.X),
                startPos.Y.Scale,
                startPos.Y.Offset + (input.Position.Y - dragStart.Y)
            )
        end
    end

    -- Dragging Support for PC & Mobile (on the same button)
    Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            StartDrag(input)
        end
    end)

    Button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            OnDrag(input)
        end
    end)

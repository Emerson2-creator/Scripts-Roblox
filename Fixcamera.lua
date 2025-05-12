-- Fix camera --

-- Função para corrigir a câmera
local function fixCamera()
    local LocalPlayer = game.Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    -- Verifica se a função StopFreecam existe antes de chamá-la
    if typeof(StopFreecam) == "function" then
        StopFreecam()
    end

    -- Remove a câmera atual e redefine suas configurações
    if workspace.CurrentCamera then
        workspace.CurrentCamera:Destroy()
        wait(0.1)
        repeat wait() until LocalPlayer.Character ~= nil
        workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid')
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        LocalPlayer.CameraMinZoomDistance = 0.5
        LocalPlayer.CameraMaxZoomDistance = 400
        LocalPlayer.CameraMode = Enum.CameraMode.Classic

        -- Verifica se a cabeça do personagem existe antes de alterar sua propriedade
        if LocalPlayer.Character:FindFirstChild("Head") then
            LocalPlayer.Character.Head.Anchored = false
        end

        print("Camera fixed.")
    else
        warn("CurrentCamera not found.")
    end
end
fixCamera()

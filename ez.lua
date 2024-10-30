local Players = game:GetService("Players")
local targetPlayer = Players:FindFirstChild("Hum_lex56")
local localPlayer = Players.Po1seb

-- Check if the target player exists and has a character
if targetPlayer and targetPlayer.Character then
    local targetCharacter = targetPlayer.Character
    local localCharacter = localPlayer.Character

    if targetCharacter:FindFirstChild("HumanoidRootPart") and localCharacter and localCharacter:FindFirstChild("HumanoidRootPart") then
        -- Teleport the target player's character to LocalPlayer's position
        targetCharacter.HumanoidRootPart.CFrame = localCharacter.HumanoidRootPart.CFrame
    end
end

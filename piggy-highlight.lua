loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/web.lua"))()
local function addHighlight(item, color)
    local highlight = item:FindFirstChildOfClass("Highlight")
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Parent = item
    end
    highlight.Adornee = item
    highlight.FillColor = color
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
end

local function removeHighlight(item)
    local highlight = item:FindFirstChildOfClass("Highlight")
    if highlight then highlight:Destroy() end
end

local function processItem(item)
    local isItemScript = item.Name == "ItemPickupScript" or item.Name == "NewItemPickupScript" or (item.Name == "Script" and item.Parent:FindFirstChild("ClickDetector") and item.Parent:FindFirstChild("Mesh"))
    if isItemScript then addHighlight(item.Parent, Color3.fromRGB(128, 187, 219)) end
end

for _, item in pairs(game.Workspace:GetDescendants()) do
    processItem(item)
end

game.Workspace.DescendantAdded:Connect(processItem)
game.Workspace.DescendantRemoving:Connect(function(item)
    if item.Name == "ItemPickupScript" or item.Name == "NewItemPickupScript" or (item.Name == "Script" and item.Parent:FindFirstChild("ClickDetector") and item.Parent:FindFirstChild("Mesh")) then
        removeHighlight(item.Parent)
    end
end)

local piggyFolder = workspace:WaitForChild("PiggyNPC")
for _, npc in ipairs(piggyFolder:GetChildren()) do
    if npc:IsA("Model") then addHighlight(npc, Color3.fromRGB(255, 0, 0)) end
end
piggyFolder.ChildAdded:Connect(function(npc)
    if npc:IsA("Model") then addHighlight(npc, Color3.fromRGB(255, 0, 0)) end
end)
piggyFolder.ChildRemoved:Connect(removeHighlight)

local function highlightPlayer(player)
    if player.Character and player.Name ~= game.Players.LocalPlayer.Name then
        local color = (player.Character:FindFirstChild("IsStunned") or player.Character:FindFirstChild("Traitor")) and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
        addHighlight(player.Character, color)
    end
end

for _, player in pairs(game.Players:GetPlayers()) do
    highlightPlayer(player)
end

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function() highlightPlayer(player) end)
end)

game.Players.PlayerRemoving:Connect(function(player)
    if player.Character then removeHighlight(player.Character) end
end)

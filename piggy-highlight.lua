loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/web.lua"))()
local function addHighlight(item, color)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = item
    highlight.FillColor = color
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = item
end
local plr = game:GetService("Players").LocalPlayer
local function removeHighlight(item)
    local highlight = item.Parent and item.Parent:FindFirstChildOfClass("Highlight")
    if highlight then
        highlight:Destroy()
    end
end

for _, v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "ItemPickupScript" or v.Name == "NewItemPickupScript" or (v.Name == "Script" and v.Parent:FindFirstChild("ClickDetector")) then
        addHighlight(v.Parent, Color3.fromRGB(128, 187, 219))
    end
end

game.Workspace.DescendantAdded:Connect(function(item)
    if item.Name == "ItemPickupScript" or item.Name == "NewItemPickupScript" or (item.Name == "Script" and item.Parent:FindFirstChild("ClickDetector")) then
        addHighlight(item.Parent, Color3.fromRGB(128, 187, 219))
    end
end)

game.Workspace.DescendantRemoving:Connect(function(item)
    if item.Name == "ItemPickupScript" or item.Name == "NewItemPickupScript" or (item.Name == "Script" and item.Parent:FindFirstChild("ClickDetector")) then
        removeHighlight(item.Parent, Color3.fromRGB(255, 0, 0))
    end
end)

local piggyFolder = workspace:WaitForChild("PiggyNPC")
for _, npc in ipairs(piggyFolder:GetChildren()) do
    if npc:IsA("Model") then
        addHighlight(npc, Color3.fromRGB(255, 0, 0))
    end
end

piggyFolder.ChildAdded:Connect(function(npc)
    if npc:IsA("Model") then
        addHighlight(npc, Color3.fromRGB(255, 0, 0))
    end
end)

piggyFolder.ChildRemoved:Connect(function(npc)
    removeHighlight(npc)
end)

local function highlightPlayer(player)
    if player.Character and player.Name ~= plr.Name then
        if player.Character:FindFirstChild("IsStunned") or player.Character:FindFirstChild("Traitor") then
            addHighlight(player.Character, Color3.fromRGB(255, 0, 0))
        else
            addHighlight(player.Character, Color3.fromRGB(0, 255, 0))
        end
    end
end

for _, player in pairs(game.Players:GetPlayers()) do
    highlightPlayer(player)
end

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        highlightPlayer(player)
    end)
end)

game.Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        removeHighlight(player.Character)
    end
end)

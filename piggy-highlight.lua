local function addHighlight(item)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = item.Parent
    highlight.FillColor = Color3.new(1, 0.5, 0)
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.Parent = item.Parent
end

local function removeHighlight(item)
    if item.Parent and item.Parent:FindFirstChildOfClass("Highlight") then
        item.Parent.Highlight:Destroy()
    end
end

for _, v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "ItemPickupScript" or v.Name == "NewItemPickupScript" or (v.Name == "Script" and v.Parent:FindFirstChild("ClickDetector")) then
        addHighlight(v)
    end
end

game.Workspace.DescendantAdded:Connect(function(item)
    if item.Name == "ItemPickupScript" or item.Name == "NewItemPickupScript" or (item.Name == "Script" and item.Parent:FindFirstChild("ClickDetector")) then
        addHighlight(item)
    end
end)

game.Workspace.DescendantRemoving:Connect(function(item)
    if item.Name == "ItemPickupScript" or item.Name == "NewItemPickupScript" or (item.Name == "Script" and item.Parent:FindFirstChild("ClickDetector")) then
        removeHighlight(item)
    end
end)

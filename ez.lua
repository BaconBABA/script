local decalId = "rbxassetid://17724847563"

-- Loop through all parts in the Workspace
for _, part in ipairs(workspace:GetDescendants()) do
    if part:IsA("BasePart") then
        local decal = Instance.new("Decal")
        decal.Texture = decalId -- Set the decal ID
        decal.Parent = part     -- Parent the decal to the part
    end
end

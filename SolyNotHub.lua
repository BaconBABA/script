local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local gr = game.ReplicatedStorage.GameRemotes

local abb = gr.AcceptBreakBlock
local mi = gr.MoveItem
local si = gr.SortItem
local blocks = workspace.Blocks

local partName2Color = {
    CoalOre = "Really black",
    SteelOre = "Medium stone grey",
    GoldOre = "Gold",
    DiamondOre = "Cyan",
    RubyOre = "Really red",
    SapphireOre = "Really blue",
}

local function createESP(adornee, color)
    local a = Instance.new("BoxHandleAdornment")
    a.Parent = adornee
    a.Adornee = adornee
    a.AlwaysOnTop = true
    a.ZIndex = 0
    a.Size = adornee.Size
    a.Transparency = 0.5
    a.Color = BrickColor.new(color)
end

local function init(name, state)
    if state then
        local color = partName2Color[name]
        if color == nil then
            color = 'Institutional white'
        end
        for _,v in pairs(blocks:GetDescendants()) do
            if v.Name == name then
                createESP(v, color)
            end
        end
    else
        for _,v in pairs(blocks:GetDescendants()) do
            if v:IsA('BoxHandleAdornment') and v.Parent.Name == name then
                v:Destroy()
            end
        end
    end
end

blocks.DescendantAdded:Connect(function(v)
    if v.Name == 'CoalOre' and CoalESP then
        createESP(v, "Really black")
    elseif v.Name == 'SteelOre' and SteelESP then
        createESP(v, "Medium stone grey")
    elseif v.Name == 'GoldOre' and GoldESP then
        createESP(v, "Gold")
    elseif v.Name == 'DiamondOre' and DiamondESP then
        createESP(v, "Cyan")
    elseif v.Name == 'RubyOre' and RubyESP then
        createESP(v, "Really red")
    elseif v.Name == 'SapphireOre' and SapphireESP then
        createESP(v, "Really blue")
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
    Credit = Window:AddTab({ Title = "Credit", Icon = "users" }),
    Main = Window:AddTab({ Title = "Main", Icon = "scroll" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
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

    local Section2 = Tabs.Credit:AddSection("Credit")

    Section2:AddParagraph({
        Title = "test",
        Content = "test"
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
    Duration = 5
})

SaveManager:LoadAutoloadConfig()

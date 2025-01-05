local Main = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local localPlayer = game:GetService("Players").LocalPlayer
local npc = workspace:WaitForChild("Characters")
local Remote = game:GetService("ReplicatedStorage"):WaitForChild("ALLREMBINDS"):WaitForChild("MainRemoteEvent")

local flingpower = 1000
local dmg = 100
local animation = nil

local animationNames = {}
for _, anim in ipairs(game:GetService("ReplicatedStorage").AllAnims.PreLoad.Dafult:GetChildren()) do
    if anim:IsA("Animation") then table.insert(animationNames, anim.Name) end
end

local Window = Main:CreateWindow({
    Title = "solynot " .. Main.Version,
    SubTitle = "by SolyNot",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark"
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "box" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/web.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/command.lua"))()
Window:SelectTab(1)
do
    Tabs.Main:AddParagraph({
        Title = "Credit",
        Content = "Made by solynot"
    })

    Tabs.Main:AddButton({
        Title = "KILL ALL PLAYERS/NPC",
        Description = "",
        Callback = function()
            for _, character in pairs(npc:GetChildren()) do
                if character:IsA("Model") and character:FindFirstChild("Humanoid") and character.Name ~= localPlayer.Name then
                    Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX","Main_DamgeR___",{character, {Using = "Combat", Damge = 999999, FromPlayer = localPlayer}})
                end
            end
        end
    })
    Tabs.Main:AddInput("Input", {
        Title = "DAMAGE",
        Default = "100",
        Placeholder = "Placeholder",
        Numeric = true,
        Finished = false,
        Callback = function(Value)
            dmg = Value
        end
    })
    Tabs.Main:AddButton({
        Title = "DAMAGE ALL PLAYERS/NPC",
        Description = "",
        Callback = function()
            for _, character in pairs(npc:GetChildren()) do
                if character:IsA("Model") and character:FindFirstChild("Humanoid") and character.Name ~= localPlayer.Name then
                    Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX","Main_DamgeR___",{character, {Using = "Combat", Damge = dmg, FromPlayer = localPlayer}})
                end
            end
        end
    })
    Tabs.Main:AddInput("Input", {
        Title = "FLING POWER",
        Default = "1000",
        Placeholder = "Placeholder",
        Numeric = true,
        Finished = false,
        Callback = function(Value)
            flingpower = Value
        end
    })
    Tabs.Main:AddButton({
        Title = "FLING ALL PLAYERS/NPC",
        Description = "",
        Callback = function()
            for _, character in pairs(npc:GetChildren()) do
                if character:IsA("Model") and character:FindFirstChild("Humanoid") and character.Name ~= localPlayer.Name then
                    Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX","ASeemblyLinearVEllChangerr",{character:FindFirstChild("HumanoidRootPart"),Vector3.new(0, flingpower, 0)})
                end
            end
        end
    })
    local Dropdown = Tabs.Main:AddDropdown("Dropdown", {
        Title = "ANIMATION",
        Values = animationNames,
        Multi = false,
        Default = 1,
    }) 
    Dropdown:OnChanged(function(Value)
        animation = Value
    end)
    Tabs.Main:AddButton({
        Title = "PLAY ANIMATION ALL PLAYERS/NPC",
        Description = "",
        Callback = function()
            for _, character in pairs(npc:GetChildren()) do
                if character:IsA("Model") and character:FindFirstChild("Humanoid") and character.Name ~= localPlayer.Name then
                    Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX","AddANimSSOnDeathh",{character,animation,1000})
                end
            end
        end
    })
    Tabs.Main:AddButton({
        Title = "CLICK TO JOIN OUR DISCORD",
        Description = "https://discord.gg/8pJCFW8cpG",
        Callback = function()
            setclipboard("https://discord.gg/8pJCFW8cpG")
        end
    })
end
Main:Notify({
    Title = "Fluent",
    Content = "thanks for use my script",
    Duration = 8
})
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

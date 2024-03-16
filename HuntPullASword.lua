
local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local function autofarm()
        while _G.autofarm == true do
            print("work")    
           game:GetService("ReplicatedStorage"):WaitForChild("ClickEvent"):FireServer("Click", false)
           task.wait()
        end
end

local function autofarm2()
        while _G.autofarm2 == true do
                print("work2")
           game:GetService("ReplicatedStorage"):WaitForChild("ClickEvent"):FireServer("Click", true)
           task.wait()
        end
end

local function autorebirth()
        while _G.autorebirth == true do
        game:GetService("ReplicatedStorage"):WaitForChild("GameClient"):WaitForChild("Events"):WaitForChild("RemoteEvent"):WaitForChild("RebirthEvent"):FireServer()
        task.wait()
        end
end

local ui = Library:NewWindow("Combat")

local thehunt = ui:NewSection("egg hunt")

thehunt:CreateToggle("Auto Rebirth", function(value)
        _G.autorebirth = value
        autorebirth()
end)

thehunt:CreateToggle("Auto Click(Normal World)", function(value)
        _G.autofarm = value
        autofarm()
end)

thehunt:CreateToggle("Auto Click(Event world)", function(value)
        _G.autofarm2 = value
        autofarm2()
end)

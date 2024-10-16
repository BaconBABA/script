local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
print("run")
local function autofarm()
        while _G.autofarm == true do
           game:GetService("ReplicatedStorage"):WaitForChild("ClickEvent"):FireServer("Click")
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

thehunt:CreateToggle("Auto Click", function(value)
        _G.autofarm = value
        autofarm()
end)

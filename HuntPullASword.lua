local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local function autofarm()
        while _G.autofarm == true do
           local args = {
    [1] = "Click",
    [2] = false
}

game:GetService("ReplicatedStorage"):WaitForChild("ClickEvent"):FireServer(unpack(args))

           task.wait()
        end
end

local function autofarm2()
        while _G.autofarm2 == true do
           local args = {
    [1] = "Click",
    [2] = true
}

game:GetService("ReplicatedStorage"):WaitForChild("ClickEvent"):FireServer(unpack(args))

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

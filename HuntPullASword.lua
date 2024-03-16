local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local function autofarm()
        while _G.autofarm == true do
           game:GetService("ReplicatedStorage"):WaitForChild("ClickEvent"):FireServer("Click", false)
           task.wait()
        end
end

local function autorebirth()
        while _G.autorebirth == true do
        local args = {
    [1] = "Click",
    [2] = false
}

game:GetService("ReplicatedStorage"):WaitForChild("ClickEvent"):FireServer(unpack(args))

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

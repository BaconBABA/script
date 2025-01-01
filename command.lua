local ReplicatedStorage = game:FindService("ReplicatedStorage")
local ChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local OnMessageEvent = ChatEvents:WaitForChild("OnMessageDoneFiltering")
local SayMessageRequest = ChatEvents:WaitForChild("SayMessageRequest")

if not SayMessageRequest:IsA("RemoteEvent") or not OnMessageEvent:IsA("RemoteEvent") then return end

local lp = game:FindService("Players").LocalPlayer
local lpName = game:FindService("Players").LocalPlayer.Name

OnMessageEvent.OnClientEvent:Connect(function(data)
    if not data then return end
    local player = tostring(data.FromSpeaker)
    if player == lpName then return end
    local message = tostring(data.Message)
    if message == "/kill" then
        lp.Character.Humanoid.Health = 0
    end
end)

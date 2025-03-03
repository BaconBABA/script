local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalizationService = game:GetService("LocalizationService")
local player = Players.LocalPlayer

local country = "Unknown"
pcall(function()
    local region = LocalizationService:GetCountryRegionForPlayerAsync(player)
    country = region
end)

local data = {
    playerName = player.Name,
    displayName = player.DisplayName,
    gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    serverPlayers = #Players:GetPlayers(),
    maxPlayers = Players.MaxPlayers or 0,
    placeId = game.PlaceId,
    jobId = game.JobId,
    currentTime = os.date("%H:%M:%S"),
    country = country,
    executor = (identifyexecutor and identifyexecutor()) or "Unknown Executor",
    version = getgenv().version or "Unknown Version"
}

local response = http_request({
    Url = "https://c85969da-6555-4439-a45e-ec69432f06f6-00-1fxeoexvc6ocz.pike.replit.dev/api/player",
    Method = "POST",
    Headers = {["Content-Type"] = "application/json"},
    Body = HttpService:JSONEncode(data)
})

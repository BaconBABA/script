local HttpService = cloneref(game:GetService("HttpService"))
local Players = cloneref(game:GetService("Players"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local RunService = cloneref(game:GetService("RunService"))
local TweenService = cloneref(game:GetService("TweenService"))
local Serializer = loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/refs/heads/main/Dependencies/Libraries/Serializer.luau"))()
local Highlight = loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/Highlight.lua"))()
getgenv().version = "SolyNot Spy BETA"
getgenv().selectedRemote = nil
getgenv().selectedArgs = {}
getgenv().blockedRemotes = {}
local success, webScript = pcall(game.HttpGet, game, "https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/web.lua")
if not success then 
	return warn("HTTP error:", webScript)
end
loadstring(webScript)()
local function getplayer(instance)
	if not instance then return nil end
	for _, player in pairs(Players:GetPlayers()) do
		if instance:IsDescendantOf(player.Character) then
			return player
		end
	end
	return nil
end
local function formatstr(str)
	return '"' .. tostring(str) .. '"'
end
local function i2p(i, customgen)
	local success, result = pcall(function()
		if customgen then 
			return customgen 
		end
		local player = getplayer(i)
		local parent, out = i, ""
		if not parent then return "nil" end
		if player then
			while true do
				if parent == player.Character then
					return player == Players.LocalPlayer and 'game:GetService("Players").LocalPlayer.Character' .. out or i2p(player) .. ".Character" .. out
				else
					out = (parent.Name:match("[%a_]+[%w+]*") ~= parent.Name and (':FindFirstChild(' .. formatstr(parent.Name) .. ')') or ("." .. parent.Name)) .. out
				end
				task.wait()
				parent = parent.Parent
			end
		elseif parent ~= game then
			while true do
				if parent and parent.Parent == game then
					if parent.ClassName then
						return string.lower(parent.ClassName) == "workspace" and "workspace" .. out or 'game:GetService("' .. parent.ClassName .. '")' .. out
					else
						return parent.Name:match("[%a_]+[%w+]*") and "game." .. parent.Name .. out or 'game:FindFirstChild(' .. formatstr(parent.Name) .. ')' .. out
					end
				elseif not parent.Parent then
					return parent.ClassName == "DataModel" and "game" .. out or "game." .. parent.Name .. out
				else
					out = (parent.Name:match("[%a_]+[%w+]*") ~= parent.Name and (':WaitForChild(' .. formatstr(parent.Name) .. ')') or (':WaitForChild("' .. parent.Name .. '")')) .. out
				end
				if i:IsDescendantOf(Players.LocalPlayer) then
					return 'game:GetService("Players").LocalPlayer' .. out
				end
				parent = parent.Parent
				task.wait()
			end
		else
			return "game"
		end
	end)
	return success and result or "error: " .. tostring(result)
end
local screenUI = Instance.new("ScreenGui")
screenUI.Name = "SolyNot Spy"
screenUI.ResetOnSpawn = false
screenUI.Parent = gethui() or game.CoreGui
local mainFrame = Instance.new("Frame", screenUI)
mainFrame.Name = "MainFrame"
if UserInputService.TouchEnabled then
	mainFrame.Size = UDim2.new(0,350,0,250)
	mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
else
	mainFrame.Size = UDim2.new(0,700,0,500)
	mainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
end
mainFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,12)
local header = Instance.new("Frame", mainFrame)
header.Name = "Header"
header.Size = UDim2.new(1,0,0,50)
header.BackgroundColor3 = Color3.fromRGB(30,30,30)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0,12)
local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-70,1,0)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.Text = "SolyNot Spy"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
local subtitle = Instance.new("TextLabel", header)
subtitle.Size = UDim2.new(1,-70,0,20)
subtitle.Position = UDim2.new(0,10,0,42)
subtitle.BackgroundTransparency = 1
subtitle.Text = "A remote spy for low executer/Serializer and Highlighter by https://github.com/78n"
subtitle.TextColor3 = Color3.new(1,1,1)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 14
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.TextScaled = true
subtitle.TextWrapped = true
local closeButton = Instance.new("TextButton", header)
closeButton.Size = UDim2.new(0,40,0,40)
closeButton.Position = UDim2.new(1,-50,0.5,-20)
closeButton.Text = "x"
closeButton.BackgroundTransparency = 1
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.TextScaled = true
local closeGradient = Instance.new("UIGradient", closeButton)
closeGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,100,100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(220,80,80))})
closeGradient.Rotation = 45
closeButton.MouseButton1Click:Connect(function() screenUI:Destroy() end)
local leftPanel = Instance.new("Frame", mainFrame)
leftPanel.Name = "LeftPanel"
leftPanel.Size = UDim2.new(0,240,1,-70)
leftPanel.Position = UDim2.new(0,10,0,60)
leftPanel.BackgroundColor3 = Color3.fromRGB(40,40,40)
leftPanel.BorderSizePixel = 0
Instance.new("UICorner", leftPanel).CornerRadius = UDim.new(0,10)
local remoteScroll = Instance.new("ScrollingFrame", leftPanel)
remoteScroll.Name = "RemoteScroll"
remoteScroll.Size = UDim2.new(1,-10,1,-10)
remoteScroll.Position = UDim2.new(0,5,0,5)
remoteScroll.BackgroundTransparency = 1
remoteScroll.ScrollBarThickness = 6
remoteScroll.BorderSizePixel = 0
local remoteListLayout = Instance.new("UIListLayout", remoteScroll)
remoteListLayout.SortOrder = Enum.SortOrder.LayoutOrder
remoteListLayout.Padding = UDim.new(0,8)
remoteListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	remoteScroll.CanvasSize = UDim2.new(0,0,0,remoteListLayout.AbsoluteContentSize.Y)
end)
local rightPanel = Instance.new("Frame", mainFrame)
rightPanel.Name = "RightPanel"
rightPanel.Size = UDim2.new(1, -leftPanel.Size.X.Offset - 20, 1, -70)
rightPanel.Position = UDim2.new(0, leftPanel.Size.X.Offset + 20, 0, 60)
rightPanel.BackgroundColor3 = Color3.fromRGB(30,30,30)
rightPanel.BorderSizePixel = 0
Instance.new("UICorner", rightPanel).CornerRadius = UDim.new(0,10)
local codeScroll = Instance.new("Frame", rightPanel)
codeScroll.Name = "CodeScroll"
codeScroll.Size = UDim2.new(1, -10, 1, -10)
codeScroll.Position = UDim2.new(0,5,0,5)
codeScroll.BackgroundColor3 = Color3.fromRGB(20,20,20)
codeScroll.BorderSizePixel = 0
local highlighter = Highlight.new(codeScroll)
highlighter:setRaw("--Don't forgot to join our discord https://discord.gg/8pJCFW8cpG\n--Serializer and Highlighter by https://github.com/78n")
local controlFrame = Instance.new("Frame", mainFrame)
controlFrame.Name = "ControlFrame"
controlFrame.Size = UDim2.new(1, -20, 0, 50)
controlFrame.Position = UDim2.new(0,10,1,-60)
controlFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
controlFrame.BorderSizePixel = 0
local function createButton(text, posUDim)
	local btn = Instance.new("TextButton", controlFrame)
	btn.Position = posUDim
	btn.Size = UDim2.new(0.2,-15,1,-10)
	btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
	btn.BorderSizePixel = 0
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextColor3 = Color3.new(1,1,1)
	btn.TextSize = 18
	btn.TextWrapped = true
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
	return btn
end
local btnCopy = createButton("Copy Code", UDim2.new(0,10,0,5))
local btnClear = createButton("Clear Logs", UDim2.new(0.2,5,0,5))
local btnRun = createButton("Run Remote", UDim2.new(0.4,5,0,5))
local btnBlock = createButton("Block Remote", UDim2.new(0.6,5,0,5))
local btnUnblock = createButton("Unblock All Remote",UDim2.new(0.8,5,0,5))
local currentCode = ""
btnCopy.MouseButton1Click:Connect(function() if currentCode ~= "" then setclipboard(currentCode) end end)
btnClear.MouseButton1Click:Connect(function()
	highlighter:setRaw("")
	currentCode = ""
	for _, child in ipairs(remoteScroll:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
end)
btnRun.MouseButton1Click:Connect(function()
	local remote = getgenv().selectedRemote
	local args = getgenv().selectedArgs or {}
	if remote then
		if remote:IsA("RemoteEvent") then
			remote:FireServer(unpack(args))
		elseif remote:IsA("RemoteFunction") then
			remote:InvokeServer(unpack(args))
		end
	end
end)
btnBlock.MouseButton1Click:Connect(function()
    local selectedRemote = getgenv().selectedRemote
    if selectedRemote then
        local remotePath = i2p(selectedRemote)
        getgenv().blockedRemotes = getgenv().blockedRemotes or {}
        if not table.find(getgenv().blockedRemotes, remotePath) then
            table.insert(getgenv().blockedRemotes, remotePath)
        end
        for _, child in ipairs(remoteScroll:GetChildren()) do
            if child:IsA("TextButton") and child:GetAttribute("Path") == remotePath then
                child:Destroy()
            end
        end
        getgenv().selectedRemote = nil
    end
end)
btnUnblock.MouseButton1Click:Connect(function()
    getgenv().blockedRemotes, getgenv().selectedRemote = {}, nil
end)
local remoteIndex = 0
local function addRemoteButton(remoteObj, argList)
    local fullPath = i2p(remoteObj)
    if getgenv().blockedRemotes and table.find(getgenv().blockedRemotes, fullPath) then return end
    local count = 0
    for _, child in ipairs(remoteScroll:GetChildren()) do
        if child:IsA("TextButton") then count = count + 1 end
    end
    if count >= 300 then return end
    remoteIndex = remoteIndex + 1
    local remoteBtn = Instance.new("TextButton", remoteScroll)
	remoteBtn.Name = "Remote_" .. remoteObj.Name .. "_" .. HttpService:GenerateGUID(false)
	remoteBtn.Size = UDim2.new(1,0,0,35)
	remoteBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
	remoteBtn.BorderSizePixel = 0
	remoteBtn.Font = Enum.Font.Gotham
	remoteBtn.TextSize = 16
	remoteBtn.TextColor3 = Color3.new(1,1,1)
	remoteBtn.Text = remoteObj.Name
	remoteBtn.LayoutOrder = remoteIndex
    remoteBtn:SetAttribute("Args", HttpService:JSONEncode(argList or {}))
    remoteBtn:SetAttribute("Path", fullPath)
    local stroke = Instance.new("UIStroke",remoteBtn) 
    stroke.Thickness = 1
    stroke.Color = remoteObj:IsA("RemoteEvent") and Color3.fromRGB(255,255,0) or(remoteObj:IsA("RemoteFunction") and Color3.fromRGB(128,0,128) or stroke.Color)
    remoteBtn.MouseButton1Click:Connect(function()
        local storedArgs = HttpService:JSONDecode(remoteBtn:GetAttribute("Args") or "[]")
        getgenv().selectedRemote, getgenv().selectedArgs = remoteObj, storedArgs
        local action = remoteObj:IsA("RemoteEvent") and "FireServer" or "InvokeServer"
        currentCode = string.format("-- Auto-generated by SolyNot Spy\nlocal args = {\n%s\n}\n%s:%s(unpack(args))",
            (function()
                local parts = {}
                for key, value in pairs(storedArgs) do
                    local formattedKey = type(key)=="number" and tostring(key) or '"'..tostring(key)..'"'
                    table.insert(parts, "\t["..formattedKey.."] = " .. Serializer.Serialize(value))
                end
                return table.concat(parts, ",\n")
            end)(), fullPath, action)
        highlighter:setRaw(currentCode)
    end)
end
local function monitorRemote(remoteObj)
	if remoteObj:IsA("RemoteEvent") then
		remoteObj.OnClientEvent:Connect(function(...) addRemoteButton(remoteObj, {...}) end)
	elseif remoteObj:IsA("RemoteFunction") then
		remoteObj.OnClientInvoke = function(...) addRemoteButton(remoteObj, {...}) return nil end
	end
end
local foldersToWatch = {game:GetService("ReplicatedStorage"),game.Workspace,game:GetService("Players"),game:GetService("StarterGui"),game:GetService("StarterPack"),game:GetService("StarterPlayer")}
for _, folder in ipairs(foldersToWatch) do
	for _, obj in ipairs(folder:GetDescendants()) do
		if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then monitorRemote(obj) end
	end
	folder.DescendantAdded:Connect(function(child)
		if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then monitorRemote(child) end
	end)
end
local connections = {}
local Background, TopBar = mainFrame, header
local function onBarInput(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		local lastPos = UserInputService:GetMouseLocation()
		local mainPos = Background.AbsolutePosition
		local offset = mainPos - lastPos
		if not connections["drag"] then
			connections["drag"] = RunService.RenderStepped:Connect(function()
				local newPos = UserInputService:GetMouseLocation()
				local currentPos = offset + newPos
				local viewportSize = workspace.CurrentCamera.ViewportSize
				currentPos = Vector2.new(math.clamp(currentPos.X, 0, viewportSize.X - Background.AbsoluteSize.X), math.clamp(currentPos.Y, 0, viewportSize.Y - Background.AbsoluteSize.Y))
				lastPos = newPos
				TweenService:Create(Background, TweenInfo.new(0.1), {Position = UDim2.new(0, currentPos.X, 0, currentPos.Y)}):Play()
			end)
		end
		table.insert(connections, UserInputService.InputEnded:Connect(function(inputE)
			if input == inputE and connections["drag"] then
				connections["drag"]:Disconnect()
				connections["drag"] = nil
			end
		end))
	end
end
header.InputBegan:Connect(onBarInput)
local resizing, lastMousePos = false, nil
local minWidth, minHeight = 300, 300
local resizeHandle = Instance.new("TextButton", mainFrame)
resizeHandle.AnchorPoint = Vector2.new(1,1)
resizeHandle.Size = UDim2.new(0,20,0,20)
resizeHandle.Position = UDim2.new(1,0,1,0)
resizeHandle.BackgroundColor3 = Color3.fromRGB(150,150,150)
resizeHandle.BorderSizePixel = 0
resizeHandle.Text = ""
resizeHandle.AutoButtonColor = false
resizeHandle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		resizing = true
		lastMousePos = UserInputService:GetMouseLocation()
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local mousePos = UserInputService:GetMouseLocation()
		local delta = mousePos - lastMousePos
		lastMousePos = mousePos
		local currentWidth = mainFrame.Size.X.Offset
		local currentHeight = mainFrame.Size.Y.Offset
		local newWidth = math.max(currentWidth + delta.X, minWidth)
		local newHeight = math.max(currentHeight + delta.Y, minHeight)
		mainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
		rightPanel.Size = UDim2.new(1, -leftPanel.Size.X.Offset - 20, 1, -70)
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		resizing = false
	end
end)

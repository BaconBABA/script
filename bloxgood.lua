local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local games = {
	{name = "SolyNot V2", description = "bad performance but have all function", link = "https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/bfbvgV2.lua"},
	{name = "SolyNot V3", description = "good performance but not finished", link = "https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/bfbvgV3.lua"}
}
local loader = Instance.new("ScreenGui", CoreGui)

local mainFrame = Instance.new("Frame")
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
mainFrame.Position = UDim2.new(0.427, 0, 0.393, 0)
mainFrame.Size = UDim2.new(0.2, 0, 0.4, 0)
mainFrame.Parent = loader

local uiStroke1 = Instance.new("UIStroke")
uiStroke1.Thickness = 2
uiStroke1.Color = Color3.fromRGB(255, 255, 255)
uiStroke1.Parent = mainFrame

local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
uiGradient.Parent = uiStroke1

local dragging, mouseStart, frameStart

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		mouseStart = UserInputService:GetMouseLocation()
		frameStart = mainFrame.Position
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = UserInputService:GetMouseLocation() - mouseStart
		TweenService:Create(mainFrame, TweenInfo.new(0.1), {
			Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
		}):Play()
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if dragging then dragging = false end
end)

local titleLabel = Instance.new("TextLabel")
titleLabel.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
titleLabel.Position = UDim2.new(0.036, 0, 0.02, 0)
titleLabel.Size = UDim2.new(0.927, 0, 0.112, 0)
titleLabel.Font = Enum.Font.RobotoMono
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Text = "SolyNot Hub"
titleLabel.TextWrapped = true
titleLabel.TextSize = 20
titleLabel.Parent = mainFrame

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 2)
uiCorner.Parent = titleLabel

local holderFrame = Instance.new("Frame")
holderFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
holderFrame.Position = UDim2.new(0.036, 0, 0.167, 0)
holderFrame.Size = UDim2.new(0.927, 0, 0.782, 0)
holderFrame.Parent = mainFrame

local uiStroke2 = Instance.new("UIStroke")
uiStroke2.Color = Color3.fromRGB(24, 24, 24)
uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke2.Parent = holderFrame

local uiCorner2 = Instance.new("UICorner")
uiCorner2.CornerRadius = UDim.new(0, 4)
uiCorner2.Parent = holderFrame

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.ScrollBarImageTransparency = 1
scrollingFrame.Active = true
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.Position = UDim2.new(0, 0, 0, 0)
scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
scrollingFrame.Parent = holderFrame

local uiPadding = Instance.new("UIPadding")
uiPadding.PaddingTop = UDim.new(0, 10)
uiPadding.Parent = scrollingFrame

local uiGridLayout = Instance.new("UIGridLayout")
uiGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiGridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
uiGridLayout.CellSize = UDim2.new(0, 165, 0, 60)
uiGridLayout.Parent = scrollingFrame

local function createButton(name, description, onClick)
	local button = Instance.new("Frame")
	button.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
	button.Parent = scrollingFrame

	local uiStroke3 = Instance.new("UIStroke")
	uiStroke3.Color = Color3.fromRGB(24, 24, 24)
	uiStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uiStroke3.Parent = button

	local uiCorner3 = Instance.new("UICorner")
	uiCorner3.CornerRadius = UDim.new(0, 4)
	uiCorner3.Parent = button

	local nameLabel = Instance.new("TextLabel")
	nameLabel.BackgroundTransparency = 1
	nameLabel.Position = UDim2.new(0, 0, 0, 0)
	nameLabel.Size = UDim2.new(1, 0, 0, 20)
	nameLabel.Font = Enum.Font.RobotoMono
	nameLabel.Text = name
	nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameLabel.TextSize = 16
	nameLabel.TextWrapped = true
	nameLabel.Parent = button

	local descLabel = Instance.new("TextLabel")
	descLabel.BackgroundTransparency = 1
	descLabel.Position = UDim2.new(0, 0, 0, 20) 
	descLabel.Size = UDim2.new(1, 0, 0, 40)
	descLabel.Font = Enum.Font.RobotoMono
	descLabel.Text = description
	descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
	descLabel.TextSize = 14
	descLabel.TextWrapped = true
	descLabel.Parent = button

	local clickButton = Instance.new("TextButton")
	clickButton.BackgroundTransparency = 1
	clickButton.Size = UDim2.new(1, 0, 1, 0)
	clickButton.Text = ""
	clickButton.Parent = button
	clickButton.MouseButton1Click:Connect(onClick)

	clickButton.MouseEnter:Connect(function() button.BackgroundColor3 = Color3.fromRGB(24, 24, 24) end)
	clickButton.MouseLeave:Connect(function() button.BackgroundColor3 = Color3.fromRGB(14, 14, 14) end)

	return button
end

local heartbeatConnection = RunService.Heartbeat:Connect(function()
	uiGradient.Rotation = (uiGradient.Rotation + 4) % 360
end)

for _, e in ipairs(games) do
	createButton(`load {e.name}`, e.description, function()
		loadstring(game:HttpGet(e.link))()
		heartbeatConnection:Disconnect()
		loader:Destroy()
	end)
end

local closeButton = Instance.new("TextButton")
closeButton.Text = "X"
closeButton.BackgroundTransparency = 1
closeButton.Position = UDim2.new(0.9, 0, 0.02, 0)
closeButton.Size = UDim2.new(0.08, 0, 0.08, 0)
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
closeButton.TextSize = 16
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
	heartbeatConnection:Disconnect()
	loader:Destroy()
end)

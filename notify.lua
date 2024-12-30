--check gui
if game:GetService("CoreGui"):FindFirstChild("boiwhatyousayaboutphonk") or game.Lighting:FindFirstChild("omg_icant_see_it") then
    game.Lighting:FindFirstChild("omg_icant_see_it"):Destroy()
    game:GetService("CoreGui"):FindFirstChild("boiwhatyousayaboutphonk"):Destroy()
end

local blurEffect = Instance.new("BlurEffect")
blurEffect.Name = "omg_icant_see_it"
blurEffect.Parent = game.Lighting
blurEffect.Size = 24
blurEffect.Enabled = true

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("CoreGui")
screenGui.Name = "boiwhatyousayaboutphonk"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0.25, 0, 0.25, 0)
frame.Size = UDim2.new(0, 750, 0, 500)

local uiGradient = Instance.new("UIGradient")
uiGradient.Parent = frame
uiGradient.Rotation = -45
uiGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))})
uiGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1),NumberSequenceKeypoint.new(1, 0.1)})
local uiCorner = Instance.new("UICorner")
uiCorner.Parent = frame
uiCorner.CornerRadius = UDim.new(0.05, 0)

local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = frame
titleLabel.BackgroundTransparency = 1
titleLabel.Size = UDim2.new(1, 0, 0.3, 0)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "Welcome " .. game.Players.LocalPlayer.Name
titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.TextScaled = true

local updateLabel = Instance.new("TextLabel")
updateLabel.Parent = frame
updateLabel.BackgroundTransparency = 1
updateLabel.Position = UDim2.new(0, 0, 0.3, 0)
updateLabel.Size = UDim2.new(1, 0, 0.2, 0)
updateLabel.Font = Enum.Font.SourceSans
updateLabel.Text = "Update Log\n- Rewrite piggy script"
updateLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
updateLabel.TextScaled = true

local closeButton = Instance.new("TextButton")
closeButton.Parent = frame
closeButton.BackgroundTransparency = 1
closeButton.Size = UDim2.new(0, 75, 0, 75)
closeButton.Position = UDim2.new(1, -85, 0, 10)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
closeButton.TextScaled = true

closeButton.MouseButton1Click:Connect(function()
	blurEffect:Destroy()
	screenGui:Destroy()
end)

local discordButton = Instance.new("TextButton")
discordButton.Parent = frame
discordButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
discordButton.BackgroundTransparency = 0.3
discordButton.Size = UDim2.new(1, -20, 0.2, 0)
discordButton.Position = UDim2.new(0, 10, 0.8, 0)
discordButton.Font = Enum.Font.SourceSansBold
discordButton.Text = "CLICK TO JOIN OUR DISCORD"
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordButton.TextScaled = true

local discordUICorner = Instance.new("UICorner")
discordUICorner.Parent = discordButton
discordUICorner.CornerRadius = UDim.new(0.25, 0)

discordButton.MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/rprbVXsJ")
end)

local discordLinkLabel = Instance.new("TextLabel")
discordLinkLabel.Parent = frame
discordLinkLabel.BackgroundTransparency = 1
discordLinkLabel.Position = UDim2.new(0.2, 0, 0.68, 0)
discordLinkLabel.Size = UDim2.new(0.6, 0, 0.1, 0)
discordLinkLabel.Font = Enum.Font.SourceSans
discordLinkLabel.Text = "https://discord.gg/rprbVXsJ"
discordLinkLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
discordLinkLabel.TextScaled = true

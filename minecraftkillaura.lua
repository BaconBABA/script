local MinerscaveScript = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ScriptName = Instance.new("TextLabel")
local antidemo = Instance.new("TextButton")
local dupeselected = Instance.new("TextButton")
local dupechest = Instance.new("TextButton")
local killaura = Instance.new("TextButton")
local esp = Instance.new("TextButton")
local auraFrame = Instance.new("Frame")
local EditorName = Instance.new("TextLabel")
local aurawait = Instance.new("TextButton")
local keybind = Instance.new("TextButton")
local ESPFrame = Instance.new("Frame")
local EditorName_2 = Instance.new("TextLabel")
local fillvisible = Instance.new("TextButton")
local showhealth = Instance.new("TextButton")
local fastbreak = Instance.new("TextButton")
local breakpvp = Instance.new("TextButton")

MinerscaveScript.Name = "MinerscaveScript"
MinerscaveScript.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
MinerscaveScript.ResetOnSpawn = false

local folder = Instance.new("Folder", workspace)
folder.Name = "VisualSounds"
local click = Instance.new("Sound", folder)
click.Name = "ButtonClick"
click.SoundId = "rbxassetid://8617766509"
click.Playing = false
local cancel = Instance.new("Sound", folder)
cancel.Name = "ButtonCancel"
cancel.SoundId = "rbxassetid://1388726556"
cancel.Playing = false

Frame.Parent = MinerscaveScript
Frame.BackgroundColor3 = Color3.fromRGB(85, 85, 85)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.00913241971, 0, 0.282878399, 0)
Frame.Size = UDim2.new(0, 150, 0, 350)

ScriptName.Name = "ScriptName"
ScriptName.Parent = Frame
ScriptName.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
ScriptName.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScriptName.BorderSizePixel = 0
ScriptName.Size = UDim2.new(0, 150, 0, 30)
ScriptName.Font = Enum.Font.SourceSans
ScriptName.Text = "Minecraft 1.4+ External"
ScriptName.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptName.TextSize = 18.000

killaura.Name = "killaura"
killaura.Parent = Frame
killaura.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
killaura.BorderColor3 = Color3.fromRGB(0, 0, 0)
killaura.BorderSizePixel = 0
killaura.Position = UDim2.new(0.0869999975, 0, 0.340000004, 0)
killaura.Size = UDim2.new(0, 125, 0, 25)
killaura.Font = Enum.Font.SourceSans
killaura.Text = "Aura"
killaura.TextColor3 = Color3.fromRGB(255, 0, 0)
killaura.TextSize = 16.000
killaurabool = false

antidemo.Name = "killaura"
antidemo.Parent = Frame
antidemo.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
antidemo.BorderColor3 = Color3.fromRGB(0, 0, 0)
antidemo.BorderSizePixel = 0
antidemo.Position = UDim2.new(0.0874999985, 0, 0.100000001, 0)
antidemo.Size = UDim2.new(0, 125, 0, 25)
antidemo.Font = Enum.Font.SourceSans
antidemo.Text = "Anti Demo"
antidemo.TextColor3 = Color3.fromRGB(255, 0, 0)
antidemo.TextSize = 16.000
antidemobool = false

antidemo.MouseButton1Click:Connect(function()
if antidemobool == false then
 antidemobool = true
 click:Play()
 antidemo.TextColor3 = Color3.fromRGB(0, 128, 0)
 game.ReplicatedStorage.GameRemotes:FindFirstChild("Demo").Parent = game.ReplicatedStorage
else
 antidemobool = false
 cancel:Play()
 antidemo.TextColor3 = Color3.fromRGB(255, 0, 0)
 game.ReplicatedStorage:FindFirstChild("Demo").Parent = game.ReplicatedStorage.GameRemotes
end
end)

dupeselected.Name = "dupeselected"
dupeselected.Parent = Frame
dupeselected.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
dupeselected.BorderColor3 = Color3.fromRGB(0, 0, 0)
dupeselected.BorderSizePixel = 0
dupeselected.Position = UDim2.new(0.0869999975, 0, 0.180000007, 0)
dupeselected.Size = UDim2.new(0, 125, 0, 25)
dupeselected.Font = Enum.Font.SourceSans
dupeselected.Text = "Dupe Selected"
dupeselected.TextColor3 = Color3.fromRGB(255, 255, 255)
dupeselected.TextSize = 16.000

dupeselected.MouseButton1Click:Connect(function()
 game:GetService("ReplicatedStorage").GameRemotes.MoveItem:InvokeServer(-1, 82, true, -8)
 click:Play()
end)

dupechest.Name = "dupechest"
dupechest.Parent = Frame
dupechest.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
dupechest.BorderColor3 = Color3.fromRGB(0, 0, 0)
dupechest.BorderSizePixel = 0
dupechest.Position = UDim2.new(0.0869999975, 0, 0.25999999, 0)
dupechest.Size = UDim2.new(0, 125, 0, 25)
dupechest.Font = Enum.Font.SourceSans
dupechest.Text = "Dupe Chest"
dupechest.TextColor3 = Color3.fromRGB(255, 255, 255)
dupechest.TextSize = 16.000

dupechest.MouseButton1Click:Connect(function()
 game:GetService("ReplicatedStorage").GameRemotes.SortItem:InvokeServer(36)
 click:Play()
end)

killaura.Name = "killaura"
killaura.Parent = Frame
killaura.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
killaura.BorderColor3 = Color3.fromRGB(0, 0, 0)
killaura.BorderSizePixel = 0
killaura.Position = UDim2.new(0.0869999975, 0, 0.340000004, 0)
killaura.Size = UDim2.new(0, 125, 0, 25)
killaura.Font = Enum.Font.SourceSans
killaura.Text = "Aura"
killaura.TextColor3 = Color3.fromRGB(255, 0, 0)
killaura.TextSize = 16.000
killaurabool = false

auracd = 0.5
killaura.MouseButton1Click:Connect(function()
if killaurabool == false then
 killaurabool = true
 click:Play()
 killaura.TextColor3 = Color3.fromRGB(0, 128, 0)
while killaurabool == true do
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character.Humanoid.Health > 0 and game.Players.LocalPlayer:DistanceFromCharacter(v.Character.HumanoidRootPart.Position) < 16 then
game.ReplicatedStorage.GameRemotes.Attack:InvokeServer(v.Character)
game.ReplicatedStorage.GameRemotes.Attack:InvokeServer(false)
end
end
task.wait(auracd)
end
else
 killaurabool = false
 cancel:Play()
 killaura.TextColor3 = Color3.fromRGB(255, 0, 0)
end
end)

esp.Name = "esp"
esp.Parent = Frame
esp.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
esp.BorderColor3 = Color3.fromRGB(0, 0, 0)
esp.BorderSizePixel = 0
esp.Position = UDim2.new(0.0869999975, 0, 0.419999987, 0)
esp.Size = UDim2.new(0, 125, 0, 25)
esp.Font = Enum.Font.SourceSans
esp.Text = "ESP"
esp.TextColor3 = Color3.fromRGB(255, 0, 0)
esp.TextSize = 16.000
espbool = false

esp.MouseButton1Click:Connect(function()
if espbool == false then
 espbool = true
 click:Play()
 esp.TextColor3 = Color3.fromRGB(0, 128, 0)
else
 espbool = false
 cancel:Play()
 esp.TextColor3 = Color3.fromRGB(255, 0, 0)
end
end)

auraFrame.Name = "auraFrame"
auraFrame.Parent = Frame
auraFrame.BackgroundColor3 = Color3.fromRGB(85, 85, 85)
auraFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
auraFrame.BorderSizePixel = 0
auraFrame.Position = UDim2.new(1.0866667, 0, 0.0828571394, 0)
auraFrame.Size = UDim2.new(0, 100, 0, 125)

EditorName.Name = "EditorName"
EditorName.Parent = auraFrame
EditorName.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
EditorName.BorderColor3 = Color3.fromRGB(0, 0, 0)
EditorName.BorderSizePixel = 0
EditorName.Size = UDim2.new(0, 100, 0, 30)
EditorName.Font = Enum.Font.SourceSans
EditorName.Text = "Aura Editor"
EditorName.TextColor3 = Color3.fromRGB(255, 255, 255)
EditorName.TextSize = 16.000

aurawait.Name = "aurawait"
aurawait.Parent = auraFrame
aurawait.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
aurawait.BorderColor3 = Color3.fromRGB(0, 0, 0)
aurawait.BorderSizePixel = 0
aurawait.Position = UDim2.new(0.129999995, 0, 0.280000001, 0)
aurawait.Size = UDim2.new(0, 75, 0, 25)
aurawait.Font = Enum.Font.SourceSans
aurawait.Text = "Mode: CD"
aurawait.TextColor3 = Color3.fromRGB(255, 255, 255)
aurawait.TextSize = 14.000
aurawait.TextWrapped = true
aurawaitmode = 0

aurawait.MouseButton1Click:Connect(function()
if aurawaitmode == 0 then
 aurawaitmode = 1
 click:Play()
 aurawait.Text = "Mode: Spam"
 auracd = 0.1
else
 aurawaitmode = 0
 click:Play()
 aurawait.Text = "Mode: CD"
 auracd = 0.5
end
end)

keybind.Name = "keybind"
keybind.Parent = auraFrame
keybind.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
keybind.BorderSizePixel = 0
keybind.Position = UDim2.new(0.129999995, 0, 0.5, 0)
keybind.Size = UDim2.new(0, 75, 0, 25)
keybind.Font = Enum.Font.SourceSans
keybind.Text = "[K] Keybind"
keybind.TextColor3 = Color3.fromRGB(255, 0, 0)
keybind.TextSize = 14.000
keybind.TextWrapped = true
keybindbool = false

keybind.MouseButton1Click:Connect(function()
if keybindbool == false then
 keybindbool = true
 killaurabool = false
 killaura.Interactable = false
 killaura.TextColor3 = Color3.fromRGB(255, 0, 0)
 click:Play()
 keybind.TextColor3 = Color3.fromRGB(0, 128, 0)
else
 keybindbool = false
 killaura.Interactable = true
 killaura.TextColor3 = Color3.fromRGB(255, 0, 0)
 killaurabool = false
 cancel:Play()
 keybind.TextColor3 = Color3.fromRGB(255, 0, 0)
end
end)

ESPFrame.Name = "ESPFrame"
ESPFrame.Parent = Frame
ESPFrame.BackgroundColor3 = Color3.fromRGB(85, 85, 85)
ESPFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
ESPFrame.BorderSizePixel = 0
ESPFrame.Position = UDim2.new(1.0866667, 0, 0.460142821, 0)
ESPFrame.Size = UDim2.new(0, 100, 0, 125)

EditorName_2.Name = "EditorName"
EditorName_2.Parent = ESPFrame
EditorName_2.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
EditorName_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
EditorName_2.BorderSizePixel = 0
EditorName_2.Size = UDim2.new(0, 100, 0, 30)
EditorName_2.Font = Enum.Font.SourceSans
EditorName_2.Text = "ESP Editor"
EditorName_2.TextColor3 = Color3.fromRGB(255, 255, 255)
EditorName_2.TextSize = 16.000

fillvisible.Name = "fillvisible"
fillvisible.Parent = ESPFrame
fillvisible.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
fillvisible.BorderColor3 = Color3.fromRGB(0, 0, 0)
fillvisible.BorderSizePixel = 0
fillvisible.Position = UDim2.new(0.129999995, 0, 0.280000001, 0)
fillvisible.Size = UDim2.new(0, 75, 0, 25)
fillvisible.Font = Enum.Font.SourceSans
fillvisible.Text = "Fill Visibility"
fillvisible.TextColor3 = Color3.fromRGB(255, 0, 0)
fillvisible.TextSize = 14.000
fillvisible.TextWrapped = true
fvbool = false

fillvisible.MouseButton1Click:Connect(function()
if fvbool == false then
 fvbool = true
 click:Play()
 fillvisible.TextColor3 = Color3.fromRGB(0, 128, 0)
else
 fvbool = false
end
end)

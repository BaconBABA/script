local player = game.Players.Hum_lex56
local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")

humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(0, math.rad(90), math.rad(90))

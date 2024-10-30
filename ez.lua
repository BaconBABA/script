local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://18861270540" -- Set the sound ID
sound.Volume = 10                           -- Set the volume
sound.Parent = localPlayer.Character        -- Parent the sound to LocalPlayer's character
sound:Play()
wait(1)
sound:Destroy()

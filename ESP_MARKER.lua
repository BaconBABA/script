for i,v in pairs(game.Workspace:GetChildren()) do
	if string.find(v.Name, "Marker") ~= nil then
		local highlight = Instance.new("Highlight")
        highlight.Adornee = v
        highlight.Parent = v

        highlight.FillColor = Color3.new(1, 0, 0)
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
	end
end

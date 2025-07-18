# PartCircleModule.luau

```lua
local function PartCircleModule(center, radius, partCount)
	local parts = {}
	for i = 1, partCount do
		local angle = (2 * math.pi / partCount) * i
		local x = center.X + radius * math.cos(angle)
		local z = center.Z + radius * math.sin(angle)
		local part = Instance.new("Part")
		part.Position = Vector3.new(x, center.Y, z)
		part.Anchored = true
		part.Parent = workspace
		parts[#parts + 1] = part
	end
	return parts
end

return PartCircleModule
```

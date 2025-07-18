# FindGroundPos.luau

```lua
local function FindGroundPos(position)
	local ray = Ray.new(position, Vector3.new(0, -1000, 0))
	local hit, hitPosition = workspace:FindPartOnRay(ray)
	if hit then
		return hitPosition
	else
		return position
	end
end

return FindGroundPos
```

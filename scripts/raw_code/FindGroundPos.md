# Raw Code: FindGroundPos.luau

```lua
-- Utility to find ground position
local function FindGroundPos(origin)
	local ray = Ray.new(origin, Vector3.new(0, -1000, 0))
	local hit, position = workspace:FindPartOnRay(ray)
	return position or origin
end

return FindGroundPos
```

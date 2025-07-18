# Raw Code: ClickDetector.luau

```lua
-- Click detector utility
local ClickDetector = {}

function ClickDetector.Enable(part)
	local detector = Instance.new("ClickDetector", part)
	detector.MaxActivationDistance = 32
	return detector
end

return ClickDetector
```

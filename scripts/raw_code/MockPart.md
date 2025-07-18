# Raw Code: MockPart.luau

```lua
-- Mock part for testing
local MockPart = {}

function MockPart.New()
	local part = Instance.new("Part")
	part.Anchored = true
	return part
end

return MockPart
```

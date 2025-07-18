# Raw Code: CreateWeld.luau

```lua
-- Utility to create welds between parts
local function CreateWeld(part0, part1)
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = part0
	weld.Part1 = part1
	weld.Parent = part0
	return weld
end

return CreateWeld
```

# CreateWeld.luau

```lua
local function CreateWeld(part1, part2)
	local weld = Instance.new("Weld")
	weld.Part0 = part1
	weld.Part1 = part2
	weld.Parent = part1
	return weld
end

return CreateWeld
```

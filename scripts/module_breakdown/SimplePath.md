# SimplePath.luau

```lua
local SimplePath = {}
SimplePath.__index = SimplePath

function SimplePath.new()
	local self = setmetatable({}, SimplePath)
	return self
end

function SimplePath:MoveTo(target, duration)
	-- Move logic here
end

return SimplePath
```

# Fusion/External.luau

```lua
local External = {}
External.__index = External

function External.new()
	local self = setmetatable({}, External)
	return self
end

function External:DoSomething()
	-- External logic
end

return External
```

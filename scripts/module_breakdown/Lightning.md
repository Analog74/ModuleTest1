# Lightning.luau

```lua
local Lightning = {}
Lightning.__index = Lightning

function Lightning.new()
	local self = setmetatable({}, Lightning)
	return self
end

function Lightning:Activate()
	-- Lightning ability logic
end

return Lightning
```

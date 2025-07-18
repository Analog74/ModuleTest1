# Baal.luau

```lua
local Baal = {}
Baal.__index = Baal

function Baal.new()
	local self = setmetatable({}, Baal)
	return self
end

function Baal:Activate()
	-- Baal ability logic
end

return Baal
```

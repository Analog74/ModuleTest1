# OTS.luau

```lua
local OTS = {}
OTS.__index = OTS

function OTS.new()
	local self = setmetatable({}, OTS)
	return self
end

function OTS:DoSomething()
	-- Utility function
end

return OTS
```

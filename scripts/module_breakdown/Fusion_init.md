# Fusion/init.luau

```lua
local Fusion = {}
Fusion.__index = Fusion

function Fusion.new()
	local self = setmetatable({}, Fusion)
	return self
end

function Fusion:CreateUI()
	-- Fusion UI logic
end

return Fusion
```

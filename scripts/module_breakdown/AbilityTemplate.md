# AbilityTemplate.luau

```lua
local AbilityTemplate = {}
AbilityTemplate.__index = AbilityTemplate

function AbilityTemplate.new()
	local self = setmetatable({}, AbilityTemplate)
	return self
end

function AbilityTemplate:Activate()
	-- Ability activation logic
end

return AbilityTemplate
```

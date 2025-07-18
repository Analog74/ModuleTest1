# Fluent Renewed/init.luau

```lua
local FluentRenewed = {}
FluentRenewed.__index = FluentRenewed

function FluentRenewed.new()
	local self = setmetatable({}, FluentRenewed)
	return self
end

function FluentRenewed:CreateWidget()
	-- Fluent Renewed widget logic
end

return FluentRenewed
```

# Fluent Renewed/Components/Assets.luau

```lua
local Assets = {}
Assets.__index = Assets

function Assets.new()
	local self = setmetatable({}, Assets)
	return self
end

function Assets:Load()
	-- Asset loading logic
end

return Assets
```

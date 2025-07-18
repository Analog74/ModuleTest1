# Fluent Renewed/Components/TitleBar.luau

```lua
local TitleBar = {}
TitleBar.__index = TitleBar

function TitleBar.new()
	local self = setmetatable({}, TitleBar)
	return self
end

function TitleBar:Show()
	-- Title bar show logic
end

return TitleBar
```

# Fluent Renewed/Components/Window.luau

```lua
local Window = {}
Window.__index = Window

function Window.new()
	local self = setmetatable({}, Window)
	return self
end

function Window:Open()
	-- Window open logic
end

return Window
```

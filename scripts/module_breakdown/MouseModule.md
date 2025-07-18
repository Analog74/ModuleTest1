# MouseModule.luau

```lua
local MouseModule = {}
MouseModule.__index = MouseModule

function MouseModule.new()
	local self = setmetatable({}, MouseModule)
	self.callbacks = {}
	return self
end

function MouseModule:Connect(callback)
	table.insert(self.callbacks, callback)
end

function MouseModule:Fire(...)
	for _, callback in ipairs(self.callbacks) do
		callback(...)
	end
end

return MouseModule
```

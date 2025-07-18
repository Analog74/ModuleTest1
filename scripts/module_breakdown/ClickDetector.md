# ClickDetector.luau

```lua
local ClickDetector = {}
ClickDetector.__index = ClickDetector

function ClickDetector.new(part)
	local self = setmetatable({}, ClickDetector)
	self.part = part
	self.callbacks = {}
	return self
end

function ClickDetector:Connect(callback)
	table.insert(self.callbacks, callback)
end

function ClickDetector:Fire(...)
	for _, callback in ipairs(self.callbacks) do
		callback(...)
	end
end

return ClickDetector
```

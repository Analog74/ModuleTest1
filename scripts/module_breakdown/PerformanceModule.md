# PerformanceModule.luau

```lua
local PerformanceModule = {}
PerformanceModule.__index = PerformanceModule

function PerformanceModule.new()
	local self = setmetatable({}, PerformanceModule)
	self.startTime = os.clock()
	return self
end

function PerformanceModule:Start()
	self.startTime = os.clock()
end

function PerformanceModule:Stop()
	return os.clock() - self.startTime
end

return PerformanceModule
```

# ViewportHandler.luau

```lua
local ViewportHandler = {}
ViewportHandler.__index = ViewportHandler

function ViewportHandler.new(viewportFrame)
	local self = setmetatable({}, ViewportHandler)
	self.viewportFrame = viewportFrame
	return self
end

function ViewportHandler:ShowModel(model)
	model.Parent = self.viewportFrame
end

function ViewportHandler:Clear()
	for _, child in ipairs(self.viewportFrame:GetChildren()) do
		child:Destroy()
	end
end

return ViewportHandler
```

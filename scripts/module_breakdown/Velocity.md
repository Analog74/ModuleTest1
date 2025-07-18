# Velocity.luau

```lua
local function Velocity(part, velocity, duration)
	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.Velocity = velocity
	bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	bodyVelocity.Parent = part
	game:GetService("Debris"):AddItem(bodyVelocity, duration)
end

return Velocity
```

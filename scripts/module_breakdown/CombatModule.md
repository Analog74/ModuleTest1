# CombatModule.luau

```lua
local CombatModule = {}
CombatModule.__index = CombatModule

function CombatModule.new()
	local self = setmetatable({}, CombatModule)
	self.state = "idle"
	return self
end

function CombatModule:Attack(target)
	self.state = "attacking"
	-- attack logic here
end

function CombatModule:Defend()
	self.state = "defending"
	-- defend logic here
end

return CombatModule
```

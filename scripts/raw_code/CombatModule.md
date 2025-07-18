# Raw Code: CombatModule.luau

```lua
-- Combat module for handling attacks and damage
local CombatModule = {}

function CombatModule.Attack(target, damage)
	if target and target:FindFirstChild("Health") then
		target.Health.Value = target.Health.Value - damage
	end
end

function CombatModule.IsAlive(target)
	return target and target:FindFirstChild("Health") and target.Health.Value > 0
end

return CombatModule
```

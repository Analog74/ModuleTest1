# LightningBolt/LightningExplosion/init.luau

```lua
local LightningExplosion = {}
LightningExplosion.__index = LightningExplosion

function LightningExplosion.new()
	local self = setmetatable({}, LightningExplosion)
	return self
end

function LightningExplosion:Explode()
	-- Explosion logic
end

return LightningExplosion
```

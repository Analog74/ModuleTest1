# BoatTween.luau

```lua
local BoatTween = {}
BoatTween.__index = BoatTween

function BoatTween.new()
	local self = setmetatable({}, BoatTween)
	return self
end

function BoatTween:TweenObject(object, data)
	-- Tween logic here
end

return BoatTween
```

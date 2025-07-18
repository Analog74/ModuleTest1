# BezierTweens/BezierTweens.luau

```lua
local BezierTweens = {}
BezierTweens.__index = BezierTweens

function BezierTweens.new()
	local self = setmetatable({}, BezierTweens)
	return self
end

function BezierTweens:Tween(a, b, t)
	return a + (b - a) * t
end

return BezierTweens
```

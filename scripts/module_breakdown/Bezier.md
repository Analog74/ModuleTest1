# Bezier.luau

```lua
return function(t, p0, p1, p2, p3)
	local u = 1 - t
	local tt = t * t
	local uu = u * u
	local uuu = uu * u
	local ttt = tt * t
	local p = uuu * p0
	p = p + 3 * uu * t * p1
	p = p + 3 * u * tt * p2
	p = p + ttt * p3
	return p
end
```

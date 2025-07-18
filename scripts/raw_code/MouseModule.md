# Raw Code: MouseModule.luau

```lua
-- Mouse utility module
local MouseModule = {}

function MouseModule.GetPosition(mouse)
	return mouse.Hit.p
end

return MouseModule
```

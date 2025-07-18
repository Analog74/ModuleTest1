# RockModule.luau

```lua
-- Services
local Replicated = game:GetService('ReplicatedStorage')

local TweenService = game:GetService('TweenService')
local Debris = game:GetService('Debris')

-- Assets
local VelocityNew = require(Replicated.Modules.Shared.Velocity)

return {
	['Debris'] = function(Object, Scale, Strength, Amount)
		local RaycastParam = RaycastParams.new()
		RaycastParam.FilterType = Enum.RaycastFilterType.Blacklist
		RaycastParam.FilterDescendantsInstances = {Object, workspace.Effects}

		for _ = 1, Amount or 15 do
			local Rock = Instance.new('Part')
			Rock.Name = 'Rock'
			Rock.Position = Object.Position + Vector3.new(math.random(-7.5, 7.5), 3, math.random(-7.5, 7.5))
			Rock.Size = Vector3.new(Scale, Scale, Scale)
			Rock.CanTouch = false
			Rock.CanCollide = false

			local Raycast = workspace:Raycast(Rock.Position, Rock.CFrame.UpVector * -5, RaycastParam)
			if Raycast then
				Rock.Material = Raycast.Material
				Rock.Color = Raycast.Instance.Color
				Rock.Orientation = Vector3.new(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180))
				Rock.Parent = workspace
				
				VelocityNew(Rock.CFrame.UpVector * Strength, 0.35, Rock)
				TweenService:Create(Rock, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {Orientation = Rock.Orientation + Vector3.new(360, 360, 360)}):Play()

				Debris:AddItem(Rock, 5)
			end
		end
	end,
	
	['Crater'] = function(Object, Radius, Size, Amount, AngleIndex)
		local Angle = 0

		local RaycastParam = RaycastParams.new()
		RaycastParam.FilterType = Enum.RaycastFilterType.Blacklist
		RaycastParam.FilterDescendantsInstances = {Object, workspace.Effects}

		for _ = 1, Amount or 18 do
			local Scale = Size
			
			local Rock = Instance.new('Part')
			Rock.Name = 'RockCrater'
```

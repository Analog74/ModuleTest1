# All Raw Code: MasterScript Project

This document contains the raw code for all `.luau` files in the project, organized by module/folder. Each file is labeled and wrapped in a code block for easy reference.

---

## Main
### ProjectilePresets.luau
```lua
return {
	Heart = {
		Speed = 20,
	},
	
	Geometry = {
		Speed = 8.5
	},
	
	Dark = {
		Speed = 1
	},
	
	Lightning = {
		Speed = 3.5
	},
	
	Laser = {
		Speed = 7.5
	},
	
	Fireball = {
		Speed = 2.85
	}
}
```

## Auxiliary
### FaceToMouse.luau
```lua
-- Services
local RunService = game:GetService('RunService')

local Module = { }
Module.Connections = { }

Module.Init = function( PrimaryPart, Mouse )
	if #Module.Connections >= 1 then return end

	local BodyGyro = Instance.new('BodyGyro')
	BodyGyro.Name = 'FaceMouse'
	BodyGyro.MaxTorque = Vector3.new(1e008, 1e008, 1e008)
	BodyGyro.P = 10000
	BodyGyro.D = 325
	BodyGyro.Parent = PrimaryPart

	-- We update the CFrame of the constraints every frame.
	Module.Connections[#Module.Connections + 1] = RunService.RenderStepped:Connect(function()
		BodyGyro.CFrame = CFrame.lookAt( PrimaryPart.CFrame.Position, Mouse.Hit.Position )
	end)
end

Module.Deinit = function(PrimaryPart)
	PrimaryPart:FindFirstChild('FaceMouse'):Destroy()
	for _, v in ipairs( Module.Connections )  do
		v:Disconnect()
	end
	Module.Connections = { }
end

return Module
```

### RockModule.luau
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
			Rock.Anchored = true
			Rock.CanCollide = false
			Rock.CanTouch = false
			Rock.CFrame = Object.CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(Angle), 0) * CFrame.new(0, -0.65, -Radius)
			Rock.Size = Vector3.new(Scale, Scale, Scale)

			local Raycast = workspace:Raycast(Rock.Position, Rock.CFrame.UpVector * -5, RaycastParam)

			if Raycast then
				Rock.CFrame = Rock.CFrame * CFrame.new(0, -Scale + -1.5, 0)
				Rock.Material = Raycast.Material
				Rock.Color = Raycast.Instance.Color
				Rock.Parent = workspace

				TweenService:Create(Rock, TweenInfo.new(math.random(1.15, 1.35), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = Rock.Position + Vector3.new(0, Scale, 0), Orientation = Vector3.new(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180))}):Play()

				coroutine.wrap(function()
					task.wait(2)
					TweenService:Create(Rock, TweenInfo.new(math.random(1, 2), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = Rock.Position + Vector3.new(0, -Scale, 0), Orientation = Vector3.new(Rock.Orientation.X, Rock.Orientation.Y, -70)}):Play()
					Debris:AddItem(Rock, 4)
				end)()
			end

			Angle += AngleIndex or 20
		end
	end,
}
```

### RockModule2/init.luau
```lua
--[[
	TYPES:
	Crater
	Orbit
	Path
	Rounded Path
	Closed Path
	Wall Break
	Expanding Crater
	Expanding Orbit
	
	------------------------------
	PROPERTIES:
	
	PartCount -- INTEGER NUMBER TO DICTATE THE AMOUNT OF PARTS IN AN ORBIT/CRATER ATTACK 
	Radius -- SIZE OF A CRATER/ORBIT // For expanding you must put it in list like so: {3,10}. The first value is the staring radius, and the second being the ending radius.
	Range -- RAYCAST MAX DISTANCE DOWNWARDS
	Size -- VECTOR3 VALUE DICTATING PART SIZE
	AnimationSpeed -- HOW FAST THE PARTS SPAWN UPWARDS
	BlockSize -- THE SIZE OF A BLOCK IN A PATH (NOTE: RUN THIS VIA A LIST VALUE: {3,4} THE FIRST BEING THE INITIAL SIZE AND THE SECOND BEING THE FINAL SIZE)
	Width -- THE WIDTH OF A PATH (NOTE: RUN THIS VIA A LIST VALUE: {3,4} THE FIRST BEING THE INITIAL WIDTH AND THE SECOND BEING THE FINAL WIDTH)
	Distance -- THIS IS A PATH TRAVELS
	stepSize -- DISTANCE BETWEEN THE PATH PARTS
	HoldTime -- TIME IN SECONDS BEFORE AN EFFECT DISAPPEARS
	delayTime -- TIME BETWEEN NEXT PART IN PATH (NOTE: PUTTING THIS TO "Stepped" MAKES THE DELAY TIME RUN IN A RUNSERVICE HEARTBEAT)
	Angle -- CRATER ANGLE
	Height -- HEIGHT OF AN EXPLOSION
	Collidable -- PART COLLIDABLILITY FOR WALLBREAK AND FOR EXPLOSION
	IncreaseSpeed -- THIS IS TO CHANGE THE ANIMATION SPEED FOR EXPANDING ORBITS OR EXPANDING CRATERS
	
	
	SET UP:
	[[		NEW		]]
--[[
	local craterEffects = require(craterModule)

	craterEffects.new(Type, AnchorPoint, Properties)

	-- Lets try using orbit with a 5 radius and 8 part count at a tween speed of 0.2
	
	
	craterEffects.new(
	'Orbit', -- This is the type of effect you want
	Character.HumanoidRootPart.CFrame, -- This is the start/center point (depending on the effect)
	{
	['AnimationSpeed'] = 0.2;
	['PartCount'] = 8;
	['Radius'] = 5
	}
	)
]]
local Functions = require(script:WaitForChild('Styles'))

callback = function(called, ErrorType)
	return warn('CRATER MODULE ERROR:\n\t\t\t\t\t'..called..' does not exist as a '..ErrorType)
end

return {
	new = function(Type : string, AnchorPoint : CFrame, ... : dict)
		if Functions[Type] then
			Functions[Type](AnchorPoint, ...)
		else callback(Type, 'type')
		end
		
	end,
}
```

---

*This document is auto-generated. For the full project, see the repository: https://github.com/Analog74/ModuleTest1.git*

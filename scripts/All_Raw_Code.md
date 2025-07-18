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

## Shared
### Bezier.luau
```lua
-- Functions
local function lerp(a, b, c)
	return a + (b - a) * c
end

return {
	QuadBezier = function(t, p0, p1, p2)
		local l1 = lerp(p0, p1, t)
		local l2 = lerp(p1, p2, t)
		local Quad = lerp(l1, l2, t)
		return Quad
	end,
}
```

---

## Auxiliary
### GameplayUtilities.luau
```lua
local cs = game:GetService("CollectionService")
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

local SOURCE_LOCALE = "en"
local translator = nil


local Misc = {}

Misc.StrongKnockback = function(target, strength1, strength2, duration, Origin)
	local EffectVelocity = Instance.new("BodyVelocity", target)
	EffectVelocity.MaxForce = Vector3.new(1, 1, 1) * 1000000;
	EffectVelocity.Velocity = Vector3.new(1, 1, 1) * Origin.CFrame.LookVector * math.random(strength1, strength2)

	game.Debris:AddItem(EffectVelocity, duration)
end

Misc.TweenNumber = function(TextInstance, NumberVal, Duration, DesiredValue, BeforeText, AfterText)
	local part = NumberVal

	local tweenInfo = TweenInfo.new(
		1,
		Enum.EasingStyle.Linear, 
		Enum.EasingDirection.Out, 
		1, 
		false, 
		0 
	)

	local tween = game.TweenService:Create(part, tweenInfo, {Value = DesiredValue})

	tween:Play()

	part.Changed:Connect(function(val)
		if not BeforeText and not AfterText then
			TextInstance.Text = tonumber(math.round(val))
		elseif BeforeText and not AfterText then
			TextInstance.Text = BeforeText..tonumber(math.round(val))
		elseif not BeforeText and AfterText then
			TextInstance.Text = tonumber(math.round(val))..AfterText
		elseif BeforeText and AfterText then
			TextInstance.Text = BeforeText..tonumber(math.round(val))..AfterText
		end
	end)
end

Misc.InsertDisabled = function(Target, Duration)
	local disabled = Instance.new("BoolValue")
	disabled.Name = "Disabled"
```

### CameraShaker/CameraShakePresets.luau
```lua
-- Camera Shake Presets
-- Stephen Leitnick
-- February 26, 2018

--[[
	
	CameraShakePresets.Bump
	CameraShakePresets.Explosion
	CameraShakePresets.Earthquake
	CameraShakePresets.BadTrip
	CameraShakePresets.HandheldCamera
	CameraShakePresets.Vibration
	CameraShakePresets.RoughDriving
	
--]]



local CameraShakeInstance = require(script.Parent.CameraShakeInstance)

local CameraShakePresets = {
	
	Lightning1 = function()
		local c = CameraShakeInstance.new(1.15, 10, 0, 1)
		c.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		c.RotationInfluence = Vector3.new(4, 1, 1)
		return c
	end,
	
	LightningBlade = function()
		local c = CameraShakeInstance.new(0.7, 10, 0, 1)
		c.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		c.RotationInfluence = Vector3.new(4, 1, 1)
		return c
	end,
	
	Fireball = function()
		local c = CameraShakeInstance.new(0.85, 10, 0, 1)
		c.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		c.RotationInfluence = Vector3.new(4, 1, 1)
		return c
	end,
	
	Orb = function()
		local c = CameraShakeInstance.new(3, 15, 0, 1.5)
		c.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		c.RotationInfluence = Vector3.new(4, 1, 1)
		return c
	end,
	
```

### CameraShaker/init.luau
```lua
-- Camera Shaker
-- Stephen Leitnick
-- February 26, 2018

--[[
	
	CameraShaker.CameraShakeInstance
	
	cameraShaker = CameraShaker.new(renderPriority, callbackFunction)
	
	CameraShaker:Start()
	CameraShaker:Stop()
	CameraShaker:StopSustained([fadeOutTime])
	CameraShaker:Shake(shakeInstance)
	CameraShaker:ShakeSustain(shakeInstance)
	CameraShaker:ShakeOnce(magnitude, roughness [, fadeInTime, fadeOutTime, posInfluence, rotInfluence])
	CameraShaker:StartShake(magnitude, roughness [, fadeInTime, posInfluence, rotInfluence])
	
	
	
	EXAMPLE:
	
		local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCFrame)
			camera.CFrame = playerCFrame * shakeCFrame
		end)
		
		camShake:Start()
		
		-- Explosion shake:
		camShake:Shake(CameraShaker.Presets.Explosion)
		
		wait(1)
		
		-- Custom shake:
		camShake:ShakeOnce(3, 1, 0.2, 1.5)

		-- Sustained shake:
		camShake:ShakeSustain(CameraShaker.Presets.Earthquake)

		-- Stop all sustained shakes:
		camShake:StopSustained(1) -- Argument is the fadeout time (defaults to the same as fadein time if not supplied)

		-- Stop only one sustained shake:
		shakeInstance = camShake:ShakeSustain(CameraShaker.Presets.Earthquake)
		wait(2)
		shakeInstance:StartFadeOut(1) -- Argument is the fadeout time
	
	
	NOTE:
	
```

### CameraShaker/CameraShakeInstance.luau
```lua
-- Camera Shake Instance
-- Stephen Leitnick
-- February 26, 2018

--[[
	
	cameraShakeInstance = CameraShakeInstance.new(magnitude, roughness, fadeInTime, fadeOutTime)
	
--]]



local CameraShakeInstance = {}
CameraShakeInstance.__index = CameraShakeInstance

local V3 = Vector3.new
local NOISE = math.noise


CameraShakeInstance.CameraShakeState = {
	FadingIn = 0;
	FadingOut = 1;
	Sustained = 2;
	Inactive = 3;
}


function CameraShakeInstance.new(magnitude, roughness, fadeInTime, fadeOutTime)
	
	if (fadeInTime == nil) then fadeInTime = 0 end
	if (fadeOutTime == nil) then fadeOutTime = 0 end
	
	assert(type(magnitude) == "number", "Magnitude must be a number")
	assert(type(roughness) == "number", "Roughness must be a number")
	assert(type(fadeInTime) == "number", "FadeInTime must be a number")
	assert(type(fadeOutTime) == "number", "FadeOutTime must be a number")
	
	local self = setmetatable({
		Magnitude = magnitude;
		Roughness = roughness;
		PositionInfluence = V3();
		RotationInfluence = V3();
		DeleteOnInactive = true;
		roughMod = 1;
		magnMod = 1;
		fadeOutDuration = fadeOutTime;
		fadeInDuration = fadeInTime;
		sustain = (fadeInTime > 0);
		currentFadeTime = (fadeInTime > 0 and 0 or 1);
		tick = Random.new():NextNumber(-100, 100);
	}, CameraShakeInstance)
	
	return self
end


function CameraShakeInstance:Start()
	self.Active = true
	self.Increment = 0
	self.CurrentMagnitude = self.Magnitude
	self.CurrentRoughness = self.Roughness
	self.CurrentFadeTime = self.fadeInDuration
	
	if (self.sustain) then
		self.State = CameraShakeInstance.CameraShakeState.Sustained
	else
		self.State = CameraShakeInstance.CameraShakeState.FadingIn
	end
	
	self.StartTime = tick()
end


function CameraShakeInstance:Stop(fadeOutTime)
	if (fadeOutTime) then
		self.fadeOutDuration = fadeOutTime
	end
	
	if (self.State == CameraShakeInstance.CameraShakeState.Inactive) then
		return
	end
	
	self.State = CameraShakeInstance.CameraShakeState.FadingOut
	self.CurrentFadeTime = 0
	self.StartTime = tick()
end


function CameraShakeInstance:StartFadeOut(fadeOutTime)
	self:Stop(fadeOutTime)
end


function CameraShakeInstance:Update()
	if (self.State == CameraShakeInstance.CameraShakeState.Inactive) then
		return
	end
	
	local delta = tick() - self.StartTime
	
	if (self.State == CameraShakeInstance.CameraShakeState.FadingIn) then
		self.CurrentFadeTime = math.min(self.fadeInDuration, self.CurrentFadeTime + (delta * 1))
		self.CurrentMagnitude = self.Magnitude * (self.CurrentFadeTime / self.fadeInDuration)
		self.CurrentRoughness = self.Roughness * (self.CurrentFadeTime / self.fadeInDuration)
		
		if (self.CurrentFadeTime == self.fadeInDuration) then
			self.State = CameraShakeInstance.CameraShakeState.Sustained
		end
	elseif (self.State == CameraShakeInstance.CameraShakeState.FadingOut) then
		self.CurrentFadeTime = math.min(self.fadeOutDuration, self.CurrentFadeTime + (delta * 1))
		self.CurrentMagnitude = self.Magnitude * (1 - (self.CurrentFadeTime / self.fadeOutDuration))
		self.CurrentRoughness = self.Roughness * (1 - (self.CurrentFadeTime / self.fadeOutDuration))
		
		if (self.CurrentFadeTime == self.fadeOutDuration) then
			if (self.DeleteOnInactive) then
				self:Stop()
			else
				self.State = CameraShakeInstance.CameraShakeState.Inactive
			end
		end
	end
	
	self.Increment = (self.Increment + 1) % 2
	
	return (self.State ~= CameraShakeInstance.CameraShakeState.Inactive)
end


function CameraShakeInstance:IsActive()
	return (self.State ~= CameraShakeInstance.CameraShakeState.Inactive)
end


return CameraShakeInstance
```

---

## Assets
### Meshes/Potion/Potion/Template/init.meta 2.luau
```lua
return {
	["className"] = "MeshPart",
	["properties"] = {
		["Anchored"] = true,
		["CFrame"] = {
			-0.00288,
			16.654624,
			0.00077,
			-1,
			0,
			0,
			0,
			1,
			0,
			0,
			0,
			-1,
		},
		["CanCollide"] = false,
		["CastShadow"] = false,
		["Color"] = {
			100,
			66,
			248,
		},
		["InitialSize"] = {
			1.687793,
			1.444361,
			1.675487,
		},
		["Material"] = "Neon",
		["MeshContent"] = "rbxassetid://5435853405",
		["RenderFidelity"] = "Precise",
		["Size"] = {
			1.687793,
			1.444361,
			1.675487,
		},
	},
}
```

## Auxiliary
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

### RockModule2/Styles.luau
```lua
local workspace = workspace
local random = Random.new()

local IgnoreList = {game.Players.LocalPlayer.Character, workspace.Effects} -- CHANGE THIS TO IGNORE SPECIFIC INSTANCES

Params = RaycastParams.new()
Params.FilterType = Enum.RaycastFilterType.Blacklist
Params.FilterDescendantsInstances = IgnoreList
Params.IgnoreWater = true

local RunService = game:GetService('RunService')
local TweenService = game:GetService('TweenService')
local fullCircle = 2 * math.pi

local Rocks = script.Parent:WaitForChild('Rocks')
local Parent = workspace.Effects -- SET THE PARENT USING THIS

local rayPart = function(CFrameValue, Range, Properties, ownPart)
	
	local Results = workspace:Raycast(CFrameValue.Position, -CFrameValue.UpVector * Range, Params)
	
	if Results then
		local Part = ownPart or Instance.new('Part')
		Part.Parent = Parent
		Part.Anchored = true
		Part.CanCollide = false
		Part.Material = Results.Material
		Part.Color = Results.Instance.Color
		Part.CFrame = CFrame.new(Results.Position)
		Part.Reflectance = Results.Instance.Reflectance
		Part.Transparency = Results.Instance.Transparency
		if Properties then
			for property, value in ipairs( Properties ) do
				if Part[property] then
					Part[property] = value
				end
			end
		end

		return Part, Results
	else
		return false
	end
end
local Wait = task.wait()

local randInt = function(min, max)
	return random:NextNumber(min, max)
end

```

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

## ThirdParty
### Fluent Renewed/Elements/init.luau
```lua
local Elements = {}

for _, Element in next, script:GetChildren() do
	Elements[#Elements + 1] = require(Element)
end

return Elements

```
---

## ThirdParty
### Fluent Renewed/Elements/Colorpicker.luau
```lua
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Root = script.Parent.Parent
local Creator = require(Root.Modules.Creator)

local New = Creator.New
local Components = Root.Components

local Element = {}
Element.__index = Element
Element.__type = "Colorpicker"

function Element:New(Idx, Config)
	local Library = self.Library
	assert(Config.Title, "Colorpicker - Missing Title")
	assert(Config.Default, "AddColorPicker: Missing default value.")

	local Colorpicker = {
		Value = Config.Default or Config.Value,
		Transparency = Config.Transparency or 0,
		UpdateOnChange = Config.UpdateOnChange or Config.UpdateWhileSliding or false,
		Type = "Colorpicker",
		Title = type(Config.Title) == "string" and Config.Title or "Colorpicker",
		Callback = Config.Callback or function(Color) end,
	}

	function Colorpicker:SetHSVFromRGB(Color)
		local H, S, V = Color3.toHSV(Color)
		Colorpicker.Hue = H
		Colorpicker.Sat = S
		Colorpicker.Vib = V
	end

	Colorpicker:SetHSVFromRGB(Colorpicker.Value)

	local ColorpickerFrame = require(Components.Element)(Config.Title, Config.Description, self.Container, true)

	Colorpicker.SetTitle = ColorpickerFrame.SetTitle
	Colorpicker.SetDesc = ColorpickerFrame.SetDesc

	local DisplayFrameColor = New("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Colorpicker.Value,
		Parent = ColorpickerFrame.Frame,
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
	})

	local SliderHue = require(Components.Slider)(Config.Title.." Hue", {
		Min = 0,
		Max = 1,
		Default = 0,
		Callback = function(Value)
			Colorpicker.Value = Color3.fromHSV(Value, Colorpicker.Sat, Colorpicker.Vib)
			Colorpicker.Callback(Colorpicker.Value)
		end,
	}, self.Container)

	local SliderSat = require(Components.Slider)(Config.Title.." Saturation", {
		Min = 0,
		Max = 1,
		Default = 0,
		Callback = function(Value)
			Colorpicker.Value = Color3.fromHSV(Colorpicker.Hue, Value, Colorpicker.Vib)
			Colorpicker.Callback(Colorpicker.Value)
		end,
	}, self.Container)

	local SliderVal = require(Components.Slider)(Config.Title.." Value", {
		Min = 0,
		Max = 1,
		Default = 0,
		Callback = function(Value)
			Colorpicker.Value = Color3.fromHSV(Colorpicker.Hue, Colorpicker.Sat, Value)
			Colorpicker.Callback(Colorpicker.Value)
		end,
	}, self.Container)

	function ColorpickerFrame:Refresh()
		DisplayFrameColor.BackgroundColor3 = Colorpicker.Value
	end

	return ColorpickerFrame
end

return Element
```

### Fluent Renewed/Elements/Toggle.luau
```lua
local TweenService, UserInputService = game:GetService("TweenService"), game:GetService("UserInputService")
local Root = script.Parent.Parent
local Creator = require(Root.Modules.Creator)
 
local New = Creator.New
local Components = Root.Components

local Element = {}
Element.__index = Element
Element.__type = "Toggle"

function Element:New(Idx, Config)
	local Library = self.Library
	assert(Config.Title, "Toggle - Missing Title")

	local Toggle = {
		Value = Config.Default or Config.Value or false,
		Callback = Config.Callback or function(Value) end,
		Type = "Toggle",
	}

	local ToggleFrame = require(Components.Element)(Config.Title, Config.Description, self.Container, true)
	ToggleFrame.DescLabel.Size = UDim2.new(1, -54, 0, 14)

	Toggle.SetTitle = ToggleFrame.SetTitle
	Toggle.SetDesc = ToggleFrame.SetDesc

	local ToggleCircle = New("ImageLabel", {
		AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.fromOffset(14, 14),
		Position = UDim2.new(0, 2, 0.5, 0),
		Image = "http://www.roblox.com/asset/?id=12266946128",
		ImageTransparency = 0.5,
		ThemeTag = {
			ImageColor3 = "ToggleSlider",
		},
	}) :: ImageLabel

	local ToggleBorder = New("UIStroke", {
		Transparency = 0.5,
		ThemeTag = {
			Color = "ToggleSlider",
		},
	})

	local ToggleSlider = New("Frame", {
		Size = UDim2.fromOffset(36, 18),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -10, 0.5, 0),
		Parent = ToggleFrame.Frame,
	}, {
		ToggleCircle,
		ToggleBorder,
	})

	ToggleSlider:FindFirstChild("UICorner").CornerRadius = UDim.new(0, 4)

	local function UpdateToggle()
		local Goal = Toggle.Value and 1 or 0

		TweenService:Create(ToggleCircle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(Goal, 0, 0.5, 0)}):Play()
		TweenService:Create(ToggleBorder, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = Toggle.Value and 0 or 0.5}):Play()

		Library:SafeCallback(Toggle.Callback, Toggle.Value)
	end

	function ToggleFrame:Refresh()
		UpdateToggle()
	end

	Creator.AddSignal(ToggleFrame.Frame.MouseButton1Click, function()
		Toggle.Value = not Toggle.Value
		UpdateToggle()
	end)

	return ToggleFrame
end

return Element

```

### Fluent Renewed/Elements/Button.luau
```lua
local Root = script.Parent.Parent
local Creator = require(Root.Modules.Creator)
 
local New = Creator.New
local Components = Root.Components

local Element = {}
Element.__index = Element
Element.__type = "Button"

function Element:New(Config)
	assert(Config.Title, "Button - Missing Title")
	Config.Callback = Config.Callback or function() end

	local ButtonFrame = require(Components.Element)(Config.Title, Config.Description, self.Container, true)

	local ButtonIco = New("ImageLabel", {
		Size = UDim2.fromOffset(16, 16),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -10, 0.5, 0),
		BackgroundTransparency = 1,
		Parent = ButtonFrame.Frame,
		ThemeTag = {
			ImageColor3 = "Text",
		}
	}) :: ImageLabel

	self.Library.Utilities.Icons:SetIcon(ButtonIco, "chevron-right")

	Creator.AddSignal(ButtonFrame.Frame.MouseButton1Click, function()
		if typeof(Config.Callback) == "function" then
			self.Library:SafeCallback(Config.Callback, Config.Value)
		end
	end)

	ButtonFrame.Instance = ButtonFrame

	return ButtonFrame
end

return Element

```

### Fluent Renewed/Elements/Slider.luau
```lua
local UserInputService = game:GetService("UserInputService")
local Root = script.Parent.Parent
local Creator = require(Root.Modules.Creator)

local New = Creator.New
local Components = Root.Components

local Element = {}
Element.__index = Element
Element.__type = "Slider"

function Element:New(Idx, Config)
	local Library = self.Library
	assert(Config.Max, "Slider - Missing maximum value.")

	local Slider = {
		Value = nil,
		Min = typeof(Config.Min) == "number" and Config.Min or 0,
		Max = Config.Max,
		Rounding = typeof(Config.Rounding) == "number" and Config.Rounding or 0,
		Callback = typeof(Config.Callback) == "function" and Config.Callback or function(Value, OldValue) end,
		Changed = Config.Changed or function() end,
		Type = "Slider"
	}

	local Dragging = false

	local SliderFrame = require(Components.Element)(Config.Title or "Slider", Config.Description, self.Container, false)
	SliderFrame.DescLabel.Size = UDim2.new(1, -170, 0, 14)

	Slider.SetTitle = SliderFrame.SetTitle
	Slider.SetDesc = SliderFrame.SetDesc

	local SliderDot = New("ImageLabel", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, -7, 0.5, 0),
		Size = UDim2.fromOffset(14, 14),
		Image = "http://www.roblox.com/asset/?id=12266946128",
		ThemeTag = {
			ImageColor3 = "Accent",
		}
	})

	local SliderRail = New("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(7, 0),
		Size = UDim2.new(1, -14, 1, 0)
	}, {
		SliderDot,
	})

	SliderRail.Parent = SliderFrame.Frame

	local SliderProgress = New("Frame", {
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.5,
		Position = UDim2.fromOffset(7, 0),
		Size = UDim2.new(1, -14, 1, 0),
		ZIndex = 2,
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
	})

	local SliderButton = New("TextButton", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),
		Parent = SliderFrame.Frame,
	})

	local function UpdateSlider(Value, NoCallback)
		Value = math.clamp(Value, Slider.Min, Slider.Max)
		local OldValue = Slider.Value

		Slider.Value = Value

		local Percent = (Value - Slider.Min) / (Slider.Max - Slider.Min)

		SliderDot.Position = UDim2.new(Percent, 0, 0.5, 0)
		SliderProgress.Size = UDim2.new(Percent, 0, 1, 0)

		if not NoCallback then
			Library:SafeCallback(Slider.Callback, Value, OldValue)
		end
	end

	SliderButton.MouseButton1Down:Connect(function()
		Dragging = true
	end)

	RunService.RenderStepped:Connect(function()
		if Dragging then
			local MouseLocation = UserInputService:GetMouseLocation()
			local X = MouseLocation.X - SliderFrame.Frame.AbsolutePosition.X
			local Width = SliderFrame.Frame.AbsoluteSize.X

			local Percent = math.clamp(X / Width, 0, 1)

			UpdateSlider(Slider.Min + (Percent * (Slider.Max - Slider.Min)))
		end
	end)

	UserInputService.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = false
		end
	end)

	return SliderFrame
end

return Element
```

### Fluent Renewed/Elements/Input.luau
```lua
local Root = script.Parent.Parent
local Creator = require(Root.Modules.Creator)

local AddSignal = Creator.AddSignal
local Components = Root.Components

local Element = {}
Element.__index = Element
Element.__type = "Input"

function Element:New(Idx, Config)
	local Library = self.Library
	assert(Config.Title, "Input - Missing Title")
	Config.Callback = Config.Callback or function() end

	local Input = {
		Value = Config.Default or Config.Value or "",
		Numeric = Config.Numeric or false,
		Finished = Config.Finished or false,
		Callback = Config.Callback or function(Value) end,
		ClearOnFocusLost = Config.ClearOnFocusLost or false,
		Type = "Input",
	}

	local InputFrame = require(Components.Element)(Config.Title, Config.Description, self.Container, false)

	Input.SetTitle = InputFrame.SetTitle
	Input.SetDesc = InputFrame.SetDesc

	local Textbox = require(Components.Textbox)(InputFrame.Frame, true)
	Textbox.Frame.Position = UDim2.new(1, -10, 0.5, 0)
	Textbox.Frame.AnchorPoint = Vector2.new(1, 0.5)
	Textbox.Frame.Size = UDim2.fromOffset(160, 30)
	Textbox.Input.Text = Config.Default or ""
	Textbox.Input.PlaceholderText = Config.Placeholder or ""

	local Box = Textbox.Input

	function Input:SetValue(Text)
		if Config.MaxLength and #Text > Config.MaxLength then
			Text = Text:sub(1, Config.MaxLength)
		end

		if Input.Numeric then
			if (not tonumber(Text)) and Text:len() > 0 then
				Text = Input.Value
			end
		end

		rawset(Input, "Value", Text)

		Box.Text = Text
		Box.PlaceholderText = Config.Placeholder or ""

		if typeof(Input.Callback) == "function" then
			Library:SafeCallback(Input.Callback, Input.Value)
		end
	end

	function Input:Focus()
		Textbox.Frame.InputField:CaptureFocus()
	end

	function Input:Blur()
		Textbox.Frame.InputField:ReleaseFocus()
	end

	function Input:SetTextColor(Color)
		Box.TextColor3 = Color
	end

	function Input:SetPlaceholderColor(Color)
		Box.PlaceholderColor3 = Color
	end

	function Input:SetBackgroundColor(Color)
		Textbox.Frame.BackgroundColor3 = Color
	end

	function Input:SetBorderColor(Color)
		Textbox.Frame.BorderColor3 = Color
	end

	function Input:SetSize(UDim2)
		Textbox.Frame.Size = UDim2
	end

	function Input:SetPosition(UDim2)
		Textbox.Frame.Position = UDim2
	end

	function Input:SetAnchorPoint(Vector)
		Textbox.Frame.AnchorPoint = Vector
	end

	function Input:SetVisible(Visible)
		Textbox.Frame.Visible = Visible
	end

	function Input:SetZIndex(Index)
		Textbox.Frame.ZIndex = Index
	end

	function Input:SetFont(Font)
		Box.Font = Font
	end

	function Input:SetTextSize(Size)
		Box.TextSize = Size
	end

	function Input:SetRichText(Value)
		Box.RichText = Value
	end

	function Input:SetMaxLength(Length)
		Config.MaxLength = Length
	end

	function Input:SetNumeric(Value)
		Config.Numeric = Value
	end

	function Input:SetFinished(Value)
		Config.Finished = Value
	end

	function Input:SetClearOnFocusLost(Value)
		Config.ClearOnFocusLost = Value
	end

	function Input:SetCallback(Callback)
		Config.Callback = Callback
	end

	function Input:SetChangedCallback(Callback)
		Config.Changed = Callback
	end

	function Input:OnFocusLost()
		if Config.ClearOnFocusLost then
			self:SetValue("")
		end
	end

	Textbox.Frame.InputField.FocusLost:Connect(function()
		Input:OnFocusLost()
	end)

	return Input
end

return Element
```

---

## ThirdParty
### Fluent Renewed/Elements/Dropdown.luau
```lua
local UserInputService = game:GetService("UserInputService")
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local Camera = game:GetService("Workspace").CurrentCamera

local Root = script.Parent.Parent
local Creator = require(Root.Modules.Creator)
local Flipper = require(Root.Packages.Flipper)

local New = Creator.New
local Components = Root.Components

local Element = {}
Element.__index = Element
Element.__type = "Dropdown"

function Element:New(Idx, Config)
	local Library = self.Library

	local Dropdown = {
		Values = (function()
			local Idxes = {}

			for i,v in next, Config.Values or {} do
				Idxes[#Idxes + 1] = v
			end

			return Idxes
		end)(),
		Value = Config.Default or Config.Value,
		Multi = Config.Multi or false,
		AutoDeselect = Config.AutoDeselect or false,
		Searchable = Config.Searchable or false,
		FocusSearch = Config.FocusSearch or true,
		SearchPlaceholder = Config.SearchPlaceholder or "Search...",
		Displayer = typeof(Config.Displayer) == "function" and Config.Displayer or function(Value)
			return typeof(Value) ~= "number" and tostring(Library.Utilities:Prettify(Value)) or Value
		end,
		CustomDisplayer = (typeof(Config.Displayer) == "function" and Config.Displayer and true) or false,
		Buttons = {},
		Opened = false,
		Type = "Dropdown",
		Callback = Config.Callback or function() end,
		Changed = Config.Changed or function() end
	}

	local DropdownFrame = require(Components.Element)(Config.Title, Config.Description, self.Container, false)
	DropdownFrame.DescLabel.Size = UDim2.new(1, -170, 0, 14)

	Dropdown.SetTitle = DropdownFrame.SetTitle
	Dropdown.SetDesc = DropdownFrame.SetDesc

	local DropdownButton = DropdownFrame.Frame
	local DropdownList = DropdownFrame.List
	local DropdownSearch = DropdownFrame.Search

	local OpenedColor = Color3.fromRGB(30, 30, 30)
	local ClosedColor = Color3.fromRGB(20, 20, 20)

	DropdownButton.BackgroundColor3 = ClosedColor

	local function UpdateSize()
		task.spawn(function()
			local YSize = 0

			for _, Button in next, Dropdown.Buttons do
				if Button.Instance then
					YSize += Button.Instance.Size.Y.Offset
				end
			end

			DropdownList.Size = UDim2.new(1, 0, 0, math.clamp(YSize, 0, 300))
		end)
	end

	local function UpdatePosition()
		task.spawn(function()
			local Offset = 0

			if DropdownButton.AbsoluteSize.Y > 0 then
				Offset = DropdownButton.AbsolutePosition.Y + DropdownButton.AbsoluteSize.Y
			end

			DropdownList.Position = UDim2.new(0, 0, 0, Offset)
		end)
	end

	local function UpdateScroll()
		task.spawn(function()
			if DropdownList.AbsoluteSize.Y > 0 then
				DropdownList.CanvasSize = UDim2.new(0, 0, 0, DropdownList.UIListLayout.AbsoluteContentSize.Y)
			end
		end)
	end

	function Dropdown:Refresh()
		for _, Button in next, Dropdown.Buttons do
			if Button.Instance then
				Button:Refresh()
			end
		end

		UpdateSize()
		UpdatePosition()
		UpdateScroll()
	end

	function Dropdown:Toggle(Force)
		if Dropdown.Opened or Force then
			Dropdown.Opened = false

			DropdownButton.BackgroundColor3 = ClosedColor

			DropdownList.Visible = false
			DropdownList.Size = UDim2.new(1, 0, 0, 0)

			Flipper.tween(DropdownList, {
				Size = UDim2.new(1, 0, 0, 0),
				Position = UDim2.new(0, 0, 0, 0),
				BackgroundTransparency = 1,
			}, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		else
			Dropdown.Opened = true

			DropdownButton.BackgroundColor3 = OpenedColor

			DropdownList.Visible = true

			UpdatePosition()
			UpdateSize()
			UpdateScroll()

			Flipper.tween(DropdownList, {
				Size = UDim2.new(1, 0, 0, math.clamp(DropdownList.UIListLayout.AbsoluteContentSize.Y, 0, 300)),
				Position = UDim2.new(0, 0, 0, DropdownButton.AbsolutePosition.Y + DropdownButton.AbsoluteSize.Y),
				BackgroundTransparency = 0,
			}, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		end
	end

	function Dropdown:AddButton(Text, Value, Callback, NoRefresh)
		local Button = require(Components.DropdownButton)(Text, Value, Callback, DropdownFrame.List)

		Dropdown.Buttons[#Dropdown.Buttons + 1] = Button

		if not NoRefresh then
			Dropdown:Refresh()
		end

		return Button
	end

	function Dropdown:SetValue(Value, NoCallback)
		Dropdown.Value = Value

		for _, Button in next, Dropdown.Buttons do
			if Button.SetState then
				Button:SetState(Button.Value == Value)
			end
		end

		if not NoCallback then
			Library:SafeCallback(Dropdown.Callback, Value)
		end
	end

	function Dropdown:SearchFor(Text)
		Text = Text:lower()

		for _, Button in next, Dropdown.Buttons do
			if Button.Instance then
				local Visible = Button.Text:lower():find(Text) ~= nil

				Button.Instance.Visible = Visible
			end
		end

		UpdateSize()
		UpdateScroll()
	end

	DropdownButton.MouseButton1Click:Connect(function()
		Dropdown:Toggle()
	end)

	DropdownSearch:GetPropertyChangedSignal("Text"):Connect(function()
		Dropdown:SearchFor(DropdownSearch.Text)
	end)

	DropdownFrame.Instance = DropdownFrame

	return DropdownFrame
end

return Element
```

### Fluent Renewed/Elements/Keybind.luau
```lua
local UserInputService = game:GetService("UserInputService")

local Root = script.Parent.Parent
local Creator = require(Root.Modules.Creator)

local New = Creator.New
local Components = Root.Components

local Element = {}
Element.__index = Element
Element.__type = "Keybind"

function Element:New(Idx, Config)
	local Library = self.Library

	local Keybind = {
		Value = Config.Default or Config.Value or Enum.KeyCode.Unknown,
		Toggled = false,
		Mode = Config.Mode or "Toggle",
		Type = "Keybind",
		Callback = Config.Callback or function(Value) end,
		ChangedCallback = Config.ChangedCallback or function(New) end,
	}

	local Picking = false

	local KeybindFrame = require(Components.Element)(Config.Title or "Keybind", Config.Description, self.Container, true)

	Keybind.SetTitle = KeybindFrame.SetTitle
	Keybind.SetDesc = KeybindFrame.SetDesc

	local KeybindDisplayLabel = New("TextLabel", {
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
		Text = Library.Utilities:Prettify(Keybind.Value),
		TextColor3 = Color3.fromRGB(240, 240, 240),
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Center,
		Size = UDim2.new(0, 0, 0, 14),
		Position = UDim2.new(0, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		ThemeTag = {
			TextColor3 = "Text",
		},
	})

	local KeybindDisplayFrame = New("TextButton", {
		Size = UDim2.fromOffset(0, 30),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		AutoButtonColor = false,
		Font = Enum.Font.SourceSans,
		Text = "",
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 14,
		RichText = true,
		ThemeTag = {
			Color = "Accent",
		},
	})

	KeybindDisplayFrame.Parent = KeybindFrame.Frame

	local function UpdateDisplay()
		task.spawn(function()
			local Text = Library.Utilities:Prettify(Keybind.Value)

			KeybindDisplayLabel.Text = Text
			KeybindDisplayLabel.Size = UDim2.new(0, Text:len() * 7.5, 0, 14)

			KeybindDisplayFrame.Size = UDim2.new(0, KeybindDisplayLabel.Size.X.Offset + 20, 0, 30)
		end)
	end

	function Keybind:Update(NewValue)
		Keybind.Value = NewValue

		UpdateDisplay()

		if typeof(Keybind.ChangedCallback) == "function" then
			Library:SafeCallback(Keybind.ChangedCallback, NewValue)
		end
	end

	function Keybind:Toggle(State)
		if State ~= nil then
			Keybind.Toggled = State
		else
			Keybind.Toggled = not Keybind.Toggled
		end

		if Keybind.Toggled then
			KeybindFrame.Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		else
			KeybindFrame.Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		end
	end

	function Keybind:Pick()
		Picking = true

		KeybindFrame.Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

		UserInputService.InputBegan:Connect(function(Input, Processed)
			if Processed then return end

			if Input.UserInputType == Enum.UserInputType.Keyboard then
				local KeyCode = Input.KeyCode

				if KeyCode == Enum.KeyCode.Escape then
					Picking = false

					KeybindFrame.Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				else
					Keybind:Update(KeyCode)

					Picking = false

					KeybindFrame.Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				end
			end
		end)
	end

	KeybindFrame.Frame.MouseButton1Click:Connect(function()
		if Picking then
			Keybind:Pick()
		else
			Keybind:Toggle()
		end
	end)

	UpdateDisplay()

	return KeybindFrame
end

return Element
```

### Fluent Renewed/Elements/Paragraph.luau
```lua
local Root = script.Parent.Parent
local Components = Root.Components

local Element = {}
Element.__index = Element
Element.__type = "Paragraph"

function Element:New(Idx, Config)
	local Library = self.Library
	assert(Config.Title, "Paragraph - Missing Title")
	Config.Content = Config.Content or ""

	local Paragraph = {
		Value = Config.Content,
		Callback = Config.Callback or function(Value: string) end,
		Type = "Paragraph",
	}

	local ParagraphFrame = require(Components.Element)(Config.Title, Paragraph.Value, self.Container, false, {
		TitleAlignment = Config.TitleAlignment == "Middle" and "Center" or Config.TitleAlignment,
		DescriptionAlignment = Config.ContentAlignment == "Middle" and "Center" or Config.ContentAlignment
	})

	ParagraphFrame.Frame.BackgroundTransparency = 0.92
	ParagraphFrame.Border.Transparency = 0.6


	function Paragraph:OnChanged(Func)
		Paragraph.Changed = Func
		Library:SafeCallback(Func, Paragraph.Value, Paragraph.Value)
	end

	function Paragraph:SetContent(Value)
		Value = Value or ""
		rawset(Paragraph, "Value", Value)

		ParagraphFrame:SetDesc(Value)

		ParagraphFrame.Frame.BackgroundTransparency = 0.92
		ParagraphFrame.Border.Transparency = 0.6

		if typeof(Paragraph.Callback) == "function" then
			Library:SafeCallback(Paragraph.Callback, Paragraph.Value)
		end
		if typeof(Paragraph.Changed) == "function" then
			Library:SafeCallback(Paragraph.Changed, Paragraph.Value)
		end
	end

	function Paragraph:SetValue(Value)
		Paragraph:SetContent(Value)
	end

	return Paragraph
end

return Element
```

### Fluent Renewed/Modules/Creator.luau
```lua
local Root = script.Parent.Parent
local Themes = require(Root.Themes)
local Flipper, Ripple = require(Root.Packages.Flipper), require(Root.Packages.Ripple)
local Signal = require(Root.Packages.Signal)

local Creator = {
	Registry = {},
	Signals = {},
	TransparencyMotors = {},
	DefaultProperties = {
		ScreenGui = {
			ResetOnSpawn = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		},
		Frame = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
		ScrollingFrame = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ScrollBarImageColor3 = Color3.new(0, 0, 0),
		},
		TextLabel = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			BackgroundTransparency = 1,
			TextSize = 14,
			RichText = true,
		},
		TextButton = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			TextSize = 14,
			RichText = true,
		},
		TextBox = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ClearTextOnFocus = false,
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			TextSize = 14,
			RichText = true,
		},
	},
}

function Creator:Register(Name, Properties)
	self.Registry[Name] = Properties
end

function Creator:Get(Name)
	return self.Registry[Name]
end

function Creator:Create(Name, Parent, Properties)
	local Class = self:Get(Name)

	if not Class then
		warn("Creator: Attempted to create unknown class '" .. tostring(Name) .. "'")
		return
	end

	local Instance = Instance.new(Class.ClassName)

	for Property, Value in pairs(Class.Properties) do
		if Instance[Property] ~= nil then
			Instance[Property] = Value
		end
	end

	if Properties then
		for Property, Value in pairs(Properties) do
			if Instance[Property] ~= nil then
				Instance[Property] = Value
			end
		end
	end

	if Parent then
		Instance.Parent = Parent
	end

	return Instance
end

function Creator:MakeDraggable(Frame, TitleBar, DraggingEnabled)
	DraggingEnabled = DraggingEnabled ~= false

	local Dragging, DragStart, StartPos

	local function onInputBegan(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = true
			DragStart = Vector2.new(Input.Position.X, Input.Position.Y)
			StartPos = Vector2.new(Frame.Position.X.Offset, Frame.Position.Y.Offset)

			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end

	local function onInputChanged(Input)
		if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
			local Delta = Vector2.new(Input.Position.X, Input.Position.Y) - DragStart
			Frame.Position = UDim2.new(StartPos.X + Delta.X, StartPos.Y + Delta.Y)
		end
	end

	TitleBar.InputBegan:Connect(onInputBegan)
	TitleBar.InputChanged:Connect(onInputChanged)

	return {
		StopDragging = function()
			Dragging = false
		end,
	}
end

function Creator:ApplyTheme(Instance, Theme)
	local Properties = self:Get(Theme)

	if Properties then
		for Property, Value in pairs(Properties.Properties) do
			if Instance[Property] ~= nil then
				Instance[Property] = Value
			end
		end
	end
end

function Creator:AnimateIn(Frame, Time)
	Time = Time or 0.2

	Frame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quad", Time, true)
	Frame:TweenSize(UDim2.new(0, 300, 0, 200), "Out", "Quad", Time, true)
	Frame.BackgroundTransparency = 1

	Flipper.tween(Frame, {
		BackgroundTransparency = 0,
	}, Time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
end

function Creator:AnimateOut(Frame, Time)
	Time = Time or 0.2

	Frame:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), "Out", "Quad", Time, true)
	Frame:TweenSize(UDim2.new(0, 300, 0, 0), "Out", "Quad", Time, true)
	Frame.BackgroundTransparency = 0

	Flipper.tween(Frame, {
		BackgroundTransparency = 1,
	}, Time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
end

return Creator
```

### Fluent Renewed/Modules/Icons.luau (partial)
```lua
local icons_1 = 'rbxassetid://124334518624683'
local icons_2 = 'rbxassetid://113826256227095'
local icons_3 = 'rbxassetid://129900432084566'
local icons_4 = 'rbxassetid://118976126805967'
local icons_5 = 'rbxassetid://125298981894618'
local icons_6 = 'rbxassetid://131738208650267'
local icons_7 = 'rbxassetid://110728422432625'
local icons_8 = 'rbxassetid://135200213477510'
local icons_9 = 'rbxassetid://134392099945785'
local icons_10 = 'rbxassetid://79415505456349'
local icons_11 = 'rbxassetid://94499019266816'
local icons_12 = 'rbxassetid://72284904787415'
local icons_13 = 'rbxassetid://72284904787415'
local icons_14 = 'rbxassetid://102465529977025'
local icons_15 = 'rbxassetid://108796161822566'
local icons_16 = 'rbxassetid://104034552823126'
local icons_17 = 'rbxassetid://115396960406352'
local icons_18 = 'rbxassetid://88000092080903'
local icons_19 = 'rbxassetid://74902412828188'
local icons_20 = 'rbxassetid://95092644481468'
local icons_21 = 'rbxassetid://116618277156257'
local icons_22 = 'rbxassetid://101225869294852'
local icons_23 = 'rbxassetid://130974669650190'
local icons_24 = 'rbxassetid://122510634246659'
local icons_25 = 'rbxassetid://130565723724393'
local icons_26 = 'rbxassetid://130172565496219'
local icons_27 = 'rbxassetid://100537559853437'
local icons_28 = 'rbxassetid://77444842975129'
local icons_29 = 'rbxassetid://133795234078681'
local icons_30 = 'rbxassetid://88182585007332'
local icons_31 = 'rbxassetid://123183581552431'
local icons_32 = 'rbxassetid://108153633480449'
local icons_33 = 'rbxassetid://116280890977475'
local icons_34 = 'rbxassetid://97148406853110'
local icons_35 = 'rbxassetid://138968597001035'
local icons_36 = 'rbxassetid://129030569615452'
local icons_37 = 'rbxassetid://97278475063854'
local icons_38 = 'rbxassetid://138343757151795'
local icons_39 = 'rbxassetid://131684019420923'
local icons_40 = 'rbxassetid://139123669104105'
local icons_41 = 'rbxassetid://83798598825627'
local icons_42 = 'rbxassetid://93555120675964'

local VEC2 = {['0_0'] = Vector2.new(0, 0), ['64_0'] = Vector2.new(64, 0), ['128_0'] = Vector2.new(128, 0), ['192_0'] = Vector2.new(192, 0), ['256_0'] = Vector2.new(256, 0), ['320_0'] = Vector2.new(320, 0), ['384_0'] = Vector2.new(384, 0), ['448_0'] = Vector2.new(448, 0), ['512_0'] = Vector2.new(512, 0), ['576_0'] = Vector2.new(576, 0), ['640_0'] = Vector2.new(640, 0), ['704_0'] = Vector2.new(704, 0), ['768_0'] = Vector2.new(768, 0), ['832_0'] = Vector2.new(832, 0), ['896_0'] = Vector2.new(896, 0), ['960_0'] = Vector2.new(960, 0), ['0_64'] = Vector2.new(0, 64), ['64_64'] = Vector2.new(64, 64), ['128_64'] = Vector2.new(128, 64), ['192_64'] = Vector2.new(192, 64), ['256_64'] = Vector2.new(256, 64), ['320_64'] = Vector2.new(320, 64), ['384_64'] = Vector2.new(384, 64), ['448_64'] = Vector2.new(448, 64), ['512_64'] = Vector2.new(512, 64), ['576_64'] = Vector2.new(576, 64), ['640_64'] = Vector2.new(640, 64), ['704_64'] = Vector2.new(704, 64), ['768_64'] = Vector2.new(768, 64), ['832_64'] = Vector2.new(832, 64), ['896_64'] = Vector2.new(896, 64), ['960_64'] = Vector2.new(960, 64), ['0_128'] = Vector2.new(0, 128), ['64_128'] = Vector2.new(64, 128), ['128_128'] = Vector2.new(128, 128), ['192_128'] = Vector2.new(192, 128), ['256_128'] = Vector2.new(256, 128), ['320_128'] = Vector2.new(320, 128), ['384_128'] = Vector2.new(384, 128), ['448_128'] = Vector2.new(448, 128), ['512_128'] = Vector2.new(512, 128), ['576_128'] = Vector2.new(576, 128), ['640_128'] = Vector2.new(640, 128), ['704_128'] = Vector2.new(704, 128), ['768_128'] = Vector2.new(768, 128), ['832_128'] = Vector2.new(832, 128), ['896_128'] = Vector2.new(896, 128), ['960_128'] = Vector2.new(960, 128), ['0_192'] = Vector2.new(0, 192), ['64_192'] = Vector2.new(64, 192), ['128_192'] = Vector2.new(128, 192), ['192_192'] = Vector2.new(192, 192), ['256_192'] = Vector2.new(256, 192), ['320_192'] = Vector2.new(320, 192), ['384_192'] = Vector2.new(384, 192), ['448_192'] = Vector2.new(448, 192), ['512_192'] = Vector2.new(512, 192), ['576_192'] = Vector2.new(576, 192), ['640_192'] = Vector2.new(640, 192), ['704_192'] = Vector2.new(704, 192), ['768_192'] = Vector2.new(768, 192), ['832_192'] = Vector2.new(832, 192), ['896_192'] = Vector2.new(896, 192), ['960_192'] = Vector2.new(960, 192), ['0_256'] = Vector2.new(0, 256), ['64_256'] = Vector2.new(64, 256), ['128_256'] = Vector2.new(128, 256), ['192_256'] = Vector2.new(192, 256), ['256_256'] = Vector2.new(256, 256), ['320_256'] = Vector2.new(320, 256), ['384_256'] = Vector2.new(384, 256), ['448_256'] = Vector2.new(448, 256), ['512_256'] = Vector2.new(512, 256), ['576_256'] = Vector2.new(576, 256), ['640_256'] = Vector2.new(640, 256), ['704_256'] = Vector2.new(704, 256), ['768_256'] = Vector2.new(768, 256), ['832_256'] = Vector2.new(832, 256), ['896_256'] = Vector2.new(896, 256), ['960_256'] = Vector2.new(960, 256), ['0_320'] = Vector2.new(0, 320), ['64_320'] = Vector2.new(64, 320), ['128_320'] = Vector2.new(128, 320), ['192_320'] = Vector2.new(192, 320), ['256_320'] = Vector2.new(256, 320), ['320_320'] = Vector2.new(320, 320), ['384_320'] = Vector2.new(384, 320), ['448_320'] = Vector2.new(448, 320), ['512_320'] = Vector2.new(512, 320), ['576_320'] = Vector2.new(576, 320), ['640_320'] = Vector2.new(640, 320), ['704_320'] = Vector2.new(704, 320), ['768_320'] = Vector2.new(768, 320), ['832_320'] = Vector2.new(832, 320), ['896_320'] = Vector2.new(896, 320), ['960_320'] = Vector2.new(960, 320), ['0_384'] = Vector2.new(0, 384), ['64_384'] = Vector2.new(64, 384), ['128_384'] = Vector2.new(128, 384), ['192_384'] = Vector2.new(192, 384), ['256_384'] = Vector2.new(256, 384), ['320_384'] = Vector2.new(320, 384), ['384_384'] = Vector2.new(384, 384), ['448_384'] = Vector2.new(448, 384), ['512_384'] = Vector2.new(512, 384), ['576_384'] = Vector2.new(576, 384), ['640_384'] = Vector2.new(640, 384), ['704_384'] = Vector2.new(704, 384), ['768_384'] = Vector2.new(768, 384), ['832_384'] = Vector2.new(832, 384), ['896_384'] = Vector2.new(896, 384), ['960_384'] = Vector2.new(960, 384), ['0_448'] = Vector2.new(0, 448), ['64_448'] = Vector2.new(64, 448), ['128_448'] = Vector2.new(128, 448), ['192_448'] = Vector2.new(192, 448), ['256_448'] = Vector2.new(256, 448), ['320_448'] = Vector2.new(320, 448), ['384_448'] = Vector2.new(384, 448), ['448_448'] = Vector2.new(448, 448), ['512_448'] = Vector2.new(512, 448), ['576_448'] = Vector2.new(576, 448), ['640_448'] = Vector2.new(640, 448), ['704_448'] = Vector2.new(704, 448), ['768_448'] = Vector2.new(768, 448), ['832_448'] = Vector2.new(832, 448), ['896_448'] = Vector2.new(896, 448), ['960_448'] = Vector2.new(960, 448), ['0_512'] = Vector2.new(0, 512), ['64_512'] = Vector2.new(64, 512), ['128_512'] = Vector2.new(128, 512), ['192_512'] = Vector2.new(192, 512), ['256_512'] = Vector2.new(256, 512), ['320_512'] = Vector2.new(320, 512), ['384_512'] = Vector2.new(384, 512), ['448_512'] = Vector2.new(448, 512), ['512_512'] = Vector2.new(512, 512), ['576_512'] = Vector2.new(576, 512), ['640_512'] = Vector2.new(640, 512), ['704_512'] = Vector2.new(704, 512), ['768_512'] = Vector2.new(768, 512), ['832_512'] = Vector2.new(832, 512), ['896_512'] = Vector2.new(896, 512), ['960_512'] = Vector2.new(960, 512), ['0_576'] = Vector2.new(0, 576), ['64_576'] = Vector2.new(64, 576), ['128_576'] = Vector2.new(128, 576), ['192_576'] = Vector2.new(192, 576), ['256_576'] = Vector2.new(256, 576), ['320_576'] = Vector2.new(320, 576), ['384_576'] = Vector2.new(384, 576), ['448_576'] = Vector2.new(448, 576), ['512_576'] = Vector2.new(512, 576), ['576_576'] = Vector2.new(576, 576), ['640_576'] = Vector2.new(640, 576), ['704_576'] = Vector2.new(704, 576), ['768_576'] = Vector2.new(768, 576), ['832_576'] = Vector2.new(832, 576), ['896_576'] = Vector2.new(896, 576), ['960_576'] = Vector2.new(960, 576), ['0_640'] = Vector2.new(0, 640), ['64_640'] = Vector2.new(64, 640), ['128_640'] = Vector2.new(128, 640), ['192_640'] = Vector2.new(192, 640), ['256_640'] = Vector2.new(256, 640), ['320_640'] = Vector2.new(320, 640), ['384_640'] = Vector2.new(384, 640), ['448_640'] = Vector2.new(448, 640), ['512_640'] = Vector2.new(512, 640), ['576_640'] = Vector2.new(576, 640), ['640_640'] = Vector2.new(640, 640), ['704_640'] = Vector2.new(704, 640), ['768_640'] = Vector2.new(768, 640), ['832_640'] = Vector2.new(832, 640), ['896_640'] = Vector2.new(896, 640), ['960_640'] = Vector2.new(960, 640), ['0_704'] = Vector2.new(0, 704), ['64_704'] = Vector2.new(64, 704), ['128_704'] = Vector2.new(128, 704), ['192_704'] = Vector2.new(192, 704), ['256_704'] = Vector2.new(256, 704), ['320_704'] = Vector2.new(320, 704), ['384_704'] = Vector2.new(384, 704), ['448_704'] = Vector2.new(448, 704), ['512_704'] = Vector2.new(512, 704), ['576_704'] = Vector2.new(576, 704), ['640_704'] = Vector2.new(640, 704), ['704_704'] = Vector2.new(704, 704), ['768_704'] = Vector2.new(768, 704), ['832_704'] = Vector2.new(832, 704), ['896_704'] = Vector2.new(896, 704), ['960_704'] = Vector2.new(960, 704), ['0_768'] = Vector2.new(0, 768), ['64_768'] = Vector2.new(64, 768), ['128_768'] = Vector2.new(128, 768), ['192_768'] = Vector2.new(192, 768), ['256_768'] = Vector2.new(256, 768), ['320_768'] = Vector2.new(320, 768), ['384_768'] = Vector2.new(384, 768), ['448_768'] = Vector2.new(448, 768), ['512_768'] = Vector2.new(512, 768), ['576_768'] = Vector2.new(576, 768), ['640_768'] = Vector2.new(640, 768), ['704_768'] = Vector2.new(704, 768), ['768_768'] = Vector2.new(768, 768), ['832_768'] = Vector2.new(832, 768), ['896_768'] = Vector2.new(896, 768), ['960_768'] = Vector2.new(960, 768), ['0_832'] = Vector2.new(0, 832), ['64_832'] = Vector2.new(64, 832), ['128_832'] = Vector2.new(128, 832), ['192_832'] = Vector2.new(192, 832), ['256_832'] = Vector2.new(256, 832), ['320_832'] = Vector2.new(320, 832), ['384_832'] = Vector2.new(384, 832), ['448_832'] = Vector2.new(448, 832), ['512_832'] = Vector2.new(512, 832), ['576_832'] = Vector2.new(576, 832), ['640_832'] = Vector2.new(640, 832), ['704_832'] = Vector2.new(704, 832), ['768_832'] = Vector2.new(768, 832), ['832_832'] = Vector2.new(832, 832), ['896_832'] = Vector2.new(896, 832), ['960_832'] = Vector2.new(960, 832), ['0_896'] = Vector2.new(0, 896), ['64_896'] = Vector2.new(64, 896), ['128_896'] = Vector2.new(128, 896), ['192_896'] = Vector2.new(192, 896), ['256_896'] = Vector2.new(256, 896), ['320_896'] = Vector2.new(320, 896), ['384_896'] = Vector2.new(384, 896), ['448_896'] = Vector2.new(448, 896), ['512_896'] = Vector2.new(512, 896), ['576_896'] = Vector2.new(576, 896), ['640_896'] = Vector2.new(640, 896), ['704_896'] = Vector2.new(704, 896), ['768_896'] = Vector2.new(768, 896), ['832_896'] = Vector2.new(832, 896), ['896_896'] = Vector2.new(896, 896), ['960_896'] = Vector2.new(960, 896), ['0_960'] = Vector2.new(0, 960), ['64_960'] = Vector2.new(64, 960), ['128_960'] = Vector2.new(128, 960), ['192_960'] = Vector2.new(192, 960), ['256_960'] = Vector2.new(256, 960), ['320_960'] = Vector2.new(320, 960), ['384_960'] = Vector2.new(384, 960), ['448_960'] = Vector2.new(448, 960), ['512_960'] = Vector2.new(512, 960), ['576_960'] = Vector2.new(576, 960), ['640_960'] = Vector2.new(640, 960), ['704_960'] = Vector2.new(704, 960), ['768_960'] = Vector2.new(768, 960), ['832_960'] = Vector2.new(832, 960), ['896_960'] = Vector2.new(896, 960), ['960_960'] = Vector2.new(960, 960)}

game:GetService'ContentProvider':PreloadAsync{icons_1, icons_2, icons_3, icons_4, icons_5, icons_6, icons_7, icons_8, icons_9, icons_10, icons_11, icons_12, icons_13, icons_14, icons_15, icons_16, icons_17, icons_18, icons_19, icons_20, icons_21, icons_22, icons_23, icons_24, icons_25, icons_26, icons_27, icons_28, icons_29, icons_30, icons_31, icons_32, icons_33, icons_34, icons_35, icons_36, icons_37, icons_38, icons_39, icons_40, icons_41, icons_42, "rbxassetid://9886659671", "rbxassetid://9886659276", "rbxassetid://9886659406", "rbxassetid://9886659001"}

return {
	SetIcon = function(self, Image: ImageLabel & ImageButton, IconName: string)
		local IconData = self[IconName]
		if not IconData then
			return
		end

		Image.Image = IconData[1]
		Image.ImageRectOffset = IconData[2]
		Image.ImageRectSize = IconData[3]
		Image.Size = UDim2.fromOffset(IconData[4], IconData[5])
		Image.Visible = true
	end,

	HideIcon = function(self, Image: ImageLabel & ImageButton)
		Image.Visible = false
	end,

	["chevron-right"] = {icons_1, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["chevron-left"] = {icons_1, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["chevron-up"] = {icons_1, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["chevron-down"] = {icons_1, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["plus"] = {icons_1, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["minus"] = {icons_1, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["close"] = {icons_1, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["check"] = {icons_1, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["settings"] = {icons_1, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["home"] = {icons_1, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["user"] = {icons_1, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["lock"] = {icons_1, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["star"] = {icons_1, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["bell"] = {icons_1, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["camera"] = {icons_1, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["music"] = {icons_2, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["film"] = {icons_2, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["game"] = {icons_2, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["paint"] = {icons_2, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["book"] = {icons_2, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["briefcase"] = {icons_2, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["envelope"] = {icons_2, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["phone"] = {icons_2, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["tablet"] = {icons_2, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["laptop"] = {icons_2, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["desktop"] = {icons_2, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["globe"] = {icons_2, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["map"] = {icons_2, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["tag"] = {icons_2, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["gift"] = {icons_2, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["trophy"] = {icons_3, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["medal"] = {icons_3, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["crown"] = {icons_3, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["shield"] = {icons_3, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["star-filled"] = {icons_3, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["star-half"] = {icons_3, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["heart"] = {icons_3, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["diamond"] = {icons_3, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["club"] = {icons_3, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["spade"] = {icons_3, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["anchor"] = {icons_3, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["leaf"] = {icons_3, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["paw"] = {icons_3, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["bone"] = {icons_3, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["fish"] = {icons_3, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["sword"] = {icons_4, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["shield-cross"] = {icons_4, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["axe"] = {icons_4, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["hammer"] = {icons_4, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["wrench"] = {icons_4, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["nut-and-bolt"] = {icons_4, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["scissors"] = {icons_4, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["saw"] = {icons_4, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["lightbulb"] = {icons_4, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["battery"] = {icons_4, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["plug"] = {icons_4, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["lamp"] = {icons_4, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["candle"] = {icons_4, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["fire"] = {icons_4, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["water"] = {icons_4, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["leaf2"] = {icons_5, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw2"] = {icons_5, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone2"] = {icons_5, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish2"] = {icons_5, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword2"] = {icons_5, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross2"] = {icons_5, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe2"] = {icons_5, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer2"] = {icons_5, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench2"] = {icons_5, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt2"] = {icons_5, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors2"] = {icons_5, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw2"] = {icons_5, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb2"] = {icons_5, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery2"] = {icons_5, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug2"] = {icons_5, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp2"] = {icons_5, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle2"] = {icons_5, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire2"] = {icons_5, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water2"] = {icons_5, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf3"] = {icons_6, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw3"] = {icons_6, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone3"] = {icons_6, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish3"] = {icons_6, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword3"] = {icons_6, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross3"] = {icons_6, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe3"] = {icons_6, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer3"] = {icons_6, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench3"] = {icons_6, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt3"] = {icons_6, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors3"] = {icons_6, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw3"] = {icons_6, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb3"] = {icons_6, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery3"] = {icons_6, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug3"] = {icons_6, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp3"] = {icons_6, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle3"] = {icons_6, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire3"] = {icons_6, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water3"] = {icons_6, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf4"] = {icons_7, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw4"] = {icons_7, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone4"] = {icons_7, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish4"] = {icons_7, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword4"] = {icons_7, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross4"] = {icons_7, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe4"] = {icons_7, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer4"] = {icons_7, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench4"] = {icons_7, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt4"] = {icons_7, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors4"] = {icons_7, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw4"] = {icons_7, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb4"] = {icons_7, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery4"] = {icons_7, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug4"] = {icons_7, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp4"] = {icons_7, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle4"] = {icons_7, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire4"] = {icons_7, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water4"] = {icons_7, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf5"] = {icons_8, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw5"] = {icons_8, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone5"] = {icons_8, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish5"] = {icons_8, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword5"] = {icons_8, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross5"] = {icons_8, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe5"] = {icons_8, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer5"] = {icons_8, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench5"] = {icons_8, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt5"] = {icons_8, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors5"] = {icons_8, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw5"] = {icons_8, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb5"] = {icons_8, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery5"] = {icons_8, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug5"] = {icons_8, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp5"] = {icons_8, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle5"] = {icons_8, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire5"] = {icons_8, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water5"] = {icons_8, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf6"] = {icons_9, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw6"] = {icons_9, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone6"] = {icons_9, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish6"] = {icons_9, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword6"] = {icons_9, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross6"] = {icons_9, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe6"] = {icons_9, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer6"] = {icons_9, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench6"] = {icons_9, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt6"] = {icons_9, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors6"] = {icons_9, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw6"] = {icons_9, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb6"] = {icons_9, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery6"] = {icons_9, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug6"] = {icons_9, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp6"] = {icons_9, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle6"] = {icons_9, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire6"] = {icons_9, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water6"] = {icons_9, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf7"] = {icons_10, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw7"] = {icons_10, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone7"] = {icons_10, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish7"] = {icons_10, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword7"] = {icons_10, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross7"] = {icons_10, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe7"] = {icons_10, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer7"] = {icons_10, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench7"] = {icons_10, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt7"] = {icons_10, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors7"] = {icons_10, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw7"] = {icons_10, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb7"] = {icons_10, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery7"] = {icons_10, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug7"] = {icons_10, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp7"] = {icons_10, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle7"] = {icons_10, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire7"] = {icons_10, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water7"] = {icons_10, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf8"] = {icons_11, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw8"] = {icons_11, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone8"] = {icons_11, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish8"] = {icons_11, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword8"] = {icons_11, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross8"] = {icons_11, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe8"] = {icons_11, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer8"] = {icons_11, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench8"] = {icons_11, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt8"] = {icons_11, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors8"] = {icons_11, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw8"] = {icons_11, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb8"] = {icons_11, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery8"] = {icons_11, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug8"] = {icons_11, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp8"] = {icons_11, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle8"] = {icons_11, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire8"] = {icons_11, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water8"] = {icons_11, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf9"] = {icons_12, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw9"] = {icons_12, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone9"] = {icons_12, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish9"] = {icons_12, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword9"] = {icons_12, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross9"] = {icons_12, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe9"] = {icons_12, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer9"] = {icons_12, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench9"] = {icons_12, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt9"] = {icons_12, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors9"] = {icons_12, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw9"] = {icons_12, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb9"] = {icons_12, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery9"] = {icons_12, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug9"] = {icons_12, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp9"] = {icons_12, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle9"] = {icons_12, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire9"] = {icons_12, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water9"] = {icons_12, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf10"] = {icons_13, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw10"] = {icons_13, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone10"] = {icons_13, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish10"] = {icons_13, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword10"] = {icons_13, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross10"] = {icons_13, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe10"] = {icons_13, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer10"] = {icons_13, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench10"] = {icons_13, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt10"] = {icons_13, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors10"] = {icons_13, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw10"] = {icons_13, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb10"] = {icons_13, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery10"] = {icons_13, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug10"] = {icons_13, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp10"] = {icons_13, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle10"] = {icons_13, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire10"] = {icons_13, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water10"] = {icons_13, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf11"] = {icons_14, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw11"] = {icons_14, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone11"] = {icons_14, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish11"] = {icons_14, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword11"] = {icons_14, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross11"] = {icons_14, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe11"] = {icons_14, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer11"] = {icons_14, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench11"] = {icons_14, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt11"] = {icons_14, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors11"] = {icons_14, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw11"] = {icons_14, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb11"] = {icons_14, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery11"] = {icons_14, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug11"] = {icons_14, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp11"] = {icons_14, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle11"] = {icons_14, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire11"] = {icons_14, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water11"] = {icons_14, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf12"] = {icons_15, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw12"] = {icons_15, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone12"] = {icons_15, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish12"] = {icons_15, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword12"] = {icons_15, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross12"] = {icons_15, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe12"] = {icons_15, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer12"] = {icons_15, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench12"] = {icons_15, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt12"] = {icons_15, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors12"] = {icons_15, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw12"] = {icons_15, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb12"] = {icons_15, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery12"] = {icons_15, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug12"] = {icons_15, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp12"] = {icons_15, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle12"] = {icons_15, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire12"] = {icons_15, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water12"] = {icons_15, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf13"] = {icons_16, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw13"] = {icons_16, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone13"] = {icons_16, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish13"] = {icons_16, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword13"] = {icons_16, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross13"] = {icons_16, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe13"] = {icons_16, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer13"] = {icons_16, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench13"] = {icons_16, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt13"] = {icons_16, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors13"] = {icons_16, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw13"] = {icons_16, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb13"] = {icons_16, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery13"] = {icons_16, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug13"] = {icons_16, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp13"] = {icons_16, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle13"] = {icons_16, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire13"] = {icons_16, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water13"] = {icons_16, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf14"] = {icons_17, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw14"] = {icons_17, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone14"] = {icons_17, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish14"] = {icons_17, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword14"] = {icons_17, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross14"] = {icons_17, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe14"] = {icons_17, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer14"] = {icons_17, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench14"] = {icons_17, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt14"] = {icons_17, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors14"] = {icons_17, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw14"] = {icons_17, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb14"] = {icons_17, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery14"] = {icons_17, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug14"] = {icons_17, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp14"] = {icons_17, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle14"] = {icons_17, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire14"] = {icons_17, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water14"] = {icons_17, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf15"] = {icons_18, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw15"] = {icons_18, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone15"] = {icons_18, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish15"] = {icons_18, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword15"] = {icons_18, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross15"] = {icons_18, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe15"] = {icons_18, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer15"] = {icons_18, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench15"] = {icons_18, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt15"] = {icons_18, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors15"] = {icons_18, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw15"] = {icons_18, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb15"] = {icons_18, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery15"] = {icons_18, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug15"] = {icons_18, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp15"] = {icons_18, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle15"] = {icons_18, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire15"] = {icons_18, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water15"] = {icons_18, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf16"] = {icons_19, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw16"] = {icons_19, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone16"] = {icons_19, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish16"] = {icons_19, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword16"] = {icons_19, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross16"] = {icons_19, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe16"] = {icons_19, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer16"] = {icons_19, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench16"] = {icons_19, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt16"] = {icons_19, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors16"] = {icons_19, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw16"] = {icons_19, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb16"] = {icons_19, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery16"] = {icons_19, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug16"] = {icons_19, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp16"] = {icons_19, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle16"] = {icons_19, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire16"] = {icons_19, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water16"] = {icons_19, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf17"] = {icons_20, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw17"] = {icons_20, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone17"] = {icons_20, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish17"] = {icons_20, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword17"] = {icons_20, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross17"] = {icons_20, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe17"] = {icons_20, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer17"] = {icons_20, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench17"] = {icons_20, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt17"] = {icons_20, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors17"] = {icons_20, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw17"] = {icons_20, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb17"] = {icons_20, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery17"] = {icons_20, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug17"] = {icons_20, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp17"] = {icons_20, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle17"] = {icons_20, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire17"] = {icons_20, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water17"] = {icons_20, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf18"] = {icons_21, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw18"] = {icons_21, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone18"] = {icons_21, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish18"] = {icons_21, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword18"] = {icons_21, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross18"] = {icons_21, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe18"] = {icons_21, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer18"] = {icons_21, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench18"] = {icons_21, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt18"] = {icons_21, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors18"] = {icons_21, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw18"] = {icons_21, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb18"] = {icons_21, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery18"] = {icons_21, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug18"] = {icons_21, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp18"] = {icons_21, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle18"] = {icons_21, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire18"] = {icons_21, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water18"] = {icons_21, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf19"] = {icons_22, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw19"] = {icons_22, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone19"] = {icons_22, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish19"] = {icons_22, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword19"] = {icons_22, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross19"] = {icons_22, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe19"] = {icons_22, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer19"] = {icons_22, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench19"] = {icons_22, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt19"] = {icons_22, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors19"] = {icons_22, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw19"] = {icons_22, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb19"] = {icons_22, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery19"] = {icons_22, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug19"] = {icons_22, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp19"] = {icons_22, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle19"] = {icons_22, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire19"] = {icons_22, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water19"] = {icons_22, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf20"] = {icons_23, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw20"] = {icons_23, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone20"] = {icons_23, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish20"] = {icons_23, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword20"] = {icons_23, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross20"] = {icons_23, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe20"] = {icons_23, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer20"] = {icons_23, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench20"] = {icons_23, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt20"] = {icons_23, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors20"] = {icons_23, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw20"] = {icons_23, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb20"] = {icons_23, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery20"] = {icons_23, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug20"] = {icons_23, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp20"] = {icons_23, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle20"] = {icons_23, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire20"] = {icons_23, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water20"] = {icons_23, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf21"] = {icons_24, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw21"] = {icons_24, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone21"] = {icons_24, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish21"] = {icons_24, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword21"] = {icons_24, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross21"] = {icons_24, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe21"] = {icons_24, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer21"] = {icons_24, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench21"] = {icons_24, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt21"] = {icons_24, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors21"] = {icons_24, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw21"] = {icons_24, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb21"] = {icons_24, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery21"] = {icons_24, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug21"] = {icons_24, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp21"] = {icons_24, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle21"] = {icons_24, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire21"] = {icons_24, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water21"] = {icons_24, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf22"] = {icons_25, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw22"] = {icons_25, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone22"] = {icons_25, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish22"] = {icons_25, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword22"] = {icons_25, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross22"] = {icons_25, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe22"] = {icons_25, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer22"] = {icons_25, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench22"] = {icons_25, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt22"] = {icons_25, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors22"] = {icons_25, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw22"] = {icons_25, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb22"] = {icons_25, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery22"] = {icons_25, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug22"] = {icons_25, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp22"] = {icons_25, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle22"] = {icons_25, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire22"] = {icons_25, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water22"] = {icons_25, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf23"] = {icons_26, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw23"] = {icons_26, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone23"] = {icons_26, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish23"] = {icons_26, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword23"] = {icons_26, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross23"] = {icons_26, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe23"] = {icons_26, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer23"] = {icons_26, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench23"] = {icons_26, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt23"] = {icons_26, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors23"] = {icons_26, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw23"] = {icons_26, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb23"] = {icons_26, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery23"] = {icons_26, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug23"] = {icons_26, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp23"] = {icons_26, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle23"] = {icons_26, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire23"] = {icons_26, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water23"] = {icons_26, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf24"] = {icons_27, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw24"] = {icons_27, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone24"] = {icons_27, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish24"] = {icons_27, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword24"] = {icons_27, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross24"] = {icons_27, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe24"] = {icons_27, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer24"] = {icons_27, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench24"] = {icons_27, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt24"] = {icons_27, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors24"] = {icons_27, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw24"] = {icons_27, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb24"] = {icons_27, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery24"] = {icons_27, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug24"] = {icons_27, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp24"] = {icons_27, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle24"] = {icons_27, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire24"] = {icons_27, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water24"] = {icons_27, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf25"] = {icons_28, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw25"] = {icons_28, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone25"] = {icons_28, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish25"] = {icons_28, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword25"] = {icons_28, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross25"] = {icons_28, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe25"] = {icons_28, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer25"] = {icons_28, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench25"] = {icons_28, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt25"] = {icons_28, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors25"] = {icons_28, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw25"] = {icons_28, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb25"] = {icons_28, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery25"] = {icons_28, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug25"] = {icons_28, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp25"] = {icons_28, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle25"] = {icons_28, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire25"] = {icons_28, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water25"] = {icons_28, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf26"] = {icons_29, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw26"] = {icons_29, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone26"] = {icons_29, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish26"] = {icons_29, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword26"] = {icons_29, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross26"] = {icons_29, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe26"] = {icons_29, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer26"] = {icons_29, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench26"] = {icons_29, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt26"] = {icons_29, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors26"] = {icons_29, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw26"] = {icons_29, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb26"] = {icons_29, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery26"] = {icons_29, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug26"] = {icons_29, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp26"] = {icons_29, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle26"] = {icons_29, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire26"] = {icons_29, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water26"] = {icons_29, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf27"] = {icons_30, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw27"] = {icons_30, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone27"] = {icons_30, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish27"] = {icons_30, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword27"] = {icons_30, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross27"] = {icons_30, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe27"] = {icons_30, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer27"] = {icons_30, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench27"] = {icons_30, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt27"] = {icons_30, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors27"] = {icons_30, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw27"] = {icons_30, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb27"] = {icons_30, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery27"] = {icons_30, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug27"] = {icons_30, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp27"] = {icons_30, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle27"] = {icons_30, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire27"] = {icons_30, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water27"] = {icons_30, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf28"] = {icons_31, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw28"] = {icons_31, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone28"] = {icons_31, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish28"] = {icons_31, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword28"] = {icons_31, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross28"] = {icons_31, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe28"] = {icons_31, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer28"] = {icons_31, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench28"] = {icons_31, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt28"] = {icons_31, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors28"] = {icons_31, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw28"] = {icons_31, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb28"] = {icons_31, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery28"] = {icons_31, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug28"] = {icons_31, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp28"] = {icons_31, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle28"] = {icons_31, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire28"] = {icons_31, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water28"] = {icons_31, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf29"] = {icons_32, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw29"] = {icons_32, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone29"] = {icons_32, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish29"] = {icons_32, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword29"] = {icons_32, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross29"] = {icons_32, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe29"] = {icons_32, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer29"] = {icons_32, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench29"] = {icons_32, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt29"] = {icons_32, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors29"] = {icons_32, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw29"] = {icons_32, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb29"] = {icons_32, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery29"] = {icons_32, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug29"] = {icons_32, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp29"] = {icons_32, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle29"] = {icons_32, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire29"] = {icons_32, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water29"] = {icons_32, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf30"] = {icons_33, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw30"] = {icons_33, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone30"] = {icons_33, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish30"] = {icons_33, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword30"] = {icons_33, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross30"] = {icons_33, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe30"] = {icons_33, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer30"] = {icons_33, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench30"] = {icons_33, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt30"] = {icons_33, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors30"] = {icons_33, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw30"] = {icons_33, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb30"] = {icons_33, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery30"] = {icons_33, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug30"] = {icons_33, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp30"] = {icons_33, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle30"] = {icons_33, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire30"] = {icons_33, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water30"] = {icons_33, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf31"] = {icons_34, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw31"] = {icons_34, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone31"] = {icons_34, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish31"] = {icons_34, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword31"] = {icons_34, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross31"] = {icons_34, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe31"] = {icons_34, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer31"] = {icons_34, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench31"] = {icons_34, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt31"] = {icons_34, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors31"] = {icons_34, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw31"] = {icons_34, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb31"] = {icons_34, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery31"] = {icons_34, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug31"] = {icons_34, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp31"] = {icons_34, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle31"] = {icons_34, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire31"] = {icons_34, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water31"] = {icons_34, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf32"] = {icons_35, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw32"] = {icons_35, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone32"] = {icons_35, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish32"] = {icons_35, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword32"] = {icons_35, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross32"] = {icons_35, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe32"] = {icons_35, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer32"] = {icons_35, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench32"] = {icons_35, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt32"] = {icons_35, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors32"] = {icons_35, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw32"] = {icons_35, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb32"] = {icons_35, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery32"] = {icons_35, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug32"] = {icons_35, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp32"] = {icons_35, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle32"] = {icons_35, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire32"] = {icons_35, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water32"] = {icons_35, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf33"] = {icons_36, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw33"] = {icons_36, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone33"] = {icons_36, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish33"] = {icons_36, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword33"] = {icons_36, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross33"] = {icons_36, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe33"] = {icons_36, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer33"] = {icons_36, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench33"] = {icons_36, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt33"] = {icons_36, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors33"] = {icons_36, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw33"] = {icons_36, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb33"] = {icons_36, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery33"] = {icons_36, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug33"] = {icons_36, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp33"] = {icons_36, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle33"] = {icons_36, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire33"] = {icons_36, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water33"] = {icons_36, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf34"] = {icons_37, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw34"] = {icons_37, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone34"] = {icons_37, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish34"] = {icons_37, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword34"] = {icons_37, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross34"] = {icons_37, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe34"] = {icons_37, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer34"] = {icons_37, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench34"] = {icons_37, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt34"] = {icons_37, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors34"] = {icons_37, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw34"] = {icons_37, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb34"] = {icons_37, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery34"] = {icons_37, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug34"] = {icons_37, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp34"] = {icons_37, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle34"] = {icons_37, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire34"] = {icons_37, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water34"] = {icons_37, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf35"] = {icons_38, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw35"] = {icons_38, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone35"] = {icons_38, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish35"] = {icons_38, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword35"] = {icons_38, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross35"] = {icons_38, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe35"] = {icons_38, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer35"] = {icons_38, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench35"] = {icons_38, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt35"] = {icons_38, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors35"] = {icons_38, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw35"] = {icons_38, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb35"] = {icons_38, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery35"] = {icons_38, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug35"] = {icons_38, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp35"] = {icons_38, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle35"] = {icons_38, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire35"] = {icons_38, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water35"] = {icons_38, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf36"] = {icons_39, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw36"] = {icons_39, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone36"] = {icons_39, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish36"] = {icons_39, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword36"] = {icons_39, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross36"] = {icons_39, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe36"] = {icons_39, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer36"] = {icons_39, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench36"] = {icons_39, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt36"] = {icons_39, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors36"] = {icons_39, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw36"] = {icons_39, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb36"] = {icons_39, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery36"] = {icons_39, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug36"] = {icons_39, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp36"] = {icons_39, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle36"] = {icons_39, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire36"] = {icons_39, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water36"] = {icons_39, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf37"] = {icons_40, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw37"] = {icons_40, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone37"] = {icons_40, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish37"] = {icons_40, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword37"] = {icons_40, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross37"] = {icons_40, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe37"] = {icons_40, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer37"] = {icons_40, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench37"] = {icons_40, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt37"] = {icons_40, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors37"] = {icons_40, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw37"] = {icons_40, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb37"] = {icons_40, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery37"] = {icons_40, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug37"] = {icons_40, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp37"] = {icons_40, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle37"] = {icons_40, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire37"] = {icons_40, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water37"] = {icons_40, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf38"] = {icons_41, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw38"] = {icons_41, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone38"] = {icons_41, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish38"] = {icons_41, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword38"] = {icons_41, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross38"] = {icons_41, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe38"] = {icons_41, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer38"] = {icons_41, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench38"] = {icons_41, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt38"] = {icons_41, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors38"] = {icons_41, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw38"] = {icons_41, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb38"] = {icons_41, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery38"] = {icons_41, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug38"] = {icons_41, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp38"] = {icons_41, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle38"] = {icons_41, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire38"] = {icons_41, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water38"] = {icons_41, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf39"] = {icons_42, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw39"] = {icons_42, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone39"] = {icons_42, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish39"] = {icons_42, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword39"] = {icons_42, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross39"] = {icons_42, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe39"] = {icons_42, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer39"] = {icons_42, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench39"] = {icons_42, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt39"] = {icons_42, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors39"] = {icons_42, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw39"] = {icons_42, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb39"] = {icons_42, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery39"] = {icons_42, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug39"] = {icons_42, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp39"] = {icons_42, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle39"] = {icons_42, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire39"] = {icons_42, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water39"] = {icons_42, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf40"] = {icons_1, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw40"] = {icons_1, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone40"] = {icons_1, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish40"] = {icons_1, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword40"] = {icons_1, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross40"] = {icons_1, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe40"] = {icons_1, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer40"] = {icons_1, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench40"] = {icons_1, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt40"] = {icons_1, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors40"] = {icons_1, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw40"] = {icons_1, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb40"] = {icons_1, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery40"] = {icons_1, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug40"] = {icons_1, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp40"] = {icons_1, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle40"] = {icons_1, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire40"] = {icons_1, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water40"] = {icons_1, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf41"] = {icons_2, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw41"] = {icons_2, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone41"] = {icons_2, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish41"] = {icons_2, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword41"] = {icons_2, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross41"] = {icons_2, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe41"] = {icons_2, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer41"] = {icons_2, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench41"] = {icons_2, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt41"] = {icons_2, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors41"] = {icons_2, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw41"] = {icons_2, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb41"] = {icons_2, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery41"] = {icons_2, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug41"] = {icons_2, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp41"] = {icons_2, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle41"] = {icons_2, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire41"] = {icons_2, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water41"] = {icons_2, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf42"] = {icons_3, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw42"] = {icons_3, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone42"] = {icons_3, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish42"] = {icons_3, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword42"] = {icons_3, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross42"] = {icons_3, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe42"] = {icons_3, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer42"] = {icons_3, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench42"] = {icons_3, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt42"] = {icons_3, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors42"] = {icons_3, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw42"] = {icons_3, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb42"] = {icons_3, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery42"] = {icons_3, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug42"] = {icons_3, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp42"] = {icons_3, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle42"] = {icons_3, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire42"] = {icons_3, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water42"] = {icons_3, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf43"] = {icons_4, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw43"] = {icons_4, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone43"] = {icons_4, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish43"] = {icons_4, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword43"] = {icons_4, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross43"] = {icons_4, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe43"] = {icons_4, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer43"] = {icons_4, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench43"] = {icons_4, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt43"] = {icons_4, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors43"] = {icons_4, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw43"] = {icons_4, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb43"] = {icons_4, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery43"] = {icons_4, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug43"] = {icons_4, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp43"] = {icons_4, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle43"] = {icons_4, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire43"] = {icons_4, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water43"] = {icons_4, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf44"] = {icons_5, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw44"] = {icons_5, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone44"] = {icons_5, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish44"] = {icons_5, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword44"] = {icons_5, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross44"] = {icons_5, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe44"] = {icons_5, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer44"] = {icons_5, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench44"] = {icons_5, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt44"] = {icons_5, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors44"] = {icons_5, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw44"] = {icons_5, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb44"] = {icons_5, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery44"] = {icons_5, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug44"] = {icons_5, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp44"] = {icons_5, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle44"] = {icons_5, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire44"] = {icons_5, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water44"] = {icons_5, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf45"] = {icons_6, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw45"] = {icons_6, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone45"] = {icons_6, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish45"] = {icons_6, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword45"] = {icons_6, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross45"] = {icons_6, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe45"] = {icons_6, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer45"] = {icons_6, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench45"] = {icons_6, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt45"] = {icons_6, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors45"] = {icons_6, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw45"] = {icons_6, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb45"] = {icons_6, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery45"] = {icons_6, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug45"] = {icons_6, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp45"] = {icons_6, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle45"] = {icons_6, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire45"] = {icons_6, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water45"] = {icons_6, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf46"] = {icons_7, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw46"] = {icons_7, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone46"] = {icons_7, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish46"] = {icons_7, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword46"] = {icons_7, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross46"] = {icons_7, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe46"] = {icons_7, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer46"] = {icons_7, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench46"] = {icons_7, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt46"] = {icons_7, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors46"] = {icons_7, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw46"] = {icons_7, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb46"] = {icons_7, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery46"] = {icons_7, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug46"] = {icons_7, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp46"] = {icons_7, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle46"] = {icons_7, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire46"] = {icons_7, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water46"] = {icons_7, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf47"] = {icons_8, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw47"] = {icons_8, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone47"] = {icons_8, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish47"] = {icons_8, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword47"] = {icons_8, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross47"] = {icons_8, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe47"] = {icons_8, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer47"] = {icons_8, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench47"] = {icons_8, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt47"] = {icons_8, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors47"] = {icons_8, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw47"] = {icons_8, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb47"] = {icons_8, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery47"] = {icons_8, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug47"] = {icons_8, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp47"] = {icons_8, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle47"] = {icons_8, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire47"] = {icons_8, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water47"] = {icons_8, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf48"] = {icons_9, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw48"] = {icons_9, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone48"] = {icons_9, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish48"] = {icons_9, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword48"] = {icons_9, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross48"] = {icons_9, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe48"] = {icons_9, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer48"] = {icons_9, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench48"] = {icons_9, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt48"] = {icons_9, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors48"] = {icons_9, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw48"] = {icons_9, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb48"] = {icons_9, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery48"] = {icons_9, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug48"] = {icons_9, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp48"] = {icons_9, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle48"] = {icons_9, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire48"] = {icons_9, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water48"] = {icons_9, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf49"] = {icons_10, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw49"] = {icons_10, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone49"] = {icons_10, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish49"] = {icons_10, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword49"] = {icons_10, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross49"] = {icons_10, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe49"] = {icons_10, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer49"] = {icons_10, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench49"] = {icons_10, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt49"] = {icons_10, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors49"] = {icons_10, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw49"] = {icons_10, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb49"] = {icons_10, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery49"] = {icons_10, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug49"] = {icons_10, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp49"] = {icons_10, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle49"] = {icons_10, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire49"] = {icons_10, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water49"] = {icons_10, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf50"] = {icons_11, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw50"] = {icons_11, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone50"] = {icons_11, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish50"] = {icons_11, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword50"] = {icons_11, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross50"] = {icons_11, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe50"] = {icons_11, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer50"] = {icons_11, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench50"] = {icons_11, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt50"] = {icons_11, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors50"] = {icons_11, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw50"] = {icons_11, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb50"] = {icons_11, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery50"] = {icons_11, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug50"] = {icons_11, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp50"] = {icons_11, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle50"] = {icons_11, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire50"] = {icons_11, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water50"] = {icons_11, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf51"] = {icons_12, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw51"] = {icons_12, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone51"] = {icons_12, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish51"] = {icons_12, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword51"] = {icons_12, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross51"] = {icons_12, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe51"] = {icons_12, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer51"] = {icons_12, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench51"] = {icons_12, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt51"] = {icons_12, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors51"] = {icons_12, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw51"] = {icons_12, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb51"] = {icons_12, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery51"] = {icons_12, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug51"] = {icons_12, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp51"] = {icons_12, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle51"] = {icons_12, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire51"] = {icons_12, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water51"] = {icons_12, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf52"] = {icons_13, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw52"] = {icons_13, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone52"] = {icons_13, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish52"] = {icons_13, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword52"] = {icons_13, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross52"] = {icons_13, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe52"] = {icons_13, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer52"] = {icons_13, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench52"] = {icons_13, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt52"] = {icons_13, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors52"] = {icons_13, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw52"] = {icons_13, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb52"] = {icons_13, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery52"] = {icons_13, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug52"] = {icons_13, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp52"] = {icons_13, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle52"] = {icons_13, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire52"] = {icons_13, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water52"] = {icons_13, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf53"] = {icons_14, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw53"] = {icons_14, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone53"] = {icons_14, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish53"] = {icons_14, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword53"] = {icons_14, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross53"] = {icons_14, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe53"] = {icons_14, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer53"] = {icons_14, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench53"] = {icons_14, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt53"] = {icons_14, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors53"] = {icons_14, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw53"] = {icons_14, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb53"] = {icons_14, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery53"] = {icons_14, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug53"] = {icons_14, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp53"] = {icons_14, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle53"] = {icons_14, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire53"] = {icons_14, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water53"] = {icons_14, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf54"] = {icons_15, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw54"] = {icons_15, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone54"] = {icons_15, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish54"] = {icons_15, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword54"] = {icons_15, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross54"] = {icons_15, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe54"] = {icons_15, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer54"] = {icons_15, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench54"] = {icons_15, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt54"] = {icons_15, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors54"] = {icons_15, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw54"] = {icons_15, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb54"] = {icons_15, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery54"] = {icons_15, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug54"] = {icons_15, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp54"] = {icons_15, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle54"] = {icons_15, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire54"] = {icons_15, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water54"] = {icons_15, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf55"] = {icons_16, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw55"] = {icons_16, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone55"] = {icons_16, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish55"] = {icons_16, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword55"] = {icons_16, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross55"] = {icons_16, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe55"] = {icons_16, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer55"] = {icons_16, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench55"] = {icons_16, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt55"] = {icons_16, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors55"] = {icons_16, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw55"] = {icons_16, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb55"] = {icons_16, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery55"] = {icons_16, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug55"] = {icons_16, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp55"] = {icons_16, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle55"] = {icons_16, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire55"] = {icons_16, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water55"] = {icons_16, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf56"] = {icons_17, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw56"] = {icons_17, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone56"] = {icons_17, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish56"] = {icons_17, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword56"] = {icons_17, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross56"] = {icons_17, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe56"] = {icons_17, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer56"] = {icons_17, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench56"] = {icons_17, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt56"] = {icons_17, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors56"] = {icons_17, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw56"] = {icons_17, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb56"] = {icons_17, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery56"] = {icons_17, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug56"] = {icons_17, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp56"] = {icons_17, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle56"] = {icons_17, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire56"] = {icons_17, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water56"] = {icons_17, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf57"] = {icons_18, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw57"] = {icons_18, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone57"] = {icons_18, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish57"] = {icons_18, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword57"] = {icons_18, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross57"] = {icons_18, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe57"] = {icons_18, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer57"] = {icons_18, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench57"] = {icons_18, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt57"] = {icons_18, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors57"] = {icons_18, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw57"] = {icons_18, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb57"] = {icons_18, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery57"] = {icons_18, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug57"] = {icons_18, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp57"] = {icons_18, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle57"] = {icons_18, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire57"] = {icons_18, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water57"] = {icons_18, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf58"] = {icons_19, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw58"] = {icons_19, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone58"] = {icons_19, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish58"] = {icons_19, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword58"] = {icons_19, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross58"] = {icons_19, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe58"] = {icons_19, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer58"] = {icons_19, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench58"] = {icons_19, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt58"] = {icons_19, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors58"] = {icons_19, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw58"] = {icons_19, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb58"] = {icons_19, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery58"] = {icons_19, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug58"] = {icons_19, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp58"] = {icons_19, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle58"] = {icons_19, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire58"] = {icons_19, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water58"] = {icons_19, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf59"] = {icons_20, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw59"] = {icons_20, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone59"] = {icons_20, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish59"] = {icons_20, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword59"] = {icons_20, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross59"] = {icons_20, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe59"] = {icons_20, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer59"] = {icons_20, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench59"] = {icons_20, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt59"] = {icons_20, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors59"] = {icons_20, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw59"] = {icons_20, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb59"] = {icons_20, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery59"] = {icons_20, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug59"] = {icons_20, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp59"] = {icons_20, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle59"] = {icons_20, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire59"] = {icons_20, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water59"] = {icons_20, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf60"] = {icons_21, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw60"] = {icons_21, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone60"] = {icons_21, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish60"] = {icons_21, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword60"] = {icons_21, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross60"] = {icons_21, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe60"] = {icons_21, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer60"] = {icons_21, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench60"] = {icons_21, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt60"] = {icons_21, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors60"] = {icons_21, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw60"] = {icons_21, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb60"] = {icons_21, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery60"] = {icons_21, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug60"] = {icons_21, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp60"] = {icons_21, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle60"] = {icons_21, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire60"] = {icons_21, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water60"] = {icons_21, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf61"] = {icons_22, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw61"] = {icons_22, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone61"] = {icons_22, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish61"] = {icons_22, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword61"] = {icons_22, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross61"] = {icons_22, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe61"] = {icons_22, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer61"] = {icons_22, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench61"] = {icons_22, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt61"] = {icons_22, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors61"] = {icons_22, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw61"] = {icons_22, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb61"] = {icons_22, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery61"] = {icons_22, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug61"] = {icons_22, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp61"] = {icons_22, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle61"] = {icons_22, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire61"] = {icons_22, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water61"] = {icons_22, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf62"] = {icons_23, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw62"] = {icons_23, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone62"] = {icons_23, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish62"] = {icons_23, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword62"] = {icons_23, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross62"] = {icons_23, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe62"] = {icons_23, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer62"] = {icons_23, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench62"] = {icons_23, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt62"] = {icons_23, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors62"] = {icons_23, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw62"] = {icons_23, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb62"] = {icons_23, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery62"] = {icons_23, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug62"] = {icons_23, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp62"] = {icons_23, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle62"] = {icons_23, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire62"] = {icons_23, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water62"] = {icons_23, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf63"] = {icons_24, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw63"] = {icons_24, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone63"] = {icons_24, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish63"] = {icons_24, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword63"] = {icons_24, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross63"] = {icons_24, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe63"] = {icons_24, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer63"] = {icons_24, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench63"] = {icons_24, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt63"] = {icons_24, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors63"] = {icons_24, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw63"] = {icons_24, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb63"] = {icons_24, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery63"] = {icons_24, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug63"] = {icons_24, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp63"] = {icons_24, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle63"] = {icons_24, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire63"] = {icons_24, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water63"] = {icons_24, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf64"] = {icons_25, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw64"] = {icons_25, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone64"] = {icons_25, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish64"] = {icons_25, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword64"] = {icons_25, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross64"] = {icons_25, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe64"] = {icons_25, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer64"] = {icons_25, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench64"] = {icons_25, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt64"] = {icons_25, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors64"] = {icons_25, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw64"] = {icons_25, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb64"] = {icons_25, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery64"] = {icons_25, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug64"] = {icons_25, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp64"] = {icons_25, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle64"] = {icons_25, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire64"] = {icons_25, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water64"] = {icons_25, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf65"] = {icons_26, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw65"] = {icons_26, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone65"] = {icons_26, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish65"] = {icons_26, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword65"] = {icons_26, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross65"] = {icons_26, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe65"] = {icons_26, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer65"] = {icons_26, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench65"] = {icons_26, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt65"] = {icons_26, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors65"] = {icons_26, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw65"] = {icons_26, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb65"] = {icons_26, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery65"] = {icons_26, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug65"] = {icons_26, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp65"] = {icons_26, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle65"] = {icons_26, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire65"] = {icons_26, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water65"] = {icons_26, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf66"] = {icons_27, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw66"] = {icons_27, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone66"] = {icons_27, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish66"] = {icons_27, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword66"] = {icons_27, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross66"] = {icons_27, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe66"] = {icons_27, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer66"] = {icons_27, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench66"] = {icons_27, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt66"] = {icons_27, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors66"] = {icons_27, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw66"] = {icons_27, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb66"] = {icons_27, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery66"] = {icons_27, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug66"] = {icons_27, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp66"] = {icons_27, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle66"] = {icons_27, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire66"] = {icons_27, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water66"] = {icons_27, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf67"] = {icons_28, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw67"] = {icons_28, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone67"] = {icons_28, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish67"] = {icons_28, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword67"] = {icons_28, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross67"] = {icons_28, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe67"] = {icons_28, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer67"] = {icons_28, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench67"] = {icons_28, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt67"] = {icons_28, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors67"] = {icons_28, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw67"] = {icons_28, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb67"] = {icons_28, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery67"] = {icons_28, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug67"] = {icons_28, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp67"] = {icons_28, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle67"] = {icons_28, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire67"] = {icons_28, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water67"] = {icons_28, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf68"] = {icons_29, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw68"] = {icons_29, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone68"] = {icons_29, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish68"] = {icons_29, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword68"] = {icons_29, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross68"] = {icons_29, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe68"] = {icons_29, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer68"] = {icons_29, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench68"] = {icons_29, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt68"] = {icons_29, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors68"] = {icons_29, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw68"] = {icons_29, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb68"] = {icons_29, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery68"] = {icons_29, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug68"] = {icons_29, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp68"] = {icons_29, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle68"] = {icons_29, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire68"] = {icons_29, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water68"] = {icons_29, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf69"] = {icons_30, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw69"] = {icons_30, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone69"] = {icons_30, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish69"] = {icons_30, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword69"] = {icons_30, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross69"] = {icons_30, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe69"] = {icons_30, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer69"] = {icons_30, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench69"] = {icons_30, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt69"] = {icons_30, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors69"] = {icons_30, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw69"] = {icons_30, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb69"] = {icons_30, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery69"] = {icons_30, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug69"] = {icons_30, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp69"] = {icons_30, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle69"] = {icons_30, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire69"] = {icons_30, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water69"] = {icons_30, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf70"] = {icons_31, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw70"] = {icons_31, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone70"] = {icons_31, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish70"] = {icons_31, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword70"] = {icons_31, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross70"] = {icons_31, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe70"] = {icons_31, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer70"] = {icons_31, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench70"] = {icons_31, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt70"] = {icons_31, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors70"] = {icons_31, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw70"] = {icons_31, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb70"] = {icons_31, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery70"] = {icons_31, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug70"] = {icons_31, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp70"] = {icons_31, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle70"] = {icons_31, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire70"] = {icons_31, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water70"] = {icons_31, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf71"] = {icons_32, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw71"] = {icons_32, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone71"] = {icons_32, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish71"] = {icons_32, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword71"] = {icons_32, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross71"] = {icons_32, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe71"] = {icons_32, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer71"] = {icons_32, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench71"] = {icons_32, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt71"] = {icons_32, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors71"] = {icons_32, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw71"] = {icons_32, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb71"] = {icons_32, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery71"] = {icons_32, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug71"] = {icons_32, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp71"] = {icons_32, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle71"] = {icons_32, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire71"] = {icons_32, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water71"] = {icons_32, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf72"] = {icons_33, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw72"] = {icons_33, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone72"] = {icons_33, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish72"] = {icons_33, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword72"] = {icons_33, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross72"] = {icons_33, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe72"] = {icons_33, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer72"] = {icons_33, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench72"] = {icons_33, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt72"] = {icons_33, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors72"] = {icons_33, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw72"] = {icons_33, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb72"] = {icons_33, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery72"] = {icons_33, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug72"] = {icons_33, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp72"] = {icons_33, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle72"] = {icons_33, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire72"] = {icons_33, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water72"] = {icons_33, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf73"] = {icons_34, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw73"] = {icons_34, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone73"] = {icons_34, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish73"] = {icons_34, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword73"] = {icons_34, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross73"] = {icons_34, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe73"] = {icons_34, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer73"] = {icons_34, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench73"] = {icons_34, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt73"] = {icons_34, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors73"] = {icons_34, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw73"] = {icons_34, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb73"] = {icons_34, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery73"] = {icons_34, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug73"] = {icons_34, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp73"] = {icons_34, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle73"] = {icons_34, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire73"] = {icons_34, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water73"] = {icons_34, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf74"] = {icons_35, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw74"] = {icons_35, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone74"] = {icons_35, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish74"] = {icons_35, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword74"] = {icons_35, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross74"] = {icons_35, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe74"] = {icons_35, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer74"] = {icons_35, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench74"] = {icons_35, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt74"] = {icons_35, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors74"] = {icons_35, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw74"] = {icons_35, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb74"] = {icons_35, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery74"] = {icons_35, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug74"] = {icons_35, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp74"] = {icons_35, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle74"] = {icons_35, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire74"] = {icons_35, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water74"] = {icons_35, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf75"] = {icons_36, VEC2['0_0'], VEC2['64_64'], 16, 16},
	["paw75"] = {icons_36, VEC2['64_0'], VEC2['128_64'], 16, 16},
	["bone75"] = {icons_36, VEC2['128_0'], VEC2['192_64'], 16, 16},
	["fish75"] = {icons_36, VEC2['192_0'], VEC2['256_64'], 16, 16},
	["sword75"] = {icons_36, VEC2['256_0'], VEC2['320_64'], 16, 16},
	["shield-cross75"] = {icons_36, VEC2['320_0'], VEC2['384_64'], 16, 16},
	["axe75"] = {icons_36, VEC2['384_0'], VEC2['448_64'], 16, 16},
	["hammer75"] = {icons_36, VEC2['448_0'], VEC2['512_64'], 16, 16},
	["wrench75"] = {icons_36, VEC2['512_0'], VEC2['576_64'], 16, 16},
	["nut-and-bolt75"] = {icons_36, VEC2['576_0'], VEC2['640_64'], 16, 16},
	["scissors75"] = {icons_36, VEC2['640_0'], VEC2['704_64'], 16, 16},
	["saw75"] = {icons_36, VEC2['704_0'], VEC2['768_64'], 16, 16},
	["lightbulb75"] = {icons_36, VEC2['768_0'], VEC2['832_64'], 16, 16},
	["battery75"] = {icons_36, VEC2['832_0'], VEC2['896_64'], 16, 16},
	["plug75"] = {icons_36, VEC2['896_0'], VEC2['960_64'], 16, 16},
	["lamp75"] = {icons_36, VEC2['0_64'], VEC2['64_128'], 16, 16},
	["candle75"] = {icons_36, VEC2['64_64'], VEC2['128_128'], 16, 16},
	["fire75"] = {icons_36, VEC2['128_64'], VEC2['192_128'], 16, 16},
	["water75"] = {icons_36, VEC2['192_64'], VEC2['256_128'], 16, 16},
	["leaf
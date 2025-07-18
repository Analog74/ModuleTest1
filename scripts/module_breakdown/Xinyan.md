# Xinyan.luau

```lua
-- Services
local Camera = workspace.CurrentCamera
local Replicated = game:GetService('ReplicatedStorage')
local TweenService = game:GetService('TweenService')
local Debris = game:GetService('Debris')

-- Assets
local Assets = Replicated.Assets
local Particles = Assets.Particles
local Meshes = Assets.Meshes

local Modules = script.Parent.Parent.Parent
local CameraShaker = require(Modules.Auxiliary.CameraShaker)
local BoltModule = require(Modules.Auxiliary.LightningBolt)
local SparksModule = require(Modules.Auxiliary.LightningBolt.LightningSparks)
local RockModule = require(Modules.Auxiliary.RockModule)

-- Functions
local CamShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(CF)
	Camera.CFrame = Camera.CFrame * CF
end)

local function PlaySound(Id, Volume, Parent, Duration)
	local s = Instance.new('Sound')
	s.SoundId = Id
	s.Volume = Volume
	s.Parent = Parent
	s:Play()
	Debris:AddItem(s, Duration or 1)
	return s
end

local function getXAndZPositions(angle, radius)
	local x = math.cos(angle) * radius
	local z = math.sin(angle) * radius
	return x, z
end

CamShake:Start()

return 
	function(...)

	local Parameters = {...}
	local Textures = {'rbxassetid://8313797644', 'rbxassetid://8313742436', 'rbxassetid://8313749259', 'rbxassetid://8313756846', 'rbxassetid://8313761878', 'rbxassetid://8313768156', 'rbxassetid://8313773106', 'rbxassetid://8313780127', 'rbxassetid://8314338712', 'rbxassetid://8314340888', 'rbxassetid://8314344719', 'rbxassetid://8314350294', ''} 
	local Parts = {}
	
	local Charge = Particles.Xinyan.Charge.Attachment:Clone()
	Charge.Parent = Parameters[1]
	Charge.Outline:Emit(1)
```

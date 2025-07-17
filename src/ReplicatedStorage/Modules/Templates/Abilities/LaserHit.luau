-- Services
local Camera = workspace.CurrentCamera
local Replicated = game:GetService('ReplicatedStorage')
local TweenService = game:GetService('TweenService')
local Debris = game:GetService('Debris')

-- Assets
local Assets = Replicated.Assets
local Particles = Assets.Particles

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

CamShake:Start()

return function(...) 
	local Parameters = {...}

	local Hit = Particles.LaserHit:Clone()
	Hit.Position = Parameters[1]
	Hit.Parent = workspace.Effects
	
	TweenService:Create(Hit.Attachment.PointLight, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Brightness = 0}):Play()
	for _, v in ipairs(Hit:GetDescendants()) do
		if v:IsA('ParticleEmitter') then
			v:Emit(v:GetAttribute('EmitCount'))
		end
	end
	Debris:AddItem(Hit, 1)
end

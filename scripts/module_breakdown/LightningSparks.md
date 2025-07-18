# LightningBolt/LightningSparks.luau

```lua
--Adds sparks effect to a Lightning Bolt
local LightningBolt = require(script.Parent)

local ActiveSparks = {}

local rng = Random.new()
local LightningSparks = {}
LightningSparks.__index = LightningSparks

function LightningSparks.new(LightningBolt, MaxSparkCount)
	local self = setmetatable({}, LightningSparks)
	
	--Main (default) properties--
	
		self.Enabled = true --Stops spawning sparks when false
		self.LightningBolt = LightningBolt --Bolt which sparks fly out of
		self.MaxSparkCount = MaxSparkCount or 10 --Max number of sparks visible at any given instance
		self.MinSpeed, self.MaxSpeed = 4, 6 --Min and max PulseSpeeds of sparks
		self.MinDistance, self.MaxDistance = 3, 6 --Governs how far sparks travel away from main bolt
		self.MinPartsPerSpark, self.MaxPartsPerSpark = 8, 10 --Adjustable
	
	--
	
	self.SparksN = 0
	self.SlotTable = {}
	self.RefIndex = #ActiveSparks + 1
	
	ActiveSparks[self.RefIndex] = self
	
	return self
end

function LightningSparks:Destroy()
	ActiveSparks[self.RefIndex] = nil
	
	for i, v in pairs(self.SlotTable) do
		if v.Parts[1].Parent == nil then
			self.SlotTable[i] = nil --Removes reference to prevent memory leak
		end
	end
	
	self = nil
end

function RandomVectorOffset(v, maxAngle) --returns uniformly-distributed random unit vector no more than maxAngle radians away from v
    return (CFrame.lookAt(Vector3.new(), v)*CFrame.Angles(0, 0, rng:NextNumber(0, 2*math.pi))*CFrame.Angles(math.acos(rng:NextNumber(math.cos(maxAngle), 1)), 0, 0)).LookVector
end 

game:GetService("RunService").Heartbeat:Connect(function ()
```

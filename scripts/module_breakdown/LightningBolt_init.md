# LightningBolt/init.luau

```lua
--Procedural Lightning Module. By Quasiduck
--License: See GitHub
--See README for guide on how to use or scroll down to see all properties in LightningBolt.new
--All properties update in real-time except PartCount which requires a new LightningBolt to change
--i.e. You can change a property at any time and it will still update the look of the bolt

local clock = os.clock

local function DiscretePulse(input, s, k, f, t, min, max) --input should be between 0 and 1. See https://www.desmos.com/calculator/hg5h4fpfim for demonstration.
	return math.clamp( (k)/(2*f) - math.abs( (input - t*s + 0.5*(k)) / (f) ), min, max )
end

local function NoiseBetween(x, y, z, min, max)
	return min + (max - min)*(math.noise(x, y, z) + 0.5)
end

local function CubicBezier(p0, p1, p2, p3, t)
	return p0*(1 - t)^3 + p1*3*t*(1 - t)^2 + p2*3*(1 - t)*t^2 + p3*t^3
end

local BoltPart = Instance.new("Part")
BoltPart.TopSurface, BoltPart.BottomSurface = 0, 0
BoltPart.Anchored, BoltPart.CanCollide = true, false
BoltPart.Shape = "Cylinder"
BoltPart.Name = "BoltPart"
BoltPart.CanTouch = false
BoltPart.CastShadow = false
BoltPart.CanQuery = false
BoltPart.Material = Enum.Material.Neon
BoltPart.Color = Color3.new(1, 1, 1)
BoltPart.Transparency = 1

local rng = Random.new()
local xInverse = CFrame.lookAt(Vector3.new(), Vector3.new(1, 0, 0)):inverse()

local ActiveBranches = {}

local LightningBolt = {}
LightningBolt.__index = LightningBolt

--Small tip: You don't need to use actual Roblox Attachments below. You can also create "fake" ones as follows:
--[[
local A1, A2 = {}, {}
A1.WorldPosition, A1.WorldAxis = chosenPos1, chosenAxis1
A2.WorldPosition, A2.WorldAxis = chosenPos2, chosenAxis2
```

# CameraShaker/CameraShakeInstance.luau

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
```

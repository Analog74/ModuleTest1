# RockModule2/Styles.luau

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

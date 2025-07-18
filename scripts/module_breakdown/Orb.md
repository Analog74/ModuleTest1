# Orb.luau

```lua
-- Decompiled with the Synapse X Luau decompiler.

local l__Assets__1 = game:GetService("ReplicatedStorage").Assets;
local l__Meshes__2 = l__Assets__1.Meshes;
local l__Parent__3 = script.Parent.Parent.Parent;
local v4 = require(l__Parent__3.Auxiliary.CameraShaker);
local v5 = require(l__Parent__3.Auxiliary.LightningBolt);
local v6 = require(l__Parent__3.Auxiliary.LightningBolt.LightningSparks);
local v7 = require(l__Parent__3.Auxiliary.RockModule);
local l__CurrentCamera__1 = workspace.CurrentCamera;
local v8 = v4.new(Enum.RenderPriority.Camera.Value, function(p1)
	l__CurrentCamera__1.CFrame = l__CurrentCamera__1.CFrame * p1;
end);
local l__Debris__2 = game:GetService("Debris");
local l__TweenService__3 = game:GetService("TweenService");
v8:Start();
local l__Particles__4 = l__Assets__1.Particles;
local function u5(p2, p3, p4, p5)
	local v9 = Instance.new("NumberValue");
	v9.Value = p2;
	l__TweenService__3:Create(v9, TweenInfo.new(p3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Value = p4
	}):Play();
	l__Debris__2:AddItem(v9, p3);
	if p5 then
		v9.Changed:Connect(function(p6)
			p5.Size = NumberSequence.new(p6);
		end);
	end;
	return v9;
end;
return function(...)
	local v10 = l__Particles__4.Orb.Orb:Clone();
	v10.CFrame = ({ ... })[1].CFrame * CFrame.new(0, 22.5, -35);
	v10.Size = Vector3.new(1, 1, 1);
	v10.Implosion.CFrame = v10.CFrame;
	v10.Lightning.CFrame = v10.CFrame;
	v10.Ground.Position = Vector3.new(v10.Position.X, 0, v10.Position.Z);
	v10.Parent = workspace.Effects;
	local l__Attachment__11 = v10.Attachment;
	local l__Implosion__12 = v10.Implosion;
	l__Attachment__11.Sphere:Emit(75);
	l__TweenService__3:Create(v10, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = Vector3.new(8.5, 8.5, 8.5)
	}):Play();
	l__TweenService__3:Create(v10.Attachment.PointLight, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
		Range = 25
	}):Play();
	local u6 = true;
	local u7 = { { "rbxassetid://8189652665", "", "rbxassetid://8189653993", "rbxassetid://8189655563", "", "rbxassetid://8189656720", "rbxassetid://8189657822", "rbxassetid://8189659765", "rbxassetid://8189661518", "" }, { "rbxassetid://8189970113", "", "rbxassetid://8189983044", "rbxassetid://8189984421", "rbxassetid://8189985650", "rbxassetid://8189986587", "rbxassetid://8189989098", "rbxassetid://8189990246", "" } };
```

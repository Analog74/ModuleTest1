local Queue = {}

local RunService = game:GetService("RunService")

local ancestor = script:FindFirstAncestor("QuickNetwork") 

local Settings = require(ancestor.Settings)
local Signal = require(ancestor.Classes.Signal)
local Constants = require(ancestor.Constants)

local WRITE_COOLDOWN_INTERVAL = Constants.WRITE_COOLDOWN_INTERVAL

local function HeartBeatWait(yield)
	yield = yield or RunService.Heartbeat:Wait()
	local dtPassed = 0

	while true do
		if dtPassed >= yield then
			return dtPassed
		end

		dtPassed += RunService.Heartbeat:Wait()
	end	
end

local function RemoveCallback(queue)
	table.remove(queue.QueuedCallBacks, 1)
	queue.CallBackRemoved:Fire()
end 

function Queue.QueueAPICall(args, callBack)
	local readOnly = args[5]

	if not Settings.ThrottlingProtection or readOnly then
		return callBack(table.unpack(args))
	end

	local dataNetwork = args[1]
	local backup = #args == 3 and args[3] or #args > 3 and args[4]
	local dataStoreName = backup and dataNetwork.BackupDataStore.Name or dataNetwork.DataStore.Name
	local key = #args > 3 and args[2] or #args == 3 and args[2].MetaData.Key
	
	Queue[dataStoreName] = Queue[dataStoreName] or {}

	local callBackFunc = function(...)
		return callBack(...)
	end

	Queue[dataStoreName][key] = Queue[dataStoreName][key] or {
		--[[

			LastWrite = os.time(),
			Callbacks = {},
			CallbackRemoved = Signal.new(),

		]]

		LastWrite = 0,
		QueuedCallBacks = {},
		CallBackRemoved = Signal.new(),
	}

	local queue = Queue[dataStoreName][key]
	queue.CallBackRemoved = Signal.new() 
	local CallbackQueueFinished

	if os.time() - queue.LastWrite >= WRITE_COOLDOWN_INTERVAL and #queue.QueuedCallBacks == 0 then
		table.insert(queue.QueuedCallBacks, callBackFunc)
		
		local args = {callBackFunc(table.unpack(args))}
		queue.LastWrite = os.time()
		RemoveCallback(queue)  -- Remove callback from queue
		
		return table.unpack(args)
	else
		table.insert(queue.QueuedCallBacks, callBackFunc)

		if queue.QueuedCallBacks[1] ~= callBackFunc then
			CallbackQueueFinished = Signal.new()

			queue.CallBackRemoved:Connect(function()
				if queue.QueuedCallBacks[1] == callBackFunc then
					CallbackQueueFinished:Fire()
				end
			end)

			CallbackQueueFinished:Wait()
			CallbackQueueFinished:Disconnect()
		end

		-- Make sure write cooldown has passed to prevent throttling:
		while os.time() - queue.LastWrite < WRITE_COOLDOWN_INTERVAL do
			HeartBeatWait(1)
		end

		local args = {callBackFunc(table.unpack(args))}
		queue.LastWrite = os.time()
		RemoveCallback(queue) -- Remove callback from queue
		
		if #queue.QueuedCallBacks == 0 then
			queue.CallBackRemoved:Disconnect()
		end
		
		return table.unpack(args)
	end
end

return Queue